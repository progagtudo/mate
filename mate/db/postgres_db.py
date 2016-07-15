import psycopg2

from mate.db.abstract_db import AbstractDB


class PostgresDB(AbstractDB):
    def close(self):
        self.db.close()

    def check_if_user_exists(self, username: str):
        cursor = self.db.cursor()
        cursor.execute("""SELECT count(*)
        FROM Credentials AS c
        WHERE c.credentialKey = %s""", (username,))
        result = cursor.fetchone()
        cursor.close()
        return result[0] == 0

    def get_login_types(self, client_name: str, username: str, is_staff: bool):
        cursor = self.db.cursor()
        cursor.execute("""SELECT act.Name AS CredentialTypeName
        FROM ClientType    AS clt
        JOIN CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
        JOIN Credentials   AS c  ON cu.CredentialID  = c.CredentialID
        JOIN AvailableCredentialTypes AS act ON c.CredentialType = act.CredentialType
         WHERE clt.name         = %s
        AND   c.CredentialKey      = %s
        AND   c.IsSalesPersonLogin = %s""", (client_name, username, is_staff))
        result = cursor.fetchmany()
        cursor.close()
        return result

    def __init__(self, configstring: str):
        super().__init__()
        self.db = psycopg2.connect(configstring)
