from typing import List

from schematics.types import StringType, BooleanType, ListType, ModelType
from mate.model.abstract_model import AbstractModel
from mate.model.products.storage_amount import StorageAmountType


class Storage(AbstractModel):
    name = StringType(required=True)  # type: str
    description = StringType(required=True)  # type: str
    is_sale_allowed = BooleanType(required=True)  # type: bool
    storage_amounts = ListType(StorageAmountType, required=True)  # type: List[StorageAmountType]

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Needs useful json scheme!
        self.json_scheme = {}

    @classmethod
    def from_json(cls, json):
        """inits an storage Object from incoming json dict
        :param json: a python object from json
        """
        instance = cls()
        instance.storage_id = json["storage_id"]
        instance.name = json["name"]
        instance.is_sale_allowed = json["is_sale_allowed"]
        return instance

    @classmethod
    def from_json_new_object(cls, json):
        """inits an storage Object from incoming json dict
        :param json: a python object from json
        """
        print("ist")
        instance = cls()
        instance.name = json["name"]
        instance.is_sale_allowed = json["is_sale_allowed"]
        return instance
