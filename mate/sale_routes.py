import jwt
from flask import json
from flask import jsonify
from flask import request

from mate import app
from mate.helper.config_holder import ConfigHolder
from mate.login.login import auth, AuthType
from mate.mate import get_db
from mate.model.person.customer import Customer
from mate.model.products.sale_product import SaleProduct
from mate.db.postgres_db import PostgresDB


@app.route("/barcode/<string:code>", methods=["GET"])
@auth(AuthType.client)
@auth(AuthType.staff)
def get_barcode(code):
    if code is not None:
        app.logger.info("/barcode/" + code + " found.")
        # ToDo: find customer
        customer = "null"
        customer_obj = Customer.from_barcode(code)
        if customer_obj.active:
            customer = customer_obj.to_primitive('customer')
        # customer = Customer.dummy().to_primitive('customer')
        # ToDo: find product
        product_obj = SaleProduct.from_barcode(code)
        product = "null"
        if product_obj.is_sale_allowed:
            product = product_obj.to_primitive('sale_product')
        return jsonify({
            "customer": customer,
            "product": product
        })
    else:
        return "No Barcode provided", 400


@app.route("/customer/<int:customer_id>/balance", methods=["GET"])
@auth(AuthType.client)
@auth(AuthType.staff)
@auth(AuthType.customer)
def get_balance(customer_id):
    customer_jwt = jwt.decode(request.headers.get(ConfigHolder.jwt_header_customer), ConfigHolder.jwt_secret_customer)
    if customer_id != customer_jwt['mate.pid']:
        return "Customer is not valid", 403

    # TODO find customer balance
    balance = Customer.from_id(customer_id).to_primitive('balance')
    return jsonify({
        "value": balance['base_balance']
    })


@app.route("/sale/sell_cart", methods=["POST"])
@auth(AuthType.client)
@auth(AuthType.staff)
@auth(AuthType.customer)
def get_sellcart():
    success = False
    cart = request.json
    # TODO get auth and cart from JWT
    if not success:
        # TODO return fixed cart on error
        pass
