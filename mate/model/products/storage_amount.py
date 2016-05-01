from schematics.types import IntType

from mate.model.abstract_model import AbstractModel


class StorageAmount(AbstractModel):
    storage_id = IntType(required=True)  # type:int
    amount = IntType(required=True)  # type: int

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Needs useful json scheme!
        self.json_scheme = {}
