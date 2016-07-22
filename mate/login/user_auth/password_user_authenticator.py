from mate.login.user_auth.abstract_user_authenticator import AbstractUserAuthenticator
from mate.mate import get_db


class PasswordUserAuthenticator(AbstractUserAuthenticator):

    def __init__(self):
        pass

    def auth_user(self, username: str, login_type: str, secret, client_type: str, is_staff: bool, payload=None) -> bool:
        result = True
        db = get_db()
        db_secret = db.get_login_credential_secret(client_name=client_type,
                                       username=username,
                                       login_type=login_type,
                                       is_staff=is_staff)
        if payload is not None:
            print("WARNING: PasswordUserAuthenticator received unsupported payload data, Expected was None")
        result = db_secret == secret

        return result
