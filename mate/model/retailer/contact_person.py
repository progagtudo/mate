from mate.model.abstract_model import AbstractModel
from schematics.types import StringType, IntType, ListType


class ContactPerson(AbstractModel):
    last_name = StringType(required=True)  # type: str
    first_name = StringType()  # type: str
    email = StringType(regex=r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")  # type: str
    telephone = StringType()  # type: str
    fax = StringType()  # type: str
    retailer = ListType(IntType)  # type : list[int]

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # ToDo: Needs useful json scheme!
        self.json_scheme = {}

    @classmethod
    def from_json(cls, json):
        """
        inits a ContactPerson Object from incoming json dict
        :param json: a python object from json
        """

        instance = cls()
        instance.last_name = json["last_name"]
        if "first_name" in json:
            instance.first_name = json["first_name"]
        else:
            instance.first_name = None

        if "email" in json:
            instance.email = json["email"]
        else:
            instance.email = None

        if "telephone" in json:
            instance.telephone = json["telephone"]
        else:
            instance.telephone = None

        if "fax" in json:
            instance.fax = json["fax"]
        else:
            instance.fax = None

        if "retailer" in json:
            # Todo set retailers
            pass

    @classmethod
    def from_json_new_object(cls, json):
        """
        inits a contact Person Object from incoming json dict
        :param json: a python object from json
        """
        instance = cls()
        instance.last_name = json["last_name"]
        if "first_name" in json:
            instance.first_name = json["first_name"]
        else:
            instance.first_name = None

        if "email" in json:
            instance.email = json["email"]
        else:
            instance.email = None

        if "telephone" in json:
            instance.telephone = json["telephone"]
        else:
            instance.telephone = None

        if "fax" in json:
            instance.fax = json["fax"]
        else:
            instance.fax = None

        if "retailer" in json:
            # Todo set retailers
            pass
