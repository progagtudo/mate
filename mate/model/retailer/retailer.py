from mate.model.abstract_model import AbstractModel
from schematics.types import StringType, IntType, ListType


class Retailer(AbstractModel):
    name = StringType(required=True)  # type:str
    email = StringType(regex=r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")  # type:str
    id = IntType()  # type: int
    address_country = StringType()  # type: str
    address_zip = StringType()  # type: str
    address_city = StringType()  # type = str
    address_street = StringType()  # type = str
    address_street_no = StringType()  # type = str
    customer_number = StringType()  # type = str
    contactPersons = ListType(IntType)  # type = list[str]
