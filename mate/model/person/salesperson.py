from mate import app
from mate.model.person.right import Right
from mate.model.person.right_type import RightType
from schematics.types import IntType, ListType

from mate.mate import get_db
from mate.model.person.person import Person
from mate.db.postgres_db import PostgresDB
import datetime


class SalesPerson(Person):
    id = IntType(required=True)  # type: int
    rights = ListType(RightType, required=True)  # type: List[right]

    def __init__(self, active, first_name=None, last_name=None, email=None, base_balance=None, base_balance_date=None,
                 staff_id=None,
                 **kwargs):
        super().__init__(**kwargs)
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.active = active
        self.base_balance = base_balance
        self.base_balance_date = base_balance_date
        self.id = staff_id
        self.rights = []

    def get_rights(self):
        result = PostgresDB.get_rights_from_id(get_db(), person_id=self.id)
        for obj in result:
            app.logger.info(obj)
            app.logger.info("Found a Right: "+obj[1]+", "+obj[2])
            a = Right()
            a.id = obj[0]
            a.name = obj[2]
            a.description = obj[1]
            self.rights.append(a)

    @classmethod
    def from_barcode(cls, barcode):
        if PostgresDB.check_if_salesperson_exists(get_db(), barcode):
            r = PostgresDB.get_salesperson_from_barcode(get_db(), barcode)
            instance = cls(first_name=r[0], last_name=r[1], email=r[2], active=r[3], base_balance=r[4],
                           base_balance_date=r[5], staff_id=r[6])
            instance.get_rights()
            return instance
        else:
            return cls(active=False)
