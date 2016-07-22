import psycopg2

from mate.db.abstract_db import AbstractDB


class PostgresDB(AbstractDB):
    def close(self):
        self.db.close()

    def check_if_user_exists(self, username: str):
        cursor = self.db.cursor()
        cursor.execute("""SELECT EXISTS(
        SELECT *
          FROM Credentials AS c
          WHERE c.credentialKey = %s)""", (username,))
        result = cursor.fetchone()[0]
        cursor.close()
        return result

    def get_login_types(self, client_name: str, username: str, is_staff: bool):
        cursor = self.db.cursor()
        cursor.execute("""SELECT act.Name AS CredentialTypeName
        FROM ClientType    AS clt
        JOIN CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
        JOIN Credentials   AS c  ON cu.CredentialID  = c.CredentialID
        JOIN AvailableCredentialTypes AS act ON c.CredentialType = act.CredentialType
        WHERE clt.name               = %s
          AND   c.CredentialKey      = %s
          AND   c.IsSalesPersonLogin = %s""", (client_name, username, is_staff))
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def get_login_credential_secret(self, client_name:str, username:str, login_type:str, is_staff:bool):
        cursor = self.db.cursor()
        cursor.execute("""SELECT c.CredentialSecret
        FROM ClientType    AS clt
        JOIN CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
        JOIN Credentials   AS c  ON cu.CredentialID  = c.CredentialID
        JOIN AvailableCredentialTypes AS act ON c.CredentialType = act.CredentialType
        WHERE clt.name               = %s
          AND   c.CredentialKey      = %s
          AND   c.IsSalesPersonLogin = %s
          AND act.Name               = %s
        """, (client_name, username, is_staff, login_type))
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def __init__(self, configstring: str):
        super().__init__()
        self.db = psycopg2.connect(configstring)
