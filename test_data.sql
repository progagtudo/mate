-- ClientType
INSERT INTO ClientType (APIKey, Name, MaintainerName, MaintainerEmail) VALUES ('testapikey', 'mollys_test_client', 'Philip Molares', 'philip.molares@udo.edu');

-- ProductTags
INSERT INTO AvailableProductTags (Name, Description) VALUES ('koffeinhaltig', 'enthält Koffein');
-- INSERT INTO AvailableProductTags (Name, Description) VALUES ('koffeinhaltig', 'enthält Koffein');

-- ProductCathegories
INSERT INTO AvailableProductCategories
(CategoryID, Name, Description, CategoryIconURI)
VALUES
(1, 'Getränk', 'Hier findet man alles was man trinken kann.', 'https://philipmolares.de/images/mate/bottle-of-water.png');

INSERT INTO AvailableProductCategories
(CategoryID, Name, Description, CategoryIconURI)
VALUES
(2, 'Essen', 'Hier findet man alles was ein Mittagessen werden könnte.', 'https://philipmolares.de/images/mate/restaurant.png');

-- Products
INSERT INTO Product 
(Name, Description, Price, TaxCategoryID,
	CategoryID, IsSaleProhibited, IsDefaultRedemtion) 
VALUES
('Club Mate 0,5l', 'Der originale Mate Eistee von Löscher', 0.90, 2,
	1, FALSE, FALSE);

INSERT INTO Product 
(Name, Description, Price, TaxCategoryID,
	CategoryID, IsSaleProhibited, IsDefaultRedemtion) 
VALUES
('Chilli con Carne', '750ml Dose von Aldi', 1.45, 2,
	2, FALSE, FALSE);

-- ProductInstances
INSERT INTO
(ProductID, InStockAmount, TaxCategoryID)
VALUES
(1, 20, 2);

INSERT INTO
(ProductID, InStockAmount, PriceOverride, TaxCategoryID)
VALUES
(2, 5, 2);