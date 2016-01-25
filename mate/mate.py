from . import app

@app.route('/')
def hello_world():
    """Return 'Hello World!' on every Request."""
    return 'Hello World!'


if __name__ == '__main__':
    app.run()
