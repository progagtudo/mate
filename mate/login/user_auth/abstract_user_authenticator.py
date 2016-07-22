from abc import ABC, abstractmethod


class AbstractUserAuthenticator(ABC):

    @abstractmethod
    def __init__(self):
        pass

    @abstractmethod
    def auth_user(self, username: str, login_type: str, secret, client_type: str, is_staff: bool, payload=None) -> bool:
        pass
