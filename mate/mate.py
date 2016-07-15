import psycopg2

from mate.db.postgres_db import PostgresDB
from mate.login.login import auth, AuthType
from mate.model.cart.cart import Cart
from . import app, __version__
from flask import g


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


def connect_db():
    """Connects to the specific database."""
    db = PostgresDB("dbname=mate user=postgres password=N8drVVgfidBjLuwd74 host=localhost port=9000")
    return db


def init_db():
    """Initializes the database."""
    # TODO Create initial database here!
    pass

#
# @app.cli.command('initdb')
# def initdb_command():
#     """Creates the database tables."""
#     init_db()
#     print('Initialized the database.')


def get_db():
    """Opens a new database connection if there is none yet for the
    current application context.
    """
    if not hasattr(g, 'db'):
        g.db = connect_db()
    return g.db


@app.teardown_appcontext
def close_db(error):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'db'):
        g.db.close()
