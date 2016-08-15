-- ClientType
INSERT INTO ClientType (APIKey, Name, MaintainerName, MaintainerEmail) VALUES ('testapikey', 'mollys_test_client', 'Philip Molares', 'philip.molares@udo.edu');

-- Standardsteuersätze anlegen: Standard, Reduziert und Steuerbefreit
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (1, 'Standard', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (2, 'Lebensmittel', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (3, 'Steuerbefreit', 0, '%');

-- Umsatzsteuerwerte seit 1968 laut Wikipedia. Für die verwendeten TaxCategoryIDs siehe Standardeinträge in Relation TaxCategoryName
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1968-01-01', 10, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1968-07-01', 11, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1978-01-01', 12, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1979-07-01', 13, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1983-07-01', 14, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1993-01-01', 15, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '1998-04-01', 16, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (1, '2007-01-01', 19, '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1968-01-01', 5,  '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1968-07-01', 5.5,'%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1978-01-01', 6,  '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1979-07-01', 6.5,'%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1983-07-01', 7,  '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1993-01-01', 7,  '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '1998-04-01', 7,  '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (2, '2007-01-01', 7,  '%');
INSERT INTO TaxCategoryValue (TaxCategoryID, ValidSince, Value, Unit) VALUES (3, '1968-01-01', 0,  '%');

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
(Name, Description, Price, TaxCategoryID,
	CategoryID, IsSaleProhibited, IsDefaultRedemtion)
VALUES
('Club Mate 0,5l', 'Der originale Mate Eistee von Löscher', 0.90, 2,
	1, FALSE, FALSE),
('Chilli con Carne', '750ml Dose von Aldi', 1.45, 2,
	2, FALSE, FALSE);

-- ProductTags
INSERT INTO ProductTagAssignment
(ProductID, TagID)
VALUES
(1, 1),
(2, 2);

-- ProductInstances
INSERT INTO
(ProductID, InStockAmount, TaxCategoryID)
VALUES
(1, 20, 2),
(2, 5, 2);

-- Persons
INSERT INTO Person
(PersonID, FirstName, LastName, EMail, CreationDateTime, Active)
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
(1, 'p000000000001', 1),
(2, 'p000000000002', 2);

-- Storage
INSERT INTO Storage
(StorageID, Name, Description, IsSaleAllowed)
VALUES
(1, 'Putzmittelraum', 'Das erste Kiosk-Lager im Keller der OH14', FALSE),
(2, 'Kiosk', 'Verkaufslager gegen über des CZI in der OH14', TRUE)

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
(1, 1, 2, 1.20, 5);


