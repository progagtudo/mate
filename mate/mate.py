import os
from mate.db.postgres_db import PostgresDB
from . import app
from flask import g


def connect_db():
    """Connects to the specific database."""
    default_configstring= "dbname=mate user=postgres password=N8drVVgfidBjLuwd74 host=localhost port=9000"
    db = PostgresDB(os.environ.get('MATE_DB_CONFIG', default_configstring))
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
