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

    def verify(self):
        pass
