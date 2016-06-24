import json

from flask import request, jsonify

from mate import app
from mate.login.login import auth, AuthType
from mate.model.storage.storage import Storage


@app.route("/contact_person/<int:id>", methods=["GET"])
# ToDo: Check if Client is allowed to list contact persons
# @auth(AuthType.client)
def get_contact_person():
    """
    returns the contact persons
    """
    # ToDo : implement this shit


@app.route("/contact_person", methods=["GET"])
# ToDo: Check if Client is allowed to list contact persons
# @auth(AuthType.client)
def get_contact_persons():
    """
    returns the contact persons
    """
    # ToDo: implement this shit


@app.route("/contact_person/", methods=["POST"])
# ToDo: Check if Client is allowed to add contact persons
# @auth(AuthType.client)
def add_contact_person():
    """
    add a new contact person
    """
    # ToDo: implement this shit


@app.route("/contact_person/<int:id>", methods=["PATCH"])
# ToDo: Check if Client is allowed to update contact persons
# @auth(AuthType.client)
def update_contact_person():
    """
    updates the contact person
    """
    # ToDo: implement this shit



@app.route("/contact_person/<int:id>", methods=["DELETE"])
# ToDo: Check if Client is allowed to delete contact persons
# @auth(AuthType.client)
def delete_contact():
    """
    deletes the contact person
    """
    # ToDo: implement this shit
