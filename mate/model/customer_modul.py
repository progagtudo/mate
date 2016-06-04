import datetime


class Customer:

    json_scheme = {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
            "id": {
                "type": "integer"
            },
            "firstName": {
                "type": "string"
            },
            "lastName": {
                "type": "string"
            },
            "email": {
                "type": "string"
            },
            "active": {
                "type": "boolean"
            },
            "needsBalanceAuth": {
                "type": "boolean"
            }
        },
        "required": [
            "id",
            "firstName",
            "lastName",
            "email",
            "active",
            "needsBalanceAuth"
        ]
    }

    def __init__(self):
        self.first_name = ""                # type: str
        self.last_name = ""                 # type: str
        self.active = False                 # type: bool
        self.email = ""                     # type: str
        self.needs_balance_auth = True      # type: bool
        self.id = 123                       # type: int

    @classmethod
    def dummy(cls):
        instance = cls()
        instance.first_name = "Boaty"
        instance.last_name = "McBoatface"
        instance.active = True
        instance.email = "test@example.com"
        instance.needs_balance_auth = True
        instance.id = 123
        return instance

    def verify(self):
        pass
