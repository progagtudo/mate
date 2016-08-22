from mate.model.abstract_model import AbstractModel


class Cart(AbstractModel):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.json_scheme = {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "id": "http://jsonschema.net",
            "type": "object",
            "properties": {
                "products": {
                    "id": "http://jsonschema.net/products",
                    "type": "array",
                    "items": {
                        "id": "http://jsonschema.net/products/0",
                        "type": "object",
                        "properties": {
                            "product_id": {
                                "id": "http://jsonschema.net/products/0/product_id",
                                "type": "integer"
                            },
                            "price": {
                                "id": "http://jsonschema.net/products/0/price",
                                "type": "integer"
                            }
                        },
                        "required": ["product_id", "price"]
                    },
                    "required": ["0"]
                },
                "amount": {
                    "id": "http://jsonschema.net/amount",
                    "type": "integer"
                }
            },
            "required": ["products", "amount"]
        }

