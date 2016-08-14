from schematics.transforms import blacklist
from schematics.types import BooleanType, IntType

from mate.mate import get_db
from mate.model.person.person import Person
from mate.db.postgres_db import PostgresDB
import datetime


class Customer(Person):
    id = IntType(required=True)  # type: int
    needs_balance_auth = BooleanType(required=True)  # type: bool

    class Options:
        roles = {'customer': blacklist('base_balance', 'base_balance_date'),
                 'balance': blacklist('base_balance', 'base_balance_date', 'first_name', 'last_name', 'email', 'active',
                                      'id', 'needs_balance_auth')}

    def __init__(self, first_name, last_name, email, active, base_balance, base_balance_date, customer_id,
                 needs_balance_auth,
                 **kwargs):
        super().__init__(**kwargs)
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.active = active
        self.base_balance = base_balance
        self.base_balance_date = base_balance_date
        self.id = customer_id
        self.needs_balance_auth = needs_balance_auth

    @classmethod
    def from_barcode(cls, barcode):
        r = PostgresDB.get_customer_from_barcode(get_db(), barcode)
        # ToDo: needs_balance_auth is Always False, change that
        instance = cls(r[0], r[1], r[2], r[3], r[4], r[5], r[6], False)
        return instance

    @classmethod
    def dummy(cls):
        return cls("Sternhart", "Beffen", "test@example.com", True, 20,
                   datetime.datetime.now().isoformat(), 123, True)
