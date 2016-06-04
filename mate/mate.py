from mate.login.login import auth, AuthType
from mate.model.cart.cart import Cart
from . import app, __version__

# DO NOT REMOVE !!
# noinspection PyUnresolvedReferences
from mate import storage, sale
# noinspection PyUnresolvedReferences
from mate.login import login_routes
# DO NOT REMOVE


@app.route('/')
def hello_world():
    """Return 'Hello World!' on every Request."""
    return 'Hello World!'


@app.route('/version')
@auth(AuthType.client)
def version():
    """Returns API-Version"""
    return __version__

if __name__ == '__main__':
    print(Cart.json_scheme)
    app.run()
