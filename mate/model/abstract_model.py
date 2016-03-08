from abc import ABCMeta, abstractmethod


class AbstractModel(metaclass=ABCMeta):

    @abstractmethod
    def from_json(self, json_array):
        pass

    @abstractmethod
    def verify(self):
        pass
