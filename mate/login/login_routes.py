from datetime import datetime, timedelta

import jwt
from flask import jsonify

from mate import app
from mate.helper.config_holder import ConfigHolder
from mate.login.login import stub_login_type_holder, auth, AuthType, validate_client_login


@app.route("/login_types/<string:username>/string:user_type")
@auth(AuthType.client)
def login_types(username: str, user_type: str):
    """ This method searches the available login types for the given user, user type (customer or staff) and client"""

    # Return an error if the client specified a wrong user type
    if user_type not in ["customer", "staff"]:
        return "Wrong type supplied. Valid values: customer, staff", 400
    # Find username in DB and search for applicable login types for given user, type and client combination
    # SELECT act.Name AS CredentialTypeName
    #   FROM mate.ClientType    AS clt
    #   JOIN mate.CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
    #   JOIN mate.Credentials   AS c  ON cu.CredentialID  = c.CredentialID
    #   JOIN mate.AvailableCredentialTypes AS act ON c.CredentialType = act.CredentialType
    #   WHERE clt.ClientType         = ?
    #     AND   c.CredentialKey      = ?
    #     AND   c.IsSalesPersonLogin = ?
    #

    # TODO: implement actual DB logic
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
