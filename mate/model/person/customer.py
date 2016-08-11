from schematics.transforms import blacklist
from schematics.types import BooleanType, IntType

from mate.model.person.person import Person
from mate.db.postgres_db import PostgresDB


class Customer(Person):
    id = IntType(required=True)  # type: int
    needs_balance_auth = BooleanType(required=True)  # type: bool

    class Options:
        roles = {'customer': blacklist('base_balance', 'base_balance_date'),
                 'balance': blacklist('base_balance', 'base_balance_date', 'first_name', 'last_name', 'email', 'active',
                                      'id', 'needs_balance_auth')}

    def __init__(self, first_name, last_name, email, active, base_balance, base_balance_date, id, needs_balance_auth,
                 **kwargs):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.active = active
        self.base_balance = base_balance
        self.base_balance_date = base_balance_date
        self.id = id
        self.needs_balance_auth = needs_balance_auth
        super().__init__(**kwargs)

    @classmethod
    def from_barcode(cls, barcode):
        r = PostgresDB.get_customer_from_barcode(barcode);
        # ToDo: needs_balance_auth is Always False, change that
        instance = cls(r[0], r[1], r[2], r[3], r[4], r[5], r[6], False)
        return instance

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
