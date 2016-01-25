import mate
import pytest


@pytest.fixture
def client(request):
    client = mate.app.test_client()
    return client


def test_hello_world(client):
    answer = client.get('/')
    assert b'Hello World!' in answer.data
