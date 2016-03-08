from abc import ABCMeta, abstractmethod


class AbstractModel(metaclass=ABCMeta):

    @classmethod
    @abstractmethod
    def from_json(cls, json_array):
        pass

    @abstractmethod
    def verify(self):
        pass
