from schematics.transforms import blacklist
from schematics.types import BooleanType, IntType

from mate.model.person.person import Person


class Customer(Person):
    id = IntType(required=True)  # type: int
    needs_balance_auth = BooleanType(required=True)  # type: bool

    class Options:
        roles = {'customer': blacklist('base_balance', 'base_balance_date'),
                 'balance': blacklist('base_balance', 'base_balance_date', 'first_name', 'last_name', 'email', 'active', 'id', 'needs_balance_auth')}

    @classmethod
    def dummy(cls):
        instance = cls()
        instance.first_name = "Sternhart"
        instance.last_name = "Beffen"
        instance.active = True
        instance.email = "test@example.com"
        instance.needs_balance_auth = True
        instance.id = 123
        return instance
