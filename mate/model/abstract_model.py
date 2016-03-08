from abc import ABCMeta, abstractmethod, abstractproperty


class AbstractModel(metaclass=ABCMeta):

    _json_scheme = None

    @classmethod
    @abstractmethod
    def from_json(cls, json_array):
        pass

    @abstractmethod
    def verify(self):
        pass

    @property
    def json_scheme(self):
        return self._json_scheme

