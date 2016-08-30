-- ClientType
INSERT INTO ClientType
(clienttypeid, Name)
VALUES
    (1, 'mollys_test_client');

-- ProductTags
INSERT INTO AvailableProductTags (TagID, Name, Description)
VALUES
    (1, 'koffeinhaltig', 'enthält Koffein'),
    (2, 'mit Fleisch', 'ist nicht vegetarisch');

-- ProductCathegories
INSERT INTO AvailableProductCategories
(CategoryID, Name, Description, CategoryIconURI)
VALUES
    (1, 'Getränk', 'Hier findet man alles was man trinken kann.',
     'https://philipmolares.de/images/mate/bottle-of-water.png'),
    (2, 'Essen', 'Hier findet man alles was ein Mittagessen werden könnte.',
     'https://philipmolares.de/images/mate/restaurant.png');

-- Products
INSERT INTO Product
(Productid, Name, Description, Price, TaxCategoryID,
 CategoryID, IsSaleAllowed, IsDefaultRedemption)
VALUES
    (1, 'Club Mate 0,5l', 'Der originale Mate Eistee von Löscher', 0.90, 2,
     1, TRUE, FALSE),
    (2, 'Chilli con Carne', '750ml Dose von Aldi', 1.45, 2,
     2, TRUE, FALSE);

-- ProductTags
INSERT INTO ProductTagAssignment
(ProductID, TagID)
VALUES
    (1, 1),
    (2, 2);

-- Storage
INSERT INTO Storage
(StorageID, Name, Description, IsSaleAllowed)
VALUES
    (1, 'Putzmittelraum', 'Das erste Kiosk-Lager im Keller der OH14', FALSE),
    (2, 'Kiosk', 'Verkaufslager gegen über des CZI in der OH14', TRUE);

-- SaftyStockAmountLevels
INSERT INTO SafetyStockAmountLevels
(SafetyStockAmountID, Name, ModuleIdentifier)
VALUES
    (1, 'Lager halb leer', 'email'),
    (2, 'Lager dreiviertel leer', 'email'),
    (3, 'Lager leer', 'email');

-- ProductSafetyStockAmounts
INSERT INTO ProductSafetyStockAmounts
(ProductID, SafetyStockAmountID, Amount, IsNotified)
VALUES
    (1, 1, 10, FALSE),
    (1, 2, 5, FALSE),
    (1, 3, 0, FALSE),
    (2, 1, 3, FALSE),
    (2, 2, 1, FALSE),
    (2, 3, 0, FALSE);

-- StorageContent
INSERT INTO StorageContent
(StorageID, ProductID, Amount)
VALUES
    (2, 1, 10),
    (1, 1, 10),
    (2, 2, 5);

-- StorageLog
INSERT INTO StorageLog
(StorageLogID, FromStorage, ToStorage, ProductID, Amount, TransferTimeStamp)
VALUES
    (1, NULL, 1, 1, 20, CURRENT_TIMESTAMP),
    (2, NULL, 2, 2, 5, CURRENT_TIMESTAMP),
    (3, 1, 2, 1, 10, CURRENT_TIMESTAMP);

-- Retailer
INSERT INTO Retailer
(RetailerID, Name, AdressCountry, AdressZipCode, AdressCity, AdressStreet, AdressStreetNumber, CustomerNumber)
VALUES
    (1, 'UltraHandler', 'Deutschland', '44227', 'Dortmund', 'Otto-Hahn Straße', '14', '1337');

-- RetailerContactPerson
INSERT INTO RetailerContactPerson
(ContactPersonID, FirstName, LastName, EMail, Telephone, Fax)
VALUES
    (1, 'Thomas', 'Hess', 'thomas.hess@udo.edu', '0000', '0001');

-- ContactPersonFor
INSERT INTO ContactPersonFor
(RetailerID, ContactPersonID)
VALUES
    (1, 1);

-- Persons
INSERT INTO Person
(PersonID, FirstName, LastName, EMail, CreationDate, Active)
VALUES
    (1, 'Sternhard', 'Beffen', 'test@example.com', CURRENT_TIMESTAMP, TRUE), -- customer
    (2, 'Testy', 'McTestface', 'testy@example.com', CURRENT_TIMESTAMP, TRUE), -- salesperson
    (3, 'Christoph', 'Stahl', 'christoph.stahl@udo.edu', CURRENT_TIMESTAMP, TRUE), -- admin
    (4, 'Florian', 'Friedl', 'test3@example.com', CURRENT_TIMESTAMP, TRUE), -- storeman
    (5, 'Sebatian Lukas', 'Hauer', 'sebastian.hauer@udo.edu', CURRENT_TIMESTAMP, TRUE ), -- buyer
    (6, 'Jakob', 'Vogt', 'jakob.vogt@udo.edu', CURRENT_TIMESTAMP, TRUE); -- finance

-- Customer
INSERT INTO Customer
(CustomerID, BaseBalance, BaseBalanceDate, AddedDate, Active)
VALUES
    (1, 20, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE),
    (3, 42, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE);

-- SalesPerson
INSERT INTO SalesPerson
(SalesPersonID, BaseBalance, BaseBalanceDate, AddedDate, Active)
VALUES
    (2, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE),
    (3, 0, CURRENT_TIMESTAMP, current_timestamp, TRUE),
    (4, 0, CURRENT_TIMESTAMP, current_timestamp, TRUE),
    (5, 0, CURRENT_TIMESTAMP, current_timestamp, TRUE),
    (6, 0, CURRENT_TIMESTAMP, current_timestamp, TRUE);

-- PurchaseHeader
INSERT INTO PurchaseHeader
(PurchaseID, OrderDate, InvoiceNumber, InvoiceCopy, InvoiceIsPreTax, RetailerID, SalesPersonID)
VALUES
    (1, CURRENT_TIMESTAMP, '0001', '', FALSE, 1, 2);

-- PurchaseDetail
INSERT INTO PurchaseDetail
(PurchaseDetailID, PurchaseID, ProductID, PrimeCostPerUnit, PurchaseAmount)
VALUES
    (1, 1, 1, 0.75, 20),
    (2, 1, 2, 1.20, 5);

-- ProductInstances
INSERT INTO ProductInstance
(ProductInstanceID, ProductID, InStockAmount, TaxCategoryID, AddedDate)
VALUES
    (1, 1, 20, 2, current_date),
    (2, 2, 5, 2, current_date);

-- Barcode
INSERT INTO Barcode
(BarcodeID, Barcode, ProductID)
VALUES
    (1, 'p1', 1),
    (2, 'p2', 2);

-- Credentials
INSERT INTO AvailableCredentialTypes
(credentialtypeid, name, needspassword, moduleidentifier)
VALUES
    (1, 'password', TRUE, 'password'),
    (2, 'test', TRUE, 'test');

INSERT INTO AllowedCredentialUse
(credentialtypeid, clienttypeid)
VALUES
    (1, 1),
    (2, 1);

INSERT INTO Credentials
(credentialid, credentialkey, credentialsecret, personid, credentialtypeid, issalespersonlogin, credentialcreatedate, lastsecretchange)
VALUES
    (1, 'k1', 'secret', 1, 1, FALSE, current_date, current_timestamp),
    (2, 'k2', 'secret2', 2, 1, TRUE, current_date, current_timestamp),
    (3, 'p2', 'secret3', 3, 1, TRUE, current_date, current_timestamp);
    -- (4, 'k2', 'secret2', 2, 2, TRUE, current_date, current_timestamp),
    -- (5, 'k1', 'secret', 1, 2, FALSE, current_date, current_timestamp);

INSERT INTO CredentialUse
(clienttypeid, credentialid)
VALUES
    (1, 1),
    (1, 2),
    (1, 3);

-- Rights

INSERT INTO AvailableRoles
(roleid, name, description)
VALUES
    (1, 'admin', 'basicly root'),
    (2, 'salesperson', 'someone who hooks you up with mate'),
    (3, 'storeman', 'gets mate from storage'),
    (4, 'buyer', 'buys mate'),
    (5, 'finance', 'pays initial for the mate');

INSERT INTO AvailableRights
(rightid, name, description)
VALUES
    (1, 'adminright', 'adummyright'),
    (2, 'salespersonright', 'adummyright'),
    (3, 'storemanright', 'adummyright'),
    (4, 'buyerright', 'adummyright'),
    (5, 'financeright', 'adummyright');

INSERT INTO RoleRightAssignment
(roleid, rightid)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO PersonRoleAssignment
(roleid, salespersonid)
VALUES
    (1, 3),
    (2, 2),
    (5, 6),
    (4, 5),
    (3, 4),
    (2, 3);
