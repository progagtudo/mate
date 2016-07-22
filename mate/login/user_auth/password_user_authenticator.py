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
        number_results = len(db_secret)
        if(number_results != 1):
            print("WARNING: Got {} credential secrets for username {}".format((number_results, username)))
        # TODO: find a way to not double-copy the data. It is first copied in a new bytes-object and then copied into a string
        db_secret = bytes(db_secret[0]).decode("utf-8")
        print(db_secret)
        if payload is not None:
            print("WARNING: PasswordUserAuthenticator received unsupported payload data, Expected was None")
        result = db_secret == secret

        return result
