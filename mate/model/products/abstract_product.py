import decimal
from schematics.types import StringType, DecimalType, IntType, BooleanType

from mate.model.abstract_model import AbstractModel


class AbstractProduct(AbstractModel):
    name = StringType(required=True)  # type: str
    price = DecimalType(required=True)  # type: decimal
    # TODO: This needs a getter for categories!
    category_id = IntType(required=True)  # type: int
    description = StringType(required=True)  # type: str
    is_sale_prohibited = BooleanType(required=True)  # type: bool
    is_default_redemption = BooleanType(required=True)  # type: bool
