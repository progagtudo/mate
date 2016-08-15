import mate
import pytest


@pytest.fixture
def tclient(request):
    client = mate.app.test_client()
    return client


def test_hello_world(tclient):
    answer = tclient.get('/')
    assert b'Hello World!' in answer.data


# def test_version(tclient):
#      answer = tclient.get('/version')
#      assert bytes(mate.__version__, 'utf-8') in answer.data
