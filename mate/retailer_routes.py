import json

from flask import request, jsonify

from mate import app
from mate.login.login import auth, AuthType
from mate.model.retailer.retailer import Retailer


@app.route("/retailer/<int:id>/", methods=["GET"])
# ToDo: Check if Client is allowed to list retailers
# @auth(AuthType.client)
def get_retailer(id):
    """
    returns the retailer
    """
    # ToDO : implement this shit
    # ToDo: find the id in the db


@app.route("/retailers", methods=["GET"])
# ToDo: Check if Client is allowed to list retailers
# @auth(AuthType.client)
def get_retailers():
    """
    returns a list of retailers
    """
    limit = request.args.get("limit", 20, type=int)
    offset = request.args.get("offset", 0, type=int)

    next_link = "/retailers?limit{0}&offset={1}".format(limit, (offset + limit))
    previous = None
    if(offset - limit) >= 0:
        previous = "retailers?limit={0}&offset={1}".format(limit, (offset - limit))
    # ToDo: Generate JSON and return
    response = {
        "next": next_link,
        "previous": previous,
        "retailers": []
    }

    return jsonify(response)


@app.route("/retailer",methods=["POST"])
# ToDo: Check if Client is allowed to add retailers
# @auth(AuthType.client)
def add_retailer():
    """
    add a new retailer
    """
    data = request.json
    print("test")
    a_retailer = Retailer.from_json_new_object(json.loads(data))
    # ToDo: create storage in DB
    a_retailer.id = 12  # ToDo add id from DB to Object.
    print("added stub id to retailer")  # remove print when ToDo is done
    return jsonify(a_retailer)


@app.route("/retailer/<int:id>/", methods=["PATCH"])
# ToDo: Check if Client is allowed to update retailers
# @auth(AuthType.client)
def update_retailer(id):
    """
    update the retailer with the id
    """
    # check_storage_id(storage_id)
    print("test")
    data = request.data
    # validate(data, retaile_modul.json_scheme_new_object)
    a_retailer = Retailer.from_json_new_object(json.loads(data))
    a_retailer.id = id
    # ToDo: check if storage exists in DB
    # ToDo: update Retailer


@app.route("/retailer/<int:id>/", methods=["DELETE"])
# ToDo: Check if Client is allowed to delete retailers
# @auth(AuthType.client)
def delete_retailer(id):
    """
    deletes the retailer with the id
    """
    assert id is int
    #ToDo: delete storage
