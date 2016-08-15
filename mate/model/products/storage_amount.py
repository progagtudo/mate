from schematics.types import IntType, BaseType

from mate.model.abstract_model import AbstractModel


class StorageAmountType(BaseType):
    pass


class StorageAmount(AbstractModel):
    storage_id = IntType(required=True)  # type:int
    amount = IntType(required=True)  # type: int
    # TODO: Needs useful json scheme!
    json_scheme = {}
