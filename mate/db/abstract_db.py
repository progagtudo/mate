from abc import ABC, abstractmethod
class AbstractDB(ABC):
    @abstractmethod
    def __init__(self):
        pass

    @abstractmethod
    def check_if_user_exists(self, username: str):
        pass

    @abstractmethod
    def get_login_types(self, client_name:str, username:str, is_staff:bool):
        pass

    @abstractmethod
    def get_login_credential_secret(self, client_name:str, username:str, login_type:str, is_staff:bool):
        pass

    @abstractmethod
    def close(self):
        pass
