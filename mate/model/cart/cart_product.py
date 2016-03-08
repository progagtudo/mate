from mate.model.abstract_model import AbstractModel
from jsonschema import validate


class CartProduct(AbstractModel):
    json_scheme = {"$schema": "http://json-schema.org/draft-04/schema#", "id": "http://jsonschema.net",
                       "type": "object",
                       "properties": {"product_id": {"id": "http://jsonschema.net/product_id", "type": "integer"},
                                      "price": {"id": "http://jsonschema.net/price", "type": "integer"}},
                       "required": ["product_id", "price"]}

    def __init__(self):
        self.product_id = 0
        self.price = 0

    @classmethod
    def from_json(cls, json):
        """inits an CartProduct from incoming json dict
        :param json: a python object from json
        """
        validate(json, cls.json_scheme)
        instance = cls()
        instance.product_id = json["product_id"]
        instance.price = json["price"]
        return instance

    def verify(self):
        return False
