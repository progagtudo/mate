from mate.model.cart.cart import Cart
from mate.login.login import auth
from . import app, __version__
from mate import storage


from . import login

@app.route('/')
def hello_world():
    """Return 'Hello World!' on every Request."""
    return 'Hello World!'

@app.route('/version')
@auth
def version():
    """Returns API-Version"""
    return __version__

if __name__ == '__main__':
    print(Cart.json_scheme)
    app.run()
