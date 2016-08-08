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
          WHERE c.credentialKey = %s )""", (username,))
        result = cursor.fetchone()[0]
        cursor.close()
        return result

    def get_all_login_types(self):
        cursor = self.db.cursor()
        cursor.execute("""SELECT act.Name
        FROM AvailableCredentialTypes AS act""")
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def get_login_types(self, client_name: str, username: str, is_staff: bool):
        cursor = self.db.cursor()
        cursor.execute("""SELECT act.Name AS CredentialTypeName
        FROM ClientType    AS clt
        JOIN CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
        JOIN Credentials   AS c  ON  cu.CredentialID =  c.CredentialID
        JOIN AvailableCredentialTypes AS act ON c.CredentialTypeID = act.CredentialTypeID
        WHERE clt.name               = %s
          AND   c.CredentialKey      = %s
          AND   c.IsSalesPersonLogin = %s
        """, (client_name, username, is_staff))
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def get_login_credential_secret(self, client_name: str, username: str, login_type: str, is_staff: bool):
        cursor = self.db.cursor()
        cursor.execute("""SELECT c.CredentialSecret
        FROM ClientType    AS clt
        JOIN CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
        JOIN Credentials   AS c  ON  cu.CredentialID =  c.CredentialID
        JOIN AvailableCredentialTypes AS act ON c.CredentialTypeID = act.CredentialTypeID
        WHERE clt.name               = %s
          AND   c.CredentialKey      = %s
          AND   c.IsSalesPersonLogin = %s
          AND act.Name               = %s
        """, (client_name, username, is_staff, login_type))
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def get_does_client_exist_with_name(self, client_name:str) -> bool:
        cursor = self.db.cursor()
        cursor.execute("""SELECT EXISTS(
          SELECT *
          FROM ClientType AS ct
          WHERE ct.Name = %s )""", (client_name,))
        result = cursor.fetchone()[0]
        cursor.close()
        return result

    def get_storage_by_id(self, storage_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT s.Name, s.Description, s.IsSaleAllowed
        FROM Storage AS s
        WHERE s.StorageID = %s
        """, (storage_id, ))
        result = cursor.fetchone()
        cursor.close()
        return result

    def get_product_storage_by_product(self, product_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT sc.StorageID, sc.Amount
        FROM StorageContent AS sc
        WHERE sc.ProductID = %s
        """, (product_id, ))
        result = cursor.fetchall()
        cursor.close()
        return result

    def get_product_storage_by_storage(self, storage_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT sc.ProductID, sc.Amount
        FROM StorageContent AS sc
        WHERE sc.StorageID = %s
        """, (storage_id, ))
        result = cursor.fetchall()
        cursor.close()
        return result


    def delete_storage(self, storage_id: int):
        cursor = self.db.cursor()
        # Check if there is any content in the to be deleted storage. Fail if there is any.
        # Use 42 as a dummy value to check for tuple existence, since we are not interested in any real data.
        cursor.execute("""
        SELECT EXISTS(
          SELECT 42 AS data
          FROM StorageContent AS sc
          WHERE sc.StorageID = %s
            AND sc.Amount > 0 )
        """, (storage_id,))
        success = not cursor.fetchone()[0]
        if success:
            print("Deleting Storage with ID {}".format(storage_id))
            cursor.execute("""
            DELETE FROM Storage AS s
            WHERE s.StorageID = %s
            """, (storage_id,))
            success = cursor.rowcount == 1
            print("Deleted {} entries".format(cursor.rowcount))
            self.db.commit()
        cursor.close()
        return success

    def __init__(self, configstring: str):
        super().__init__()
        self.db = psycopg2.connect(configstring)
