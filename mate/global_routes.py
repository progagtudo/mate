from mate import app, __version__
from mate.login.login import auth, AuthType


@app.route('/')
def hello_world():
    """Return 'Hello World!' on every Request."""
    return 'Hello World!'


@app.route('/version')
def version():
    """Returns API-Version"""
    return __version__


@app.route("/test/client_auth")
@auth(AuthType.client)
def test_client_auth():
    return "",200


@app.route("/test/customer_auth")
@auth(AuthType.customer)
def test_customer_auth():
    return "",200


@app.route("/test/staff_auth")
@auth(AuthType.staff)
def test_staff_auth():
    return "",200


@app.route('/teapot')
def teapot():
    """Return HTTP Error 418"""
    return "I'm a teapot", 418
