
from mate.db.abstract_db import AbstractDB


class MockDB(AbstractDB):

    def close(self):
        pass

    def check_if_user_exists(self, username: str):
        users = ["nutzer123", "test"]
        result = username in users
        return result

    def get_all_login_types(self):
        result = ["password", "Tanzmatte", "Jodeln"]
        return result

    def get_login_types(self, client_name: str, username: str, is_staff: bool):
        result = ["password"]
        return result

    def get_login_credential_secret(self, client_name: str, username: str, login_type: str, is_staff: bool):
        result = "sicher123"
        return result

    def get_does_client_exist_with_name(self, client_name:str) -> bool:
        clients = ["dummyclient", "testclient", "test"]
        result = client_name in clients
        return result

    def get_storage_by_id(self, storage_id: int):
        result = ("Verkaufsraum", "Matekalypse", True)
        return result

    def get_storages(self, offset: int, limit: int):
        result = [
            (1, "Verkaufsraum", "Matekalypse", True),
            (2, "Lager OH14", None, False),
            (3, "Lager OH12", "Illegal aquirierter Raum im OH12-Keller", False)
        ]
        return result

    def get_product_storage_by_product(self, product_id: int):
        result = [
            (1, 10),
            (2, 20),
            (3, 4)
        ]
        return result

    def get_product_storage_by_storage(self, storage_id: int):
        result = [
            (1, 5),
            (2, 10),
            (3, 4),
            (4, 40),
        ]
        return result

    def delete_storage(self, storage_id: int):
        success = storage_id in [1, 2, 3]
        return success

    def __init__(self, configstring: str):
        super().__init__()
