from datetime import datetime, timedelta

import jwt
from flask import jsonify
from flask import request

from mate import app
from mate.helper.config_holder import ConfigHolder
from mate.login.login import auth, AuthType, validate_client_login
from mate.login.user_auth.password_user_authenticator import PasswordUserAuthenticator
from mate.mate import get_db


@app.route("/login_types")
@auth(AuthType.client)
def all_login_types():
    """ This method returns all available login types."""
    db = get_db()
    result = db.get_all_login_types
    return jsonify({"types": result})


@app.route("/login_types/<string:username>")
@auth(AuthType.client)
def person_login_types(username: str):
    """ This method searches the available login types for the given user and client"""

    # Find username in DB and search for applicable login types for given user, type and client combination

    # Check if the user exists

    if not get_db().check_if_user_exists(username):
        return "Could not find user!", 404
    client_name = jwt.decode(request.headers.get(ConfigHolder.jwt_header_client), key=ConfigHolder.jwt_secret_client)[
        'mate.tpe']
    login_type_list_staff = get_db().get_login_types(client_name, username, True)
    login_type_list_customer = get_db().get_login_types(client_name, username, False)
    return jsonify({"types": {
        "salesperson": login_type_list_staff,
        "customer": login_type_list_customer
    }})


@app.route("/login_types/<string:username>/<string:user_type>")
@auth(AuthType.client)
def login_types(username: str, user_type: str):
    """ This method searches the available login types for the given user, user type (customer or staff) and client"""

    # Return an error if the client specified a wrong user type
    if user_type not in ["customer", "staff"]:
        return "Wrong type supplied. Valid values: customer, staff", 400
    # Find username in DB and search for applicable login types for given user, type and client combination


    # Check if the user exists

    if not get_db().check_if_user_exists(username):
        return "Could not find user!", 404
    client_name = jwt.decode(request.headers.get(ConfigHolder.jwt_header_client), key=ConfigHolder.jwt_secret_client)[
        'mate.tpe']
    login_type_list = get_db().get_login_types(client_name, username, user_type == 'staff')
    return jsonify({"types": login_type_list})


@app.route("/login/customer/<string:username>")
@auth(AuthType.client)
def login_customer(username: str):
    # TODO: replace with customer verifier!
    # Do something with content
    db = get_db()
    success = False
    client_name = jwt.decode(request.headers.get(ConfigHolder.jwt_header_client),
                             key=ConfigHolder.jwt_secret_client)['mate.tpe']
    secret = request.args.get("secret")
    login_type = request.args.get("login_type")
    if login_type is None:
        login_type = "none"

    if not db.check_if_user_exists(username):
        return "Could not find user!", 404

    login_type_list = get_db().get_login_types(client_name=client_name, username=username, is_staff=False)
    if login_type not in login_type_list:
        return "Login for user »{}« failed. " \
               "Login type »{}« is not usable for this user and client combination".format(username, login_type), \
               403

    authenticator = None
    # TODO: Refactor by using a dict for the authenticator lookup
    if login_type == "password":
        authenticator = PasswordUserAuthenticator()
    elif login_type == "none":
        pass
    else:
        return "Unknown login type: {}".format(login_type), 400
    success = authenticator.auth_user(username=username,
                                      login_type=login_type,
                                      secret=secret,
                                      client_type=client_name,
                                      is_staff=False)

    if success:
        # TODO: Fix this
        print("INFO: Logged in user {} as a customer".format(username))
        token = jwt.encode({"exp": datetime.utcnow() + timedelta(hours=1), "sub": "clnt"}, "SECRET")
        return jsonify({"JWT": token.decode("utf-8")})

    else:
        return "Login Failed", 403


@app.route("/login/staff/<string:staffname>")
@auth(AuthType.client)
def login_staff(staffname: str):
    # TODO: replace with customer verifier!
    # Do something with content
    db = get_db()
    success = False
    client_name = jwt.decode(request.headers.get(ConfigHolder.jwt_header_client),
                             key=ConfigHolder.jwt_secret_client)['mate.tpe']
    secret = request.args.get("secret")
    login_type = request.args.get("login_type")
    if login_type is None:
        login_type = "none"

    if not db.check_if_user_exists(staffname):
        return "Could not find user!", 404

    login_type_list = get_db().get_login_types(client_name=client_name, username=staffname, is_staff=True)
    if login_type not in login_type_list:
        return "Login for user »{}« failed. " \
               "Login type »{}« is not usable for this user and client combination".format(staffname, login_type), \
               403

    authenticator = None
    # TODO: Refactor by using a dict for the authenticator lookup
    if login_type == "password":
        authenticator = PasswordUserAuthenticator()
    elif login_type == "none":
        pass
    else:
        return "Unknown login type: {}".format(login_type), 400
    success = authenticator.auth_user(username=staffname,
                                      login_type=login_type,
                                      secret=secret,
                                      client_type=client_name,
                                      is_staff=False)

    if success:
        # TODO: Fix this
        print("INFO: Logged in user {} as staff".format(staffname))
        token = jwt.encode({"exp": datetime.utcnow() + timedelta(hours=1), "sub": "clnt"}, "SECRET")
        return jsonify({"JWT": token.decode("utf-8")})

    else:
        return "Login Failed", 403


@app.route("/login/client/<string:client_name>")
def login_client(client_name: str):
    # TODO: replace with client verifier!
    # This currently always returns a valid token
    if validate_client_login(client_name=client_name):
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
