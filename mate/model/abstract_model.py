from abc import ABCMeta, abstractmethod, abstractproperty
from typing import Any, Dict


class AbstractModel(metaclass=ABCMeta):

    @classmethod
    @abstractmethod
    def from_json(cls, json: Dict[str, Any]) -> 'AbstractModel':
        pass

    @abstractmethod
    def verify(self):
        pass

    @abstractproperty
    def json_scheme(self) -> str:
        return None
