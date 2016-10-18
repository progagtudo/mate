from mate import app


class StubLoginTypeHolder(object):
    def __init__(self):
        app.logger.warning("[StubLoginTypeHolder.init()] Using stub Object!")
        self.__login_types = {"ernie": ["password", "swipe_card"],
                              "bert": ["dance", "password"]}

    @property
    def login_types(self):
        app.logger.warning("[StubLoginTypeHolder.login_types] Using stub Object!")
        return self.__login_types
