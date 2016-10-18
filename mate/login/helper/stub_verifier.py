class StubVerifier(object):
    @staticmethod
    def verify(jwt):
        app.logger.warning("[StubVerifier] Using stub Object!")
        if jwt == "iamsosecure":
            return True
        else:
            return False
