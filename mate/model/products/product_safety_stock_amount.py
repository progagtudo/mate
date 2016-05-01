from schematics.types import StringType
from schematics.types.base import IntType

from mate.model.abstract_model import AbstractModel


class ProductSafetyStockAmount(AbstractModel):
    name = StringType(required=True)  # type: str
    amount = IntType(required=True)  # type: int
    is_notified = IntType(required=True)  # type: int
    level_id = IntType(required=True)  # type: int

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Needs useful json scheme!
        self.json_scheme = {}
