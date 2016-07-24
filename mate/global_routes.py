from mate import app, __version__
from mate.login.login import auth, AuthType


@app.route('/')
def hello_world():
    """Return 'Hello World!' on every Request."""
    return 'Hello World!'


@app.route('/version')
@auth(AuthType.client)
def version():
    """Returns API-Version"""
    return __version__


@app.route('/teapot')
def teapot():
    """Return HTTP Error 418"""
    return "I'm a teapot", 418
