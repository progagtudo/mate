from mate.model.abstract_model import AbstractModel
from schematics.types import StringType, IntType, ListType


class ContactPerson(AbstractModel):
    first_name = StringType()  # type: str
    last_name = StringType(required=True)  # type: str
    email = StringType(regex=r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")  # type: str
    telephone = StringType()  # type: str
    fax = StringType()  # type: str
    retailer = ListType(IntType)  # type : list[int]
