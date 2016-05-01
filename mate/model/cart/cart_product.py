from schematics.types import IntType, DecimalType

from mate.model.abstract_model import AbstractModel


class CartProduct(AbstractModel):
    # TODO: Not sure if something here should be required
    product_id = IntType()  # type: int
    price = DecimalType()  # type: float

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # We need to set attribute contents here!
        self.json_scheme = {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "id": "http://jsonschema.net",
            "type": "object",
            "properties": {
                "product_id": {
                    "id": "http://jsonschema.net/product_id",
                    "type": "integer"},
                "price": {
                    "id": "http://jsonschema.net/price",
                    "type": "integer"}},
            "required": ["product_id", "price"]}
