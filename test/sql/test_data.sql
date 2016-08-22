-- ClientType
INSERT INTO ClientType (Name) VALUES ('mollys_test_client');

-- ProductTags
INSERT INTO AvailableProductTags (TagID, Name, Description)
VALUES
    (1, 'koffeinhaltig', 'enthält Koffein'),
    (2, 'mit Fleisch', 'ist nicht vegetarisch');

-- ProductCathegories
INSERT INTO AvailableProductCategories
(CategoryID, Name, Description, CategoryIconURI)
VALUES
    (1, 'Getränk', 'Hier findet man alles was man trinken kann.', 'https://philipmolares.de/images/mate/bottle-of-water.png'),
    (2, 'Essen', 'Hier findet man alles was ein Mittagessen werden könnte.', 'https://philipmolares.de/images/mate/restaurant.png');

-- Products
INSERT INTO Product
(Productid, Name, Description, Price, TaxCategoryID,
 CategoryID, IsSaleAllowed, IsDefaultRedemption)
VALUES
    (1, 'Club Mate 0,5l', 'Der originale Mate Eistee von Löscher', 0.90, 2,
     1, FALSE, FALSE),
    (2, 'Chilli con Carne', '750ml Dose von Aldi', 1.45, 2,
     2, FALSE, FALSE);

-- ProductTags
INSERT INTO ProductTagAssignment
(ProductID, TagID)
VALUES
    (1, 1),
    (2, 2);

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

-- PurchaseHeader
INSERT INTO PurchaseHeader
(PurchaseID, OrderDate, InvoiceNumber, InvoiceCopy, InvoiceIsPreTax, RetailerID, SalesPersonID)
VALUES
    (1, CURRENT_TIMESTAMP, '0001', '', FALSE, 1, 1);

-- PurchaseDetail
INSERT INTO PurchaseDetail
(PurchaseDetailID, PurchaseID, ProductID, PrimeCostPerUnit, PurchaseAmount)
VALUES
    (1, 1, 1, 0.75, 20),
    (2, 1, 2, 1.20, 5);

-- ProductInstances
INSERT INTO ProductInstance
(ProductInstanceID, ProductID, InStockAmount, TaxCategoryID)
VALUES
    (1, 1, 20, 2),
    (2, 2, 5, 2);

-- Persons
INSERT INTO Person
(PersonID, FirstName, LastName, EMail, CreationDate, Active)
VALUES
    (1, 'Sternhard', 'Beffen', 'test@example.com', CURRENT_TIMESTAMP, TRUE),
    (2, 'Testy', 'McTestface', 'testy@example.com', CURRENT_TIMESTAMP, TRUE);

-- Customer
INSERT INTO Customer
(CustomerID, BaseBalance, BaseBalanceDate, AddedDate, Active)
VALUES
    (1, 20, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE);

-- SalesPerson
INSERT INTO SalesPerson
(SalesPersonID, BaseBalance, BaseBalanceDate, AddedDate, Active)
VALUES
    (2, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE);

-- Barcode
INSERT INTO Barcode
(BarcodeID, Barcode, ProductID)
VALUES
    (1, 'p1', 1),
    (2, 'p2', 2);

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

-- Credentials
INSERT INTO Credentials
(credentialid, credentialkey, credentialsecret, personid, credentialtypeid, issalespersonlogin, credentialcreatedate, lastsecretchange)
-- TBD


