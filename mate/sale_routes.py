import json

from flask import request, jsonify

from mate import app
from mate.login.login import auth, AuthType
from mate.model.person.customer import Customer
from mate.model.products.sale_product import SaleProduct


@app.route("/getBarcode", methods=["GET"])
@auth(AuthType.salesp)
def get_barcode():
    barcode = request.headers.get('code')
    print("hallo")
    if barcode != None:
        print("barcode: " + barcode)
        # ToDo: find customer
        customer = Customer.dummy().to_primitive('customer')
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
        return "No Barcode", 400


@app.route("/getBalance", methods=["GET"])
@auth(AuthType.salesp)
@auth(AuthType.customer)
def get_balance():
    customer = Customer.dummy().to_primitive('balance')
    pass
