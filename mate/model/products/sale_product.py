from schematics.types import BooleanType

from mate.model.products.abstract_product import AbstractProduct


class SaleProduct(AbstractProduct):
    amount_in_sale_storage = BooleanType(required=True)  # type: bool

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Needs useful json scheme!
        self.json_scheme = {}
