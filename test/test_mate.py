import json
import mate
import os
import psycopg2
import pytest
from mate.helper.config_holder import ConfigHolder


@pytest.fixture(scope="module")
def tclient(request):
    client = mate.app.test_client()
    return client


@pytest.fixture(scope="module")
def plain_db(request):
    print("Connecting to db: " + str(os.environ.get('MATE_TEST_DB_CONFIG')))
    conn = psycopg2.connect(os.environ.get('MATE_TEST_DB_CONFIG'))
    # delete all the things
    cursor = conn.cursor()
    print("Deleting all the things...")
    cursor.execute("""
        DROP SCHEMA public CASCADE;
        CREATE SCHEMA public;
        GRANT ALL ON SCHEMA public TO postgres;
        GRANT ALL ON SCHEMA public TO public;
    """)
    conn.commit()
    print("Reading template...")
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    with conn.cursor() as curs:
        curs.execute(open("dbtemplate.sql", "r", encoding='utf-8').read())
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_READ_COMMITTED)
    yield conn
    conn.close()


@pytest.fixture(scope="module")
def test_db(plain_db):
    plain_db.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    with plain_db.cursor() as curs:
        curs.execute(open("test/sql/test_data.sql", "r", encoding='utf-8').read())
    plain_db.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_READ_COMMITTED)
    os.environ["MATE_DB_CONFIG"] = os.environ.get('MATE_TEST_DB_CONFIG')
    yield plain_db


@pytest.fixture(scope="module")
def client_login(tclient, test_db):
    answer = tclient.get('/login/client/mollys_test_client')
    js = json.loads(answer.data.decode("UTF-8"))
    return js['JWT']


@pytest.fixture(scope="module")
def staff_login(tclient, client_login):
    answer = tclient.get("/login/staff/k2?login_type=password&secret=secret2",
                         headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    return js['JWT']


@pytest.fixture(scope="module")
def customer_login(tclient, client_login):
    answer = tclient.get("/login/customer/k1?login_type=password&secret=secret",
                         headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    return js['JWT']


def test_client_login(client_login, tclient):
    answer = tclient.get("/test/client_auth", headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 200


def test_client_login_wrong_jwt(tclient):
    answer = tclient.get("/test/client_auth", headers={ConfigHolder.jwt_header_client: ""})
    assert answer.status_code == 401
    answer = tclient.get("/test/client_auth")
    assert answer.status_code == 401


def test_failed_client_login(tclient, test_db):
    answer = tclient.get('/login/client/foobar')
    assert answer.data.decode("UTF-8") == "Client Authentication failed"
    assert answer.status_code == 403


def test_customer_login(customer_login, tclient):
    answer = tclient.get("/test/customer_auth", headers={ConfigHolder.jwt_header_customer: customer_login})
    assert answer.status_code == 200


def test_customer_login_wrong_jwt(tclient):
    answer = tclient.get("/test/customer_auth", headers={ConfigHolder.jwt_header_customer: "absoluterFoo"})
    assert answer.status_code == 401
    answer = tclient.get("/test/customer_auth", headers={ConfigHolder.jwt_header_customer: ""})
    assert answer.status_code == 401
    answer = tclient.get("/test/customer_auth")
    assert answer.status_code == 401


def test_failed_customer_login(tclient, client_login):
    answer = tclient.get("/login/customer/k1?secret=secret",
                         headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 403
    assert answer.data.decode("UTF-8") == "Login for user »k1« failed. " \
                                          "Login type »none« is not usable for this user and client combination"

    answer = tclient.get("/login/customer/foo?secret=secret",
                         headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 404
    assert answer.data.decode("UTF-8") == "Could not find user!"

    answer = tclient.get("/login/customer/k1?login_type=password&secret=secret2",
                         headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 403
    assert answer.data.decode("UTF-8") == "Login Failed"

    # ToDo: Add this test once multiple logins per barcode are possible
    # answer = tclient.get("/login/customer/k1?login_type=test&secret=secret",
    #                     headers={ConfigHolder.jwt_header_client: client_login})
    # assert answer.status_code == 400
    # assert answer.data.decode("UTF-8") == "Unknown login type: »test«"


def test_staff_login(staff_login, tclient):
    answer = tclient.get("/test/staff_auth", headers={ConfigHolder.jwt_header_staff: staff_login})
    assert answer.status_code == 200


def test_staff_login_wrong_jwt(tclient):
    answer = tclient.get("/test/staff_auth", headers={ConfigHolder.jwt_header_staff: "AuchAbsoluterFoo"})
    assert answer.status_code == 401
    answer = tclient.get("/test/staff_auth", headers={ConfigHolder.jwt_header_staff: ""})
    assert answer.status_code == 401
    answer = tclient.get("/test/staff_auth")
    assert answer.status_code == 401


def test_failed_staff_login(tclient, client_login):
    answer = tclient.get("/login/staff/k2?secret=secret2",
                         headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 403
    assert answer.data.decode("UTF-8") == "Login for user »k2« failed. " \
                                          "Login type »none« is not usable for this user and client combination"

    answer = tclient.get("/login/staff/foo?login_type=password&secret=secret2",
                         headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 404
    assert answer.data.decode("UTF-8") == "Could not find user!"

    answer = tclient.get("/login/staff/k2?login_type=password&secret=secret",
                         headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.status_code == 403
    assert answer.data.decode("UTF-8") == "Login Failed"

    # ToDo: Add this test once multiple logins per barcode are possible
    # answer = tclient.get("/login/staff/k2?login_type=test&secret=secret2",
    #                     headers={ConfigHolder.jwt_header_client: client_login})
    # assert answer.status_code == 400
    # assert answer.data.decode("UTF-8") == "Unknown login type: »test«"


def test_all_login_types(tclient, client_login):
    answer = tclient.get("/login_types", headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert answer.status_code == 200
    login_type = ['password', 'test']
    assert js["types"] == login_type


def test_hello_world(tclient):
    answer = tclient.get('/')
    assert 'Hello World!' == answer.data.decode("UTF-8")


def test_teapot(tclient):
    answer = tclient.get('/teapot')
    assert 418 == answer.status_code
    assert "I'm a teapot" == answer.data.decode("UTF-8")


def test_version(tclient):
    answer = tclient.get('/version')
    assert mate.__version__ == answer.data.decode('utf-8')


def test_login_types(tclient, client_login):
    answer = tclient.get("/login_types/k1", headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert answer.status_code == 200
    types = {
        "staff": [],
        "customer": ['password']
    }
    assert js["types"] == types

    answer = tclient.get("/login_types/k2", headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert answer.status_code == 200
    types = {
        "staff": ['password'],
        "customer": []
    }
    assert js["types"] == types


def test_failed_login_types(tclient, client_login):
    answer = tclient.get("/login_types/2", headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.data.decode("UTF-8") == "Could not find user!"
    assert answer.status_code == 404


def test_specific_login_types(tclient, client_login):
    answer = tclient.get("/login_types/k2/customer", headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert answer.status_code == 200
    assert js["types"] == []

    answer = tclient.get("/login_types/k2/staff", headers={ConfigHolder.jwt_header_client: client_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert answer.status_code == 200
    assert js["types"] == ['password']


def test_failed_specific_login_types(tclient, client_login):
    answer = tclient.get("/login_types/k2/foo", headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.data.decode("UTF-8") == "Wrong type supplied. Valid values: customer, staff"
    assert answer.status_code == 400

    answer = tclient.get("/login_types/2/customer", headers={ConfigHolder.jwt_header_client: client_login})
    assert answer.data.decode("UTF-8") == "Could not find user!"
    assert answer.status_code == 404


def test_db_create(plain_db):
    print("DB created")


def test_failed_barcode(tclient, client_login, staff_login):
    answer = tclient.get('/barcode/foobar',
                         headers={ConfigHolder.jwt_header_client: client_login,
                                  ConfigHolder.jwt_header_staff: staff_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert js['customer'] == "null"
    assert js['product'] == "null"
    assert answer.status_code == 200

    answer = tclient.get('/barcode/',
                         headers={ConfigHolder.jwt_header_client: client_login,
                                  ConfigHolder.jwt_header_staff: staff_login})
    assert answer.status_code == 404


def test_get_product_from_barcode(tclient, client_login, staff_login):
    answer = tclient.get('/barcode/p1',
                         headers={ConfigHolder.jwt_header_client: client_login,
                                  ConfigHolder.jwt_header_staff: staff_login})
    js = json.loads(answer.data.decode("UTF-8"))
    assert js['customer'] == "null"
    product = {
        "name": "Club Mate 0,5l",
        "price": "0.90",
        "product_id": 1,
        "tags": [
            [
                "koffeinhaltig",
                "enthält Koffein"
            ]
        ]
    }
    assert js['product'] == product


def test_customer_from_barcode(tclient, client_login, staff_login):
    answer = tclient.get('/barcode/k1', headers={ConfigHolder.jwt_header_client: client_login,
                                                 ConfigHolder.jwt_header_staff: staff_login})
    js = json.loads(answer.data.decode('utf-8'))
    assert js['product'] == "null"
    customer = {
        "active": True,
        "email": "test@example.com",
        "first_name": "Sternhard",
        "id": 1,
        "last_name": "Beffen",
        "needs_balance_auth": False
    }
    assert js['customer'] == customer


def test_customer_balance(tclient, client_login, staff_login, customer_login):
    answer = tclient.get('/customer/1/balance', headers={ConfigHolder.jwt_header_client: client_login,
                                                         ConfigHolder.jwt_header_staff: staff_login,
                                                         ConfigHolder.jwt_header_customer: customer_login})
    js = json.loads(answer.data.decode('utf-8'))
    assert js["value"] == '20.00'
    assert answer.status_code == 200


def test_failed_customer_balance(tclient, client_login, staff_login, customer_login):
    answer = tclient.get('/customer/2/balance', headers={ConfigHolder.jwt_header_client: client_login,
                                                         ConfigHolder.jwt_header_staff: staff_login,
                                                         ConfigHolder.jwt_header_customer: customer_login})
    assert answer.data.decode('utf-8') == "Customer is not valid"
    assert answer.status_code == 403
