from schematics.types import BaseType
from schematics.exceptions import ValidationError
from mate.model.products.product_tag import ProductTag


class TagType(BaseType):
    def validate(self, value, context=None):
        if type(value) is not ProductTag:
            raise ValidationError('This is not a ProductTag!')

    def to_primitive(self, value, context=None):
        return [value.name, value.description]
