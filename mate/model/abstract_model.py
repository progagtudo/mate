from abc import ABCMeta, abstractmethod, abstractproperty


class AbstractModel(metaclass=ABCMeta):


    @classmethod
    @abstractmethod
    def from_json(cls, json_array):
        pass

    @abstractmethod
    def verify(self):
        pass

    @abstractproperty
    def json_scheme(self):
        return None

