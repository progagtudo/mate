from datetime import datetime

from schematics.types import IntType, DateTimeType, ModelType

from mate.model.abstract_model import AbstractModel
from mate.model.storage.storage import Storage


class StorageLog(AbstractModel):
    amount = IntType(required=True)  # type: int
    from_storage = ModelType(Storage, required=True)  # type: Storage
    to_storage = ModelType(Storage, required=True)  # type: Storage
    product_id = IntType(required=True)  # type: int
    timestamp = DateTimeType(required=True)  # type: datetime


def __init__(self, **kwargs):
    super().__init__(**kwargs)
    # TODO: Needs useful json scheme!
    self.json_scheme = {}
