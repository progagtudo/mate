from schematics.types import BooleanType

from mate.model.products.abstract_product import AbstractProduct
from mate.db.postgres_db import PostgresDB


class SaleProduct(AbstractProduct):
    amount_in_sale_storage = BooleanType(required=True)  # type: bool

    def __init__(self, id, name, price, category_id, description, is_sale_prohibited, is_default_redemption, amount_in_sale_storage):
        self.id = id
        self.name = name
        self.price = price
        self.category_id = category_id
        self.description = description
        self. is_sale_prohibited = is_sale_prohibited
        self.is_default_redemption = is_default_redemption
        self.amount_in_sale_storage = amount_in_sale_storage

    @classmethod
    def from_barcode(cls, barcode):
        r = PostgresDB.get_product_from_barcode(barcode)
        instance = cls(r[0], r[1], r[3], r[6], r[2], r[4], r[5], r[7])
        return  instance

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
