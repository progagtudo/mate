class Storage:
    # TODO: Use Schematics for EVERYTHING!
    json_scheme = {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "id": "http://jsonschema.net",
        "type": "object",
        "properties": {
            "storage_id": {
                "id": "http://jsonschema.net/storage_id",
                "type": "integer"
            },
            "name": {
                "id": "http://jsonschema.net/name",
                "type": "string"
            },
            "is_sale_allowed": {
                "id": "http://jsonschema.net/is_sale_allowed",
                "type": "boolean"
            }
        },
        "required": [
            "storage_id",
            "name",
            "is_sale_allowed"
        ]
    }

    json_scheme_new_object = {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "id": "http://jsonschema.net",
        "type": "object",
        "properties": {
            "name": {
                "id": "http://jsonschema.net/name",
                "type": "string"
            },
            "is_sale_allowed": {
                "id": "http://jsonschema.net/is_sale_allowed",
                "type": "boolean"
            }
        },
        "required": [
            "name",
            "is_sale_allowed"
        ]
    }

    def __int__(self):
        self.storage_id = 0  # type: int
        self.name = ""  # type: str
        self.is_sale_allowed = False  # type: bool

    @classmethod
    def from_json(cls, json):
        """inits an storage Object from incoming json dict
        :param json: a python object from json
        """
        instance = cls()
        instance.storage_id = json["storage_id"]
        instance.name = json["name"]
        instance.is_sale_allowed = json["is_sale_allowed"]
        return instance

    @classmethod
    def from_json_new_object(cls, json):
        """inits an storage Object from incoming json dict
        :param json: a python object from json
        """
        print("ist")
        instance = cls()
        instance.name = json["name"]
        instance.is_sale_allowed = json["is_sale_allowed"]
        return instance

    def verify(self):
        pass
