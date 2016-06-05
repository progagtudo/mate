from schematics.types import BooleanType

from mate.model.products.abstract_product import AbstractProduct


class SaleProduct(AbstractProduct):
    amount_in_sale_storage = BooleanType(required=True)  # type: bool

    @classmethod
    def dummy(cls):
        instance = cls()
        instance.name = "Club Mate 0,5l"
        instance.price = 0.90
        instance.category_id = 1
        instance.tags = ["koffeinhaltig", "mate"]
        instance.description = "Der originale Mate Eistee von Löscher"
        instance.is_default_redemption = False
        instance.is_sale_prohibited = False
        instance.amount_in_sale_storage = 100
        return instance

    def is_saleable(self):
        return not self.is_sale_prohibited
