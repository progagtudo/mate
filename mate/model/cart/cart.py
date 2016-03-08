from mate.model.abstract_model import AbstractModel
from mate.model.cart.cart_product import CartProduct


class Cart(AbstractModel):
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
        pass


