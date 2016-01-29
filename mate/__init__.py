from flask import Flask

__version__ = '0.0.0'

app = Flask(__name__)
from . import mate