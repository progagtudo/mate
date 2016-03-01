from flask import jsonify, request

from mate import app
from mate.model.stub_login_type_holder import StubLoginTypeHolder
from mate.login.stub_verifier import StubVerifier

stub_login_type_holder = StubLoginTypeHolder()


@app.route("/login_types/<username>")
def login_types(username):
    if username in stub_login_type_holder.login_types :
        return jsonify({"types": stub_login_type_holder.login_types[username]})
    else:
        return "OMFG!", 500

@app.route("/login_types/<username>")
def login_types2(username):
    if username in stub_login_type_holder.login_types :
        return jsonify({"types": stub_login_type_holder.login_types[username]})
    else:
        print("2!")
        return "2!", 501


@app.route("/login/customer")
def login_customer():
    if StubVerifier.verify(request.headers.get('MATE-Client-Auth')):
        # Do something with content
        print("WARNING: Not doing anything useful!")
        return jsonify({"JWT": "fubar"})
    else:
        return "", 403
