from schematics.types import BooleanType

from mate.model.products.abstract_product import AbstractProduct
from mate.model.products.product_tag import ProductTag
from mate.db.postgres_db import PostgresDB


class SaleProduct(AbstractProduct):
    amount_in_sale_storage = BooleanType(required=True)  # type: bool

    def __init__(self, product_id, name, price, category_id, description, is_sale_prohibited, is_default_redemption,
                 amount_in_sale_storage, **kwargs):
        super().__init__(**kwargs)
        self.product_id = product_id
        self.name = name
        self.price = price
        self.category_id = category_id
        self.description = description
        self.is_sale_prohibited = is_sale_prohibited
        self.is_default_redemption = is_default_redemption
        self.amount_in_sale_storage = amount_in_sale_storage

    def get_tags(self):
        result = PostgresDB.get_product_tags(self.product_id)
        for obj in result:
            a = ProductTag()
            a.name = obj[0]
            a.description = obj[1]
            self.tags.append(a)

    @classmethod
    def from_barcode(cls, barcode):
        r = PostgresDB.get_product_from_barcode(barcode)
        instance = cls(r[0], r[1], r[3], r[6], r[2], r[4], r[5], r[7])
        instance.get_tags()
        return instance

    @classmethod
    def dummy(cls):
        instance = cls(1337, u"Club Mate 0,5l", 0.90, 1, u'Der originale Mate Eistee von Löscher', False, False, 100)
        p = ProductTag()
        p.name = "koffeinhaltig"
        p.description = "enthält Koffein"
        instance.tags = [p]
        return instance

    def is_saleable(self):
        return not self.is_sale_prohibited
