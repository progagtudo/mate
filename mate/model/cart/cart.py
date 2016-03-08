from mate.model.abstract_model import AbstractModel
from mate.model.cart.cart_product import CartProduct


class Cart(AbstractModel):
    _json_scheme = {"$schema": "http://json-schema.org/draft-04/schema#", "id": "http://jsonschema.net",
                    "type": "object", "properties": {
                    "products": {"id": "http://jsonschema.net/products", "type": "array",
                         "items": {"id": "http://jsonschema.net/products/0", "type": "object", "properties": {
                             "product_id": {"id": "http://jsonschema.net/products/0/product_id", "type": "integer"},
                             "price": {"id": "http://jsonschema.net/products/0/price", "type": "integer"}},
                                   "required": ["product_id", "price"]}, "required": ["0"]},
                    "amount": {"id": "http://jsonschema.net/amount", "type": "integer"}}, "required": ["products", "amount"]}

    def __init__(self):
        self.products = []
        self.amount = 0

    @classmethod
    def from_json(cls, json_array):
        """init an Cart from incoming json dict
        :param json_array: a python object from json
        """
        instance = cls()
        for json_product in json_array["products"]:
            a_product = CartProduct.from_json(json_product)
            instance.products.append(a_product)
            instance.amount += a_product.price
        return instance

    def verify(self):
        return False
