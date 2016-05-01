from datetime import datetime

from schematics.types import StringType, DateType, DecimalType

from mate.model.abstract_model import AbstractModel


class TaxCategory(AbstractModel):
    name = StringType(required=True)  # type: str
    valid_since = DateType(required=True)  # type: datetime
    value = DecimalType(required=True, min_value=0)  # type: float
    unit = StringType(required=True)  # type: str

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Needs useful json scheme!
        self.json_scheme = {}
