from schematics.types import StringType

from mate.model.abstract_model import AbstractModel


class ProductTag(AbstractModel):
    name = StringType(required=True)  # type: str
    description = StringType(required=True)  # type: str
