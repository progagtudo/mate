import json

from flask import request, jsonify

from mate import app
from mate.model.products.sale_product import SaleProduct
from mate.model.storage.storage import Storage


def check_storage_id(storage_id):
    print("test")
    print(type(storage_id))
    assert storage_id is int
    if storage_id < 0:
        print("storage_id is to low")
        return "storage_id is to low", 500
    else:
        pass


@app.route("/storages", methods=["GET"])
# ToDo: Check if Client is allowed to list storages
# @auth(AuthType.client) #TODO
def list_storage():
    """
    list all storages
    limit:  amount of requested storages
    offset: start point
    """
    limit = request.args.get("limit", 20, type=int)
    offset = request.args.get("offset", 0, type=int)

    next_link = "/storages?limit={0}&offset={1}".format(limit, (offset + limit))
    previous = None
    if (offset - limit) >= 0:
        previous = "/storages?limit={0}&offset={1}".format(limit, (offset - limit))
    elif offset > 0:
        previous = "/storages?limit={0}&offset={1}".format(offset, 0)
    # ToDo: Generate JSON and return
    storages = Storage.request_multi_from_db(offset=offset, limit=limit)
    response = {
        "next": next_link,
        "previous": previous,
        "storages": storages
    }
    return jsonify(response), 200


@app.route("/storage/", methods=["POST"])
# @auth #TODO
def add_storage():
    """
    add a new storage
    :return: new storage
    """
    data = request.json
    print("test12")
    a_storage = Storage.from_json_new_object(json.loads(data))
    # TODO: create storage in DB
    a_storage.storage_id = 12 # TODO: add id from DB to Object.
    print("added stub id to storage") # remove print when ToDo is done
    return jsonify(a_storage)


@app.route("/storage/<int:storage_id>", methods=["GET"])
# @auth #TODO
def get_storage_info(storage_id: int):

    a_storage = Storage.request_from_db(storage_id)
    if a_storage is None:
        return "Requested storage with id {} does not exist".format(storage_id), 404
    else:
        return jsonify(a_storage), 200


@app.route("/storage/<int:storage_id>", methods=["PATCH"])
# @auth #TODO
def update_storage(storage_id):
    #check_storage_id(storage_id)
    print("test")
    data = request.data
    #validate(data, storage_modul.json_scheme_new_object)
    a_storage = Storage.from_json_new_object(json.loads(data))
    a_storage.storage_id = storage_id
    # TODO: check if storage exists in DB
    # TODO: update storage
    return jsonify(a_storage)


@app.route("/storage/<int:storage_id>", methods=["DELETE"])
# @auth #TODO
def delete_storage(storage_id: int):
    a_storage = Storage.request_from_db(storage_id)
    if a_storage is None:
        return "Requested storage with id {} does not exist".format(storage_id), 404
    else:
        result = Storage.delete_instance_in_db(storage_id=storage_id)
        if result:
            return "", 204
        else:
            return "Cannot delete storage: Storage not empty", 412


@app.route("/storage/<int:storage_id>/products", methods=["GET"])
# @auth #TODO
def product_storage(storage_id: int):
    product_type = request.args.get("product_type", "", type=str)  # TODO: find reasonable standard value
    limit = request.args.get("limit", 20, type=int)
    offset = request.args.get("offset", 0, type=int)


    next_link = "/storage/{0}/products?product_type={1}&limit={2}&offset={3}".format(
        storage_id, product_type, limit, (offset + limit))
    previous_link = None
    if (offset - limit) >= 0:
        previous_link = "/storage/{0}/products?product_type={1}&limit={2}&offset={3}".format(
            storage_id, product_type, limit, (offset - limit))
    elif offset > 0:
        previous_link = "/storage/{0}/products?product_type={1}&limit={2}&offset={3}".format(
            storage_id, product_type, offset, 0)

    products = [SaleProduct.dummy(), SaleProduct.dummy()]  # TODO: Find Products in Storage via DB

    response = {
        "next": next_link,
        "previous": previous_link,
        "products": products
    }

    return jsonify(response), 200

