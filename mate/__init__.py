from flask import Flask

__version__ = '0.0.0'

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
import logging
file_handler = logging.FileHandler('mate.log')
file_handler.setLevel(logging.INFO)
app.logger.addHandler(file_handler)
import mate.mate
from mate import storage_routes, sale_routes, contact_person_routes, retailer_routes, global_routes
from mate.login import login_routes
