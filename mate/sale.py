import json

from flask import request, jsonify

from mate import app
from mate.login.login import auth, AuthType
from mate.model.customer_modul import Customer


@app.route("/getBarcode", methods=["GET"])
#@auth(AuthType.salesp)
def get_barcode():
    barcode = request.headers.get('code')
    print("hallo")
    if(barcode != None):
        print("barcode: "+barcode)
        # ToDo: find customer
        # ToDo: find product
        # DELETE this when ToDo is
        return jsonify(Customer.dummy())
        #return "Okay"
        # DELETE END
    else:
        return "No Barcode", 400
