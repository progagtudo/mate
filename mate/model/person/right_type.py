from mate.model.person.right import Right
from schematics.types import BaseType
from schematics.exceptions import ValidationError


class RightType(BaseType):
    def validate(self, value, context=None):
        if type(value) is not Right:
            raise ValidationError('This is not a ProductTag!')

    def to_primitive(self, value, context=None):
        return [value.id, value.name, value.description]
