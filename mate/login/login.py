from enum import Enum
from functools import wraps
from typing import Dict
from typing import List

import jwt
from flask import request

from mate.helper.config_holder import ConfigHolder
from mate.login.helper.stub_login_type_holder import StubLoginTypeHolder

stub_login_type_holder = StubLoginTypeHolder()


class AuthType(Enum):
    client = 1
    customer = 2
    salesp = 3


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
                    pass
                elif authtype == AuthType.salesp:
                    pass
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


def validate_client(authkey: str):
    # hier wird ein jwt.InvalidTokenError geworfen
    payload = jwt.decode(authkey, key=ConfigHolder.jwt_secret_client) # type: Dict
    # TODO: replace with real logger!
    # client jwt must have 'clnt' as the subject
    if payload.get("sub") != "clnt":
        raise ValidationError
    # TODO: check permissions?
    print("Client ", payload.get("mate.tpe"), " validiert.")


def validate_client_login() -> bool:
    # TODO: this should do something with the DB and stuff
    print("WARNING: Not doing anything useful!")
    return True


