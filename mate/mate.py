from . import app, __version__

@app.route('/')
def hello_world():
    """Return 'Hello World!' on every Request."""
    return 'Hello World!'

@app.route('/version')
def version():
    """Returns API-Version"""
    return __version__

if __name__ == '__main__':
    app.run()
