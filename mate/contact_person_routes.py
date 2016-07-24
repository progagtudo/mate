import json

from flask import request, jsonify

from mate import app
from mate.model.retailer.contact_person import ContactPerson


@app.route("/contact_person/<int:cperson_id>", methods=["GET"])
# ToDo: Check if Client is allowed to list contact persons
# @auth(AuthType.client)
def get_contact_person(cperson_id):
    """
    returns the contact persons
    """
    # ToDo : implement this shit
    # ToDo: find the id in the db


@app.route("/contact_persons", methods=["GET"])
# ToDo: Check if Client is allowed to list contact persons
# @auth(AuthType.client)
def get_contact_persons():
    """
    returns the contact persons
    """
    limit = request.args.get("limit", 20, type=int)
    offset = request.args.get("offset", 0, type=int)

    next_link = "/contact_persons?limit{0}&offset={1}".format(limit, (offset + limit))
    previous = None
    if (offset - limit) >= 0:
        previous = "contact_persons?limit={0}&offset={1}".format(limit, (offset - limit))
    # ToDo: Generate JSON and return
    response = {
        "next": next_link,
        "previous": previous,
        "contact_persons": []
    }


@app.route("/contact_person/", methods=["POST"])
# ToDo: Check if Client is allowed to add contact persons
# @auth(AuthType.client)
def add_contact_person():
    """
    add a new contact person
    """
    data = request.json
    print("test")
    a_contact_person = ContactPerson.from_json_new_object(json.loads(data))
    # ToDo: create storage in DB
    return jsonify(a_contact_person)


@app.route("/contact_person/<int:cperson_id>", methods=["PATCH"])
# ToDo: Check if Client is allowed to update contact persons
# @auth(AuthType.client)
def update_contact_person(cperson_id):
    """
    updates the contact person
    """
    # check contact_person id
    data = request.data
    # validate(data, contact_person_modul, json_scheme_new_object)
    a_contact_person = ContactPerson.from_json_new_object(json.loads(data))
    # ToDo: update contact Persons
    return jsonify(a_contact_person)


@app.route("/contact_person/<int:person_id>", methods=["DELETE"])
# ToDo: Check if Client is allowed to delete contact persons
# @auth(AuthType.client)
def delete_contact_person(person_id):
    """
    deletes the contact person
    """
    assert id is int
    # ToDo: delete storage
