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
        curs.execute(open("dbtemplate.sql", "r").read())
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_READ_COMMITTED)
    yield conn
    conn.close()


@pytest.fixture(scope="module")
def test_db(plain_db):
    plain_db.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    with plain_db.cursor() as curs:
        curs.execute(open("test/sql/test_data.sql", "r").read())
    plain_db.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_READ_COMMITTED)
    os.environ["MATE_DB_CONFIG"] = os.environ.get('MATE_TEST_DB_CONFIG')
    yield plain_db


@pytest.fixture(scope="module")
def client_login(tclient, test_db):
    answer = tclient.get('/login/client/mollys_test_client')
    js = json.loads(answer.data.decode("UTF-8"))
    return js['JWT']


def test_hello_world(tclient):
    answer = tclient.get('/')
    assert b'Hello World!' == answer.data


def test_teapot(tclient):
    answer = tclient.get('/teapot')
    assert 418 == answer.status_code
    assert b"I'm a teapot" == answer.data


def test_db_create(plain_db):
    print("DB created")


def test_get_product_from_barcode(tclient, test_db, client_login):
    answer = tclient.get('/barcode/p1', headers={ConfigHolder.jwt_header_client: client_login})
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

# def test_version(tclient):
#      answer = tclient.get('/version')
#      assert bytes(mate.__version__, 'utf-8') in answer.data
