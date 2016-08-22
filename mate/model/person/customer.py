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
                 'balance': blacklist('base_balance_date', 'first_name', 'last_name', 'email', 'active',
                                      'id', 'needs_balance_auth')}

    def __init__(self, active, first_name=None, last_name=None, email=None, base_balance=None, base_balance_date=None, customer_id=None,
                 needs_balance_auth=None,
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
    def from_id(cls, customer_id):
        r = PostgresDB.get_customer_from_id(get_db(), customer_id)
        # ToDo: needs_balance_auth is Always False, change that
        instance = cls(first_name=r[0], last_name=r[1], email=r[2], active=r[3], base_balance=r[4], base_balance_date=r[5], customer_id=r[6], needs_balance_auth=False)
        return instance

    @classmethod
    def from_barcode(cls, barcode):
        if PostgresDB.check_if_user_exists(get_db(), barcode):
            r = PostgresDB.get_customer_from_barcode(get_db(), barcode)
            # ToDo: needs_balance_auth is Always False, change that
            instance = cls(first_name=r[0], last_name=r[1], email=r[2], active=r[3], base_balance=r[4], base_balance_date=r[5], customer_id=r[6], needs_balance_auth=False)
            return instance
        else:
            return cls(active=False)

    @classmethod
    def dummy(cls):
        return cls("Sternhart", "Beffen", "test@example.com", True, 20,
                   datetime.datetime.now().isoformat(), 123, True)
