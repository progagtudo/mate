import json

from flask import request, jsonify

from mate import app
from mate.login.login import auth, AuthType
from mate.model.storage.storage import Storage


@app.route("/retailer/<int:id>/",methods=["GET"])
# ToDo: Check if Client is allowed to list retailers
# @auth(AuthType.client)
def get_retailer():
    """
    returns the retailer
    """
    # ToDO : implement this shit


@app.route("/retailers", methods=["GET"])
# ToDo: Check if Client is allowed to list retailers
# @auth(AuthType.client)
def get_retailers():
    """
    returns a list of retailers
    """
    # ToDo: implement this shit


@app.route("/retailer",methods=["POST"])
# ToDo: Check if Client is allowed to add retailers
# @auth(AuthType.client)
def add_retailer():
    """
    add a new retailer
    """
    # ToDo: implement this shit

@app.route("/retailer/<int:id>/", methods=["PATCH"])
# ToDo: Check if Client is allowed to update retailers
# @auth(AuthType.client)
def update_retailer():
    """
    update the retailer with the id
    """
    # ToDo: implement this shit


@app.route("/retailer/<int:id>/", methods=["DELETE"])
# ToDo: Check if Client is allowed to delete retailers
# @auth(AuthType.client)
def delete_retailer():
    """
    deletes the retailer with the id
    """
