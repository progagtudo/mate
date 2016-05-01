from schematics import Model
from schematics.types import BaseType
from schematics.types.compound import DictType


class AbstractModel(Model):
    # TODO: This currently accepts all types as key. Is it sufficient to only allow Strings?
    json_scheme = DictType(BaseType, required=True)  # type: dict
