from schematics.types import StringType, IntType

from mate.model.abstract_model import AbstractModel


class Right(AbstractModel):
    id = IntType(required=True) # type: int
    name = StringType(required=True)  # type: str
    description = StringType(required=True)  # type: str

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description
        }
