import decimal

from datetime import date
from schematics.types.base import StringType, BooleanType, DecimalType, DateType

from mate.model.abstract_model import AbstractModel


class Person(AbstractModel):
    first_name = StringType(required=True)  # type: str
    last_name = StringType(required=True)  # type: str
    email = StringType(regex=r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)", required=True)  # type: str
    active = BooleanType(required=True)  # type: bool
    base_balance = DecimalType(required=True)  # type: decimal
    base_balance_date = DateType(required=True)  # type: date
