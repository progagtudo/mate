from enum import Enum
from functools import wraps
from typing import Dict
from typing import List

import jwt
from flask import request
from mate import app

# from mate.mate import get_db
from mate.helper.config_holder import ConfigHolder
from mate.login.helper.stub_login_type_holder import StubLoginTypeHolder
from mate.mate import get_db

stub_login_type_holder = StubLoginTypeHolder()


class AuthType(Enum):
    client = 1
    customer = 2
    staff = 3


class ValidationError(Exception):
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return repr(self.value)


def auth(authtype: AuthType, rights: List[str] = None):
    def decorator(func):
        @wraps(func)
        def decorated_func(*args, **kwargs):
            try:
                if authtype == AuthType.client:
                    validate_client(request.headers.get(ConfigHolder.jwt_header_client))
                elif authtype == AuthType.customer:
                    validate_customer(request.headers.get(ConfigHolder.jwt_header_customer))
                elif authtype == AuthType.staff:
                    validate_staff(request.headers.get(ConfigHolder.jwt_header_staff))
            except jwt.ExpiredSignatureError:
                app.logger.warning("Der Token ist abgelaufen")
                return "Authentication error", 401
            except jwt.DecodeError:
                app.logger.warning("Irgendwas ist kaputt")
                return "Authentication error", 401
            except:
                app.logger.warning("Irgendwas ist kaputt")
                return "Authentication error", 401
            return func(*args, **kwargs)

        return decorated_func

    return decorator


def validate_client(authkey: str):
    # hier wird ein jwt.InvalidTokenError geworfen
    payload = jwt.decode(authkey, key=ConfigHolder.jwt_secret_client)  # type: Dict
    # TODO: replace with real logger!
    # client jwt must have 'clnt' as the subject
    if payload.get("sub") != "clnt":
        raise ValidationError
    # TODO: check permissions?
    app.logger.info("Client ", payload.get("mate.tpe"), " validiert.")


def validate_client_login(client_name: str) -> bool:
    # This only checks for client existence in the database for now.
    # TODO: check for some kind of secret
    app.logger.warning("validate_client_login(): Not doing anything useful!")
    # TODO: Uncomment when it is possible to import the db…
    db = get_db()
    result = db.get_does_client_exist_with_name(client_name=client_name)
    return result


def validate_staff(authkey: str):
    payload = jwt.decode(authkey, key=ConfigHolder.jwt_secret_staff)  # type: Dict
    if payload.get("sub") != "staff":
        raise ValidationError
    # TODO: check permissions?
    app.logger.info("Staff ", payload.get("mate.tpe"), " validiert.")


def validate_customer(authkey: str):
    payload = jwt.decode(authkey, key=ConfigHolder.jwt_secret_customer)  # type: Dict
    if payload.get("sub") != "cust":
        raise ValidationError
    # TODO: check permissions?
    app.logger.info("Customer ", payload.get("mate.tpe"), " validiert.")
