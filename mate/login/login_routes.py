from datetime import datetime, timedelta

import jwt
from flask import jsonify

from mate import app
from mate.helper.config_holder import ConfigHolder
from mate.login.login import stub_login_type_holder, auth, AuthType, validate_client_login


@app.route("/login_types/<username>")
def login_types(username):
    if username in stub_login_type_holder.login_types:
        return jsonify({"types": stub_login_type_holder.login_types[username]})
    else:
        return "Could not find user!", 500


@app.route("/login/customer")
@auth(AuthType.client)
def login_customer():
    # TODO: replace with customer verifier!
    if True:  # StubVerifier.verify(request.headers.get('MATE-Client-Auth')):
        # Do something with content
        print("WARNING: Not doing anything useful!")
        token = jwt.encode({"exp": datetime.utcnow() + timedelta(hours=1), "sub": "clnt"}, "SECRET")
        return jsonify({"JWT": token.decode("utf-8")})
    else:
        return "", 403


@app.route("/login/client")
def login_client():
    # TODO: replace with client verifier!
    # This currently always returns a valid token
    if validate_client_login():
        # Do something with content
        print("WARNING: Not doing anything useful!")
        # TODO: this should contain the correct client type and permissions
        token = jwt.encode({
            "exp": datetime.utcnow() + timedelta(hours=1),
            "sub": "clnt",
            "nbf": datetime.utcnow(),
            "mate.tpe": "dummyclient",
            "mate.prm": ""}, ConfigHolder.jwt_secret_client)
        return jsonify({"JWT": token.decode("utf-8")})
    else:
        return "", 403
