import psycopg2

from mate.login.login import auth, AuthType
from mate.model.cart.cart import Cart
from . import app, __version__

# DO NOT REMOVE !!
# noinspection PyUnresolvedReferences
from mate import storage_routes, sale_routes
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

@app.route('/teapot')
def teapot():
    """Return HTTP Error 418"""
    return "I'm a teapot", 418

def init_db_conn():
    print("Initializing DB connection...")
    # app.g.db = psycopg2.connect("dbname=mate user=postgres")


def startup():
    init_db_conn()
    app.run()


if __name__ == '__main__':
    startup()
