from typing import List

from schematics.types import StringType, IntType
from schematics.types.compound import ListType

from mate.model.products.abstract_product import AbstractProduct
from mate.model.products.storage_amount import StorageAmount
from mate.model.products.tax_category import TaxCategory


class AdminProduct(AbstractProduct):
    tags = ListType(StringType, required=True)  # type: List
    total_amount_in_stock = IntType(required=True)  # type: int
    amounts = ListType(StorageAmount, required=True)  # type: List
    tax_category = TaxCategory(required=True)  # type: TaxCategory
    barcodes = ListType(StringType(), required=True)  # type: List

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Needs useful json scheme!
        self.json_scheme = {}
