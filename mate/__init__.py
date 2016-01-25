from flask import Flask

app = Flask(__name__)
from . import mate

__version__ = '0.0.0'