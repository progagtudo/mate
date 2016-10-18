import psycopg2

from mate.db.abstract_db import AbstractDB
from mate import app


class PostgresDB(AbstractDB):
    def close(self):
        self.db.close()

    def check_if_user_exists(self, username: str):
        cursor = self.db.cursor()
        cursor.execute("""
          SELECT *
          FROM username AS u
          WHERE u.username = %s """, (username,))
        result = cursor.fetchone()
        cursor.close()
        return result is not None

    def check_if_salesperson_exists(self, barcode):
        cursor = self.db.cursor()
        cursor.execute("""
          SELECT *
          FROM username AS u
          INNER JOIN credentials as c
          ON u.usernameid = c.usernameid
          WHERE u.username = %s AND c.IsSalesPersonLogin = TRUE""", (barcode,))
        result = cursor.fetchone()
        cursor.close()
        return result is not None
        pass

    def get_customer_from_barcode(self, barcode: str):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT Person.FirstName, Person.LastName, Person.EMail, (Customer.Active AND Person.Active) AS Active, Customer.BaseBalance, Customer.BaseBalanceDate, Person.PersonID
        FROM username as u
        INNER JOIN credentials as c
        ON u.usernameid = c.usernameid
        INNER JOIN Customer
        ON Customer.CustomerID=u.PersonID
        INNER  JOIN Person
        ON Person.PersonID=u.PersonID
        WHERE u.username = %s AND c.IsSalesPersonLogin = FALSE """, (barcode,))
        result = cursor.fetchone()
        cursor.close()
        return result

    def get_salesperson_from_barcode(self, barcode: str):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT Person.FirstName, Person.LastName, Person.EMail, (SalesPerson.Active AND Person.Active) AS Active, SalesPerson.BaseBalance, SalesPerson.BaseBalanceDate, Person.PersonID
        FROM username as u
        INNER JOIN credentials as c
        ON u.usernameid = c.usernameid
        INNER JOIN SalesPerson
        ON SalesPerson.salespersonid=u.PersonID
        INNER  JOIN Person
        ON Person.PersonID=u.PersonID
        WHERE u.username = %s AND c.IsSalesPersonLogin = TRUE """, (barcode,))
        result = cursor.fetchone()
        cursor.close()
        return result

    def get_customer_from_id(self, customer_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT Person.FirstName, Person.LastName, Person.EMail, (Customer.Active AND Person.Active) AS Active, Customer.BaseBalance, Customer.BaseBalanceDate, Person.PersonID
        FROM username AS u
        INNER JOIN Credentials AS c
        ON u.usernameid = c.usernameid
        INNER JOIN Customer
        ON Customer.CustomerID=u.PersonID
        INNER  JOIN Person
        ON Person.PersonID=u.PersonID
        WHERE Person.personid = %s AND c.IsSalesPersonLogin = FALSE """, (customer_id,))
        result = cursor.fetchone()
        cursor.close()
        return result

    def get_rights_from_id(self, person_id: int):
        cursor = self.db.cursor()
        cursor.execute("""SELECT AvailableRights.rightid, AvailableRights.description, AvailableRights.name
        FROM Person
        INNER JOIN PersonRoleAssignment
        ON PersonRoleAssignment.salespersonid = Person.personid
        INNER JOIN RoleRightAssignment
        ON RoleRightAssignment.roleid = PersonRoleAssignment.roleid
        INNER JOIN AvailableRights
        ON RoleRightAssignment.rightid = AvailableRights.rightid
        WHERE Person.personid = %s""", (person_id,))
        result = cursor.fetchall()
        cursor.close()
        return result

    def get_product_from_barcode(self, barcode: str):
        # ToDo: Tags & InStockAmount fehlen
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT p.ProductID, p.Name, p.Description, p.Price, p.IsSaleAllowed, p.IsDefaultRedemption, p.CategoryID, pi.InStockAmount
        FROM Barcode AS b
        INNER JOIN Product AS p
        ON b.ProductID=p.ProductID
        INNER JOIN ProductInstance AS pi
        ON b.ProductID=pi.ProductID
        WHERE b.Barcode = %s""", (barcode,))
        result = cursor.fetchone()
        cursor.close()
        return result

    def get_product_tags(self, product_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT AvailableProductTags.Name, AvailableProductTags.Description
        FROM ProductTagAssignment AS p
        INNER JOIN AvailableProductTags
        ON p.tagid = availableproducttags.tagid
        WHERE p.productid = %s""", (product_id,))
        result = cursor.fetchall()
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
        app.logger.info("client: " + client_name + " user: " + username + " is_staff: " + str(is_staff))
        cursor = self.db.cursor()
        cursor.execute("""SELECT act.Name AS CredentialTypeName
        FROM client        AS cl
        JOIN ClientType    AS clt
        ON cl.clienttypeid = clt.clienttypeid
        JOIN CredentialUse AS cu
        ON clt.ClientTypeID = cu.ClientTypeID
        INNER JOIN credentials as c
        ON  cu.CredentialID =  c.CredentialID
        INNER JOIN username as u
        ON u.usernameid = c.usernameid
        JOIN AvailableCredentialTypes AS act
        ON c.CredentialTypeID = act.CredentialTypeID
        WHERE     cl.name =             %s
            AND   u.username =      %s
            AND   c.IsSalesPersonLogin = %s""", (client_name, username, is_staff))
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def get_login_credential_secret(self, client_name: str, username: str, login_type: str, is_staff: bool):
        app.logger.info("client: " + client_name + " user: " + username + " is_staff: " + str(is_staff) + " login_type: " + login_type)
        cursor = self.db.cursor()
        cursor.execute("""SELECT c.CredentialSecret
        FROM client        AS cl
        JOIN ClientType    AS clt ON cl.clienttypeid = clt.clienttypeid
        JOIN CredentialUse AS cu ON clt.ClientTypeID = cu.ClientTypeID
        JOIN Credentials   AS c  ON  cu.CredentialID =  c.CredentialID
        JOIN username      AS u  ON u.usernameid = c.usernameid
        JOIN AvailableCredentialTypes AS act ON c.CredentialTypeID = act.CredentialTypeID
        WHERE cl.name                = (%s)
          AND   u.username           = (%s)
          AND   c.IsSalesPersonLogin = (%s)
          AND act.Name               = (%s)
        """, (client_name, username, is_staff, login_type))
        result = [x[0] for x in cursor.fetchall()]
        cursor.close()
        return result

    def get_does_client_exist_with_name(self, client_name: str) -> bool:
        cursor = self.db.cursor()
        cursor.execute("""SELECT EXISTS(
          SELECT *
          FROM Client AS cl
          WHERE cl.Name = %s )""", (client_name,))
        result = cursor.fetchone()[0]
        cursor.close()
        return result

    def get_storage_by_id(self, storage_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT s.Name, s.Description, s.IsSaleAllowed
        FROM Storage AS s
        WHERE s.StorageID = %s
        """, (storage_id,))
        result = cursor.fetchone()
        cursor.close()
        return result

    def get_storages(self, offset: int, limit: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT s.StorageID, s.Name, s.Description, s.IsSaleAllowed
        FROM Storage AS s
        ORDER BY s.StorageID ASC
        OFFSET %s
        LIMIT  %s
        """, (offset, limit))
        result = cursor.fetchall()
        cursor.close()
        return result

    def get_product_storage_by_product(self, product_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT sc.StorageID, sc.Amount
        FROM StorageContent AS sc
        WHERE sc.ProductID = %s
        """, (product_id,))
        result = cursor.fetchall()
        cursor.close()
        return result

    def get_product_storage_by_storage(self, storage_id: int):
        cursor = self.db.cursor()
        cursor.execute("""
        SELECT sc.ProductID, sc.Amount
        FROM StorageContent AS sc
        WHERE sc.StorageID = %s
        """, (storage_id,))
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
            app.logger.info("Deleting Storage with ID {}".format(storage_id))
        if self.__exists_storage(storage_id=storage_id, cursor=cursor):
            app.logger.info("Deleting Storage with ID {}".format(storage_id))
            cursor.execute("""
            DELETE FROM Storage AS s
            WHERE s.StorageID = %s
            """, (storage_id,))
            success = cursor.rowcount == 1
            app.logger.info("Deleted {} entries".format(cursor.rowcount))
            self.db.commit()
        cursor.close()
        return success

    def exists_storage(self, storage_id: int):
        return self.__exists_storage(storage_id=storage_id)

    def __exists_storage(self, storage_id: int, cursor=None) -> bool:
        close_cursor = False
        if cursor is None:
            close_cursor = True
            cursor = self.db.cursor()
        # Check if there is any content in the to be deleted storage. Fail if there is any.
        # Use 42 as a dummy value to check for tuple existence, since we are not interested in any real data.
        cursor.execute("""
        SELECT EXISTS(
          SELECT 42 AS data
          FROM Storage AS s
          WHERE s.StorageID = %s )
        """, (storage_id,))
        success = not cursor.fetchone()[0]
        if close_cursor is True:
            cursor.close()
        return success

    def create_storage(self, name: str, description: str, is_sale_allowed: bool):
        cursor = self.db.cursor()

        cursor.execute("""
        INSERT INTO Storage
          (Name, Description, IsSaleAllowed)
        VALUES
          (%s, %s, %s)
        RETURNING StorageID
        """, (name, description, is_sale_allowed))

        result = cursor.fetchone()[0]
        cursor.close()

        return result

    def update_storage(self, storage, update_description: bool):
        cursor = self.db.cursor()

        if self.__exists_storage(storage_id=storage.storage_id, cursor=cursor):
            cursor.execute("""BEGIN""")

            if storage.name is not None:
                cursor.execute("""UPDATE Storage
                SET Name = %s
                WHERE StorageID = %s""", (storage.name, storage.storage_id))

            if update_description is True:
                cursor.execute("""UPDATE Storage
                SET Description = %s
                WHERE StorageID = %s""", (storage.description, storage.storage_id))

            if storage.is_sale_allowed is not None:
                cursor.execute("""UPDATE Storage
                SET IsSaleAllowed = %s
                WHERE StorageID = %s""", (storage.is_sale_allowed, storage.storage_id))

            cursor.execute("""COMMIT""")
            cursor.close()

    def __init__(self, configstring: str):
        super().__init__()
        self.db = psycopg2.connect(configstring)
