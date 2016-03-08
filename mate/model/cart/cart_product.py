from mate.model.abstract_model import AbstractModel


class CartProduct(AbstractModel):
    def __init__(self):
        self.product_id = 0
        self.price = 0

    @classmethod
    def from_json(cls, json_array):
        """inits an CartProduct from incoming json dict
        :param json_array: a python object from json
        """
        instance = cls()
        instance.product_id = json_array["product_id"]
        instance.price = json_array["price"]
        return instance

    def verify(self):
        return False

