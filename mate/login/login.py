from datetime import datetime, timedelta
from functools import wraps
from typing import List

import jwt
from flask import jsonify, request

from mate import app
from mate.helper.config_holder import ConfigHolder
from mate.login.helper.stub_login_type_holder import StubLoginTypeHolder
from mate.login.helper.stub_verifier import StubVerifier

stub_login_type_holder = StubLoginTypeHolder()


@app.route("/login_types/<username>")
def login_types(username):
    if username in stub_login_type_holder.login_types :
        return jsonify({"types": stub_login_type_holder.login_types[username]})
    else:
        return "Could not find user!", 500


@app.route("/login/customer")
def login_customer():
    if StubVerifier.verify(request.headers.get('MATE-Client-Auth')):
        # Do something with content
        print("WARNING: Not doing anything useful!")
        token = jwt.encode({"exp": datetime.utcnow() + timedelta(hours=1)}, "SECRET")
        return jsonify({"JWT": token.decode("utf-8")})
    else:
        return "", 403


def auth(authtype:str, rights:List[str] = None):
    def decorator(func):
        @wraps(func)
        def decorated_func(*args, **kwargs):
            try:
                jwt.decode(request.headers.get('MATE-Client-Auth'), key="SECRET")
            except jwt.ExpiredSignatureError:
                print("Der Token ist abgelaufen")
                return "Authentication error", 401
            except jwt.DecodeError:
                print("Irgendwas ist kaputt")
                return "Authentication error", 401
            except:
                print("Irgendwas ist kaputt")
                return "Authentication error", 401
            return func(*args, **kwargs)
        return decorated_func
    return decorator

def validate_client(authkey:str):
    try:
        jwt.decode(authkey, key=ConfigHolder.jwt_secret_client)
    except jwt.InvalidTokenError:
        return
