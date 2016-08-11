class StubVerifier(object):
    @staticmethod
    def verify(jwt):
        print("[StubVerifier] WARNING: Using stub Object!")
        if jwt == "iamsosecure":
            return True
        else:
            return False
