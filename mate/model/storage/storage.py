import decimal
from schematics.types import StringType, IntType, BooleanType , ListType

from mate.model.abstract_model import AbstractModel
from mate.model.products.storage_amount import StorageAmount

class Storage(AbstractModel):
    name = StringType(required=True)  # type: str
    description = StringType(required=True)  # type: str
    is_sale_allowed = BooleanType(required=True)  # type: bool
    storage_amounts = ListType(StorageAmount, required=True)  # type: List

def __init__(self, **kwargs):
    super().__init__(**kwargs)
    # TODO: Needs useful json scheme!
    self.json_scheme = {}
