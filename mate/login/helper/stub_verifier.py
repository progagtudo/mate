class StubVerifier(object):
    @staticmethod
    def verify(jwt):
        print("WARNING: Using stub Object!")
        if jwt == "iamsosecure":
            return True
        else:
            return False
