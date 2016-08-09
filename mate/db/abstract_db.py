from abc import ABC, abstractmethod


class AbstractDB(ABC):
    @abstractmethod
    def __init__(self):
        pass

    @abstractmethod
    def check_if_user_exists(self, username: str):
        pass

    @abstractmethod
    def get_all_login_types(self):
        pass

    @abstractmethod
    def get_login_types(self, client_name: str, username: str, is_staff: bool):
        pass

    @abstractmethod
    def get_login_credential_secret(self, client_name: str, username: str, login_type: str, is_staff: bool):
        pass

    @abstractmethod
    def get_does_client_exist_with_name(self, client_name: str) -> bool:
        pass

    @abstractmethod
    def get_storage_by_id(self, storage_id: int):
        pass

    @abstractmethod
    def get_product_storage_by_product(self, product_id: int):
        pass

    @abstractmethod
    def get_product_storage_by_storage(self, storage_id: int):
        pass

    @abstractmethod
    def delete_storage(self, storage_id: int) -> bool:
        pass

    @abstractmethod
    def close(self):
        pass
