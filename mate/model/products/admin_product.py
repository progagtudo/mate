from typing import List

from schematics.types import StringType, IntType, ModelType
from schematics.types.compound import ListType

from mate.model.products.abstract_product import AbstractProduct
from mate.model.products.storage_amount import StorageAmount
from mate.model.products.tax_category import TaxCategory


class AdminProduct(AbstractProduct):
    tags = ListType(StringType, required=True)  # type: List
    total_amount_in_stock = IntType(required=True)  # type: int
    amounts = ListType(ModelType(StorageAmount), required=True)  # type: List[StorageAmount]
    tax_category = ModelType(TaxCategory, required=True)  # type: TaxCategory
    # TODO: Add required=true
    barcodes = ListType(StringType, required=True)  # type: List[str]

