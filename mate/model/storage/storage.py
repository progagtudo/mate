from typing import List

from schematics.types import StringType, BooleanType, ListType

from mate.model.abstract_model import AbstractModel
from mate.model.products.storage_amount import StorageAmountType
from mate.mate import get_db


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
        instance.description = json["description"]
        instance.is_sale_allowed = json["is_sale_allowed"]
        return instance

    @classmethod
    def from_json_new_object(cls, json):
        """inits an storage Object from incoming json dict
        :param json: a python object from json
        """
        instance = cls()
        instance.name = json["name"]
        instance.description = json["description"]
        instance.is_sale_allowed = json["is_sale_allowed"]
        return instance

    @classmethod
    def request_from_db(cls, storage_id: int = None):
        db_results = get_db().get_storage_by_id(storage_id=storage_id)
        if db_results is None:
            return None
        else:
            instance = cls()
            instance.storage_id = storage_id
            instance.name = db_results[0]
            instance.description = db_results[1]
            instance.is_sale_allowed = db_results[2]
            # TODO: fix storage_amounts, this item has a useless type and cannot be filled with useful data.
            instance.storage_amounts = []
            return instance

    @classmethod
    def update_in_db(cls, storage, update_description: bool):
        get_db().update_storage(storage=storage, update_description=update_description)

    @classmethod
    def delete_instance_in_db(cls, storage_id: int) -> bool:
        db_results = get_db().delete_storage(storage_id=storage_id)
        return db_results
