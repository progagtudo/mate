from mate.model.abstract_model import AbstractModel
from schematics.types import StringType, IntType, ListType


class Retailer(AbstractModel):
    name = StringType(required=True)  # type:str
    id = IntType()  # type: int
    address_country = StringType()  # type: str
    address_zip = StringType()  # type: str
    address_city = StringType()  # type = str
    address_street = StringType()  # type = str
    address_street_no = StringType()  # type = str
    customer_number = StringType()  # type = str
    contact_persons = ListType(IntType)  # type = list[str]

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # ToDo: Needs useful json scheme!
        self.json_scheme = {}

    @classmethod
    def from_json(cls, json):
        """
        inits an retailer Object from incoming json dict
        :param json: a python object from json
        """
        instance = cls()
        instance.name = json["name"]
        instance.id = json["id"]

        if "address_country" in json:
            instance.address_country = json["address_country"]
        else:
            instance.address_country = None

        if "address_zip" in json:
            instance.address_zip = json["address_zip"]
        else:
            instance.address_zip = None

        if "address_city" in json:
            instance.address_city = json["address_city"]
        else:
            instance.address_city = None

        if "address_street" in json:
            instance.address_street = json["address_street"]
        else:
            instance.address_street = None

        if "address_street_no" in json:
            instance.address_street_no = json["address_street_no"]
        else:
            instance.address_street_no = None

        if "customer_number" in json:
            instance.customer_number = json["customer_number"]
        else:
            instance.customer_number = None

        # ToDo: set contact Persons

        return instance

    @classmethod
    def from_json_new_object(cls, json):
        """
        inits an retailer Object from incoming json dict
        :param json: a python object from json
        """
        instance = cls()
        instance.name = json["name"]

        if "address_country" in json:
            instance.address_country = json["address_country"]
        else:
            instance.address_country = None

        if "address_zip" in json:
            instance.address_zip = json["address_zip"]
        else:
            instance.address_zip = None

        if "address_city" in json:
            instance.address_city = json["address_city"]
        else:
            instance.address_city = None

        if "address_street" in json:
            instance.address_street = json["address_street"]
        else:
            instance.address_street = None

        if "address_street_no" in json:
            instance.address_street_no = json["address_street_no"]
        else:
            instance.address_street_no = None

        if "customer_number" in json:
            instance.customer_number = json["customer_number"]
        else:
            instance.customer_number = None

        # ToDo: set contact Persons

        return instance

