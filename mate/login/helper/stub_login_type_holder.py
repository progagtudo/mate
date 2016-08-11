class StubLoginTypeHolder(object):
    def __init__(self):
        print("[StubLoginTypeHolder.init()] WARNING: Using stub Object!")
        self.__login_types = {"ernie": ["password", "swipe_card"],
                              "bert": ["dance", "password"]}

    @property
    def login_types(self):
        print("[StubLoginTypeHolder.login_types] WARNING: Using stub Object!")
        return self.__login_types
