import datetime
from schematics.types.base import StringType, BooleanType, DecimalType, DateType

from mate.model.person.person import Person


class Customer(Person):
    needs_balance_auth = BooleanType(required=True) # type: bool
    id = DecimalType(required=True)   # type: decimal



