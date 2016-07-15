import json
from datetime import datetime, timedelta

import jwt
from flask import jsonify
from flask import request

from mate import app
from mate.helper.config_holder import ConfigHolder
from mate.login.login import stub_login_type_holder, auth, AuthType, validate_client_login
from mate.mate import get_db


# noinspection SqlResolve
@app.route("/login_types/<string:username>/<string:user_type>")
@auth(AuthType.client)
def login_types(username: str, user_type: str):
    """ This method searches the available login types for the given user, user type (customer or staff) and client"""

    # Return an error if the client specified a wrong user type
    if user_type not in ["customer", "staff"]:
        return "Wrong type supplied. Valid values: customer, staff", 400
    # Find username in DB and search for applicable login types for given user, type and client combination


    # Check if the user exists

    if get_db().check_if_user_exists(username):
        return "Could not find user!", 404
    client_name = jwt.decode(request.headers.get(ConfigHolder.jwt_header_client), key=ConfigHolder.jwt_secret_client)[
        'mate.tpe']

    return jsonify({"types": get_db().get_login_types(client_name, username, user_type == 'staff')})


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
        # TODO: mate.prm should contain array of permissions
        token = jwt.encode({
            "exp": datetime.utcnow() + timedelta(hours=24),
            "sub": "clnt",
            "nbf": datetime.utcnow(),
            "mate.tpe": "dummyclient",
            "mate.prm": ""}, ConfigHolder.jwt_secret_client)
        return jsonify({"JWT": token.decode("utf-8")})
    else:
        return "Client Authentication failed", 403
