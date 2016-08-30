from mate.mate import get_db
from schematics.transforms import blacklist, whitelist
from schematics.types import BooleanType

from mate.model.products.abstract_product import AbstractProduct
from mate.model.products.product_tag import ProductTag
from mate.db.postgres_db import PostgresDB


class SaleProduct(AbstractProduct):
    amount_in_sale_storage = BooleanType(required=True)  # type: bool

    class Options:
        roles = {'sale_product': whitelist('product_id', 'price', 'name', 'tags')}

    def __init__(self, is_sale_allowed, product_id=None, name=None, price=None, category_id=None, description=None, is_default_redemption=None,
                 amount_in_sale_storage=None, **kwargs):
        super().__init__(**kwargs)
        self.product_id = product_id
        self.name = name
        self.price = price
        self.category_id = category_id
        self.description = description
        self.is_sale_allowed = is_sale_allowed
        self.is_default_redemption = is_default_redemption
        self.amount_in_sale_storage = amount_in_sale_storage
        self.tags = []

    def get_tags(self):
        result = PostgresDB.get_product_tags(get_db(), product_id=self.product_id)
        for obj in result:
            print("Found a Tag: "+obj[0]+", "+obj[1])
            a = ProductTag()
            a.name = obj[0]
            a.description = obj[1]
            self.tags.append(a)

    @classmethod
    def from_barcode(cls, barcode):
        print("product barcode: "+barcode)
        r = PostgresDB.get_product_from_barcode(get_db(), barcode)
        if r is None:
            return cls(is_sale_allowed=False)
        else:
            instance = cls(product_id=r[0], name=r[1], price=r[3], category_id=r[6], description=r[2], is_sale_allowed=r[4], is_default_redemption=r[5], amount_in_sale_storage=r[7])
            instance.get_tags()
            return instance
