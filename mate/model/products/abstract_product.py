import decimal
from typing import List

from mate.model.products.tag_type import TagType
from schematics.transforms import blacklist
from schematics.types import StringType, DecimalType, IntType, BooleanType, ListType

from mate.model.abstract_model import AbstractModel


class AbstractProduct(AbstractModel):
    product_id = IntType(required=True) # type: int
    name = StringType(required=True)  # type: str
    price = DecimalType(required=True)  # type: decimal
    # TODO: This needs a getter for categories!
    category_id = IntType(required=True)  # type: int
    tags = ListType(TagType, required=True)  # type: List[tag]
    description = StringType(required=True)  # type: str
    is_sale_prohibited = BooleanType(required=True)  # type: bool
    is_default_redemption = BooleanType(required=True)  # type: bool

    class Options:
        roles = {'sale_product': blacklist('is_sale_prohibited')}
