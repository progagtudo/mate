from flask import jsonify

from mate import app
from mate.login.login import auth, AuthType
from mate.model.person.customer import Customer
from mate.model.products.sale_product import SaleProduct
from mate.db.postgres_db import PostgresDB


@app.route("/barcode/<string:code>", methods=["GET"])
@auth(AuthType.client)
@auth(AuthType.salesp)
def get_barcode(code):
    if code is not None:
        print("barcode: " + code)
        # ToDo: find customer
        if PostgresDB.check_if_user_exists(code):
            customer = Customer.from_barcode(code).to_primitive('customer')
        #customer = Customer.dummy().to_primitive('customer')
        # ToDo: find product
        product_obj = SaleProduct.dummy()
        product = "null"
        if product_obj.is_saleable():
            product = product_obj.to_primitive('sale_product')
        return jsonify({
            "customer": customer,
            "product": product
        })
    else:
        return "No Barcode provided", 400


@app.route("/customer/<int:customer_id>/balance", methods=["GET"])
@auth(AuthType.client)
@auth(AuthType.salesp)
@auth(AuthType.customer)
def get_balance(customer_id):
    valid_customer = False
    # TODO check customer JWT
    if not valid_customer:
        return "Customer is not valid", 403

    # TODO find customer balance
    balance = Customer.dummy().to_primitive('balance')
    return jsonify({
        "value": balance
    })


@app.route("/sale/sellCart")
@auth(AuthType.client)
@auth(AuthType.salesp)
@auth(AuthType.customer)
def get_sellcart():
    success = False
    # TODO get auth and cart from JWT
    if not success:
        # TODO return fixed cart on error
        pass
