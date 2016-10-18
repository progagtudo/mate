--  COMMENT ON COLUMN . IS '';
--  COMMENT ON COLUMN .EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
--  COMMENT ON COLUMN .EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';



BEGIN TRANSACTION;

CREATE TABLE AvailableRights (
  RightID               BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableRights IS 'Detines the list of all atomic user or client rights used to recstrict access to the API calls. It is not meant to be modified as the right names are used inside the backend code.';
COMMENT ON COLUMN AvailableRights.RightID               IS 'The unique id is used as a reference to a specific right';
COMMENT ON COLUMN AvailableRights.Name                  IS 'The unique name of the right';
COMMENT ON COLUMN AvailableRights.Description           IS 'An optional description text that can clarify the intention of the right';
COMMENT ON COLUMN AvailableRights.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableRights.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AvailableRoles (
  RoleID                BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableRoles IS 'Defines the user roles. A role consists of API access rights and defines what a logged in user can do.';
COMMENT ON COLUMN AvailableRoles.RoleID                IS 'The unique id is used as a referecne to a specific role';
COMMENT ON COLUMN AvailableRoles.Name                  IS 'The usique name can be used instead of the id to reference a role';
COMMENT ON COLUMN AvailableRoles.Description           IS 'An optional description text that can clarify the intention of the role';
COMMENT ON COLUMN AvailableRoles.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableRoles.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE RoleRightAssignment (
  RoleID                BIGINT                   NOT NULL REFERENCES AvailableRoles(RoleID),
  RightID               BIGINT                   NOT NULL REFERENCES AvailableRights(RightID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(RoleID, RightID)
);
COMMENT ON TABLE  RoleRightAssignment IS 'Defines the user role scopes by assigning rights user roles.';
COMMENT ON COLUMN RoleRightAssignment.RoleID                IS 'The user role';
COMMENT ON COLUMN RoleRightAssignment.RightID               IS 'The right that is assiged to the role';
COMMENT ON COLUMN RoleRightAssignment.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN RoleRightAssignment.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Storage (
  StorageID             BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  IsSaleAllowed         BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Storage IS 'A storage is used to store products. Product sale is only allowed from a storage which has attribute IsSaleAllowed set to TRUE.';
COMMENT ON COLUMN Storage.StorageID             IS 'The unique id is used to reference a specific storage';
COMMENT ON COLUMN Storage.Name                  IS 'The unique name of a storage';
COMMENT ON COLUMN Storage.Description           IS 'The optional description can be used to provide additional location information or textual usage rules for a storage that do not (yet) fit in the database otherwise';
COMMENT ON COLUMN Storage.IsSaleAllowed         IS 'Boolean flag that indicates whether product sale is allowed in a specific storage';
COMMENT ON COLUMN Storage.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Storage.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AvailableProductCategories (
  CategoryID            BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  CategoryIconURI       TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableProductCategories IS 'Lists all available product categories. Each product can optionally be assigned to a product category. The granularity of the categories is up to the defining user.';
COMMENT ON COLUMN AvailableProductCategories.CategoryID            IS 'The unique id is used to reference a specific category';
COMMENT ON COLUMN AvailableProductCategories.Name                  IS 'The unique name of a product category.';
COMMENT ON COLUMN AvailableProductCategories.Description           IS 'An optional text description. It can be used to clarify the category intention or scope.';
COMMENT ON COLUMN AvailableProductCategories.CategoryIconURI       IS 'A URI to an external icon resource. The icon can be displayed instead of or in addition to the textual category name.';
COMMENT ON COLUMN AvailableProductCategories.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableProductCategories.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AvailableProductTags (
  TagID                 BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableProductTags IS 'Lists all available product tags. Each product can be assigned to any number of tags';
COMMENT ON COLUMN AvailableProductTags.TagID                 IS 'The unique id is used to reference a specific tag';
COMMENT ON COLUMN AvailableProductTags.Name                  IS 'The unique product tag. It should be short and to the point (like at most 3 words), as there may be many tags assigned to a product';
COMMENT ON COLUMN AvailableProductTags.Description           IS 'An optional text description, which might be useful to describe the intention or scope of the tag.';
COMMENT ON COLUMN AvailableProductTags.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableProductTags.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE TaxCategoryName (
  TaxCategoryID         BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  BaseValue             DECIMAL(10,4)            NOT NULL DEFAULT(0),
  BaseValueUnit         TEXT                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  TaxCategoryName IS 'Defines a tax category. It defines a administrative product category for which a certain amount of taxes have to be paid per sold product product unit. The exact values are defined in TaxCategoryValue';
COMMENT ON COLUMN TaxCategoryName.TaxCategoryID         IS 'The unique id is used to reference a specific tax category';
COMMENT ON COLUMN TaxCategoryName.Name                  IS 'The unique name of the tax category';
COMMENT ON COLUMN TaxCategoryName.BaseValue             IS 'The base value is a tax value that should be assigned to a product with the given tax category, if no other value is defined for this tax category, like when the earliest tax category value ValidSince value is in the future. It should rarely be useful and probably only ever be set to 0';
COMMENT ON COLUMN TaxCategoryName.BaseValueUnit         IS 'The unit used for the base value. Should probably be set to ''%'' or be left empty for an absolute base value. May also be set to values like ''‰''';
COMMENT ON COLUMN TaxCategoryName.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN TaxCategoryName.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
-- Standardsteuersätze anlegen: Standard, Reduziert und Steuerbefreit
-- Dies sind keine Testdaten, sondern die realen Daten für Deutschland, die als Standardwerte in der Datenbank vordefiniert werden sollen.
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (1, 'Standard', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (2, 'Reduziert', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (3, 'Steuerbefreit', 0, '%');


CREATE TABLE TaxCategoryValue (
  TaxCategoryID         BIGINT                   NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  ValidSince            DATE                     NOT NULL,
  Value                 DECIMAL(10,4)            NOT NULL,
  Unit                  TEXT                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  CONSTRAINT TaxCategoryValue_PrimaryKey PRIMARY KEY(TaxCategoryID, ValidSince)
);
COMMENT ON TABLE  TaxCategoryValue IS 'Defines a value for a tax category. It has a valid since date after which the entry is valid, until the next valid since entry for the same category';
COMMENT ON COLUMN TaxCategoryValue.TaxCategoryID         IS 'The tax value belongs to this tax category';
COMMENT ON COLUMN TaxCategoryValue.ValidSince            IS 'The value is valid since this date. The end date is defined the next valid since value for the same category';
COMMENT ON COLUMN TaxCategoryValue.Value                 IS 'The tax value that has to be paid for a product belonging to the category bought after the valid since date';
COMMENT ON COLUMN TaxCategoryValue.Unit                  IS 'The unit used for this value. Should probably be set to ''%'' or be left empty for an absolute base value. May also be set to values like ''‰''';
COMMENT ON COLUMN TaxCategoryValue.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN TaxCategoryValue.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT TaxCategoryValue_PrimaryKey ON TaxCategoryValue IS 'The tax category and the ValidSince date together form a primary key for the tax category value.';
-- Umsatzsteuerwerte seit 1968 laut Wikipedia. Für die verwendeten TaxCategoryIDs siehe Standardeinträge in Relation TaxCategoryName
-- Dies sind keine Testdaten, sondern die realen Daten für Deutschland, die als Standardwerte in der Datenbank vordefiniert werden sollen.
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


CREATE TABLE Product (
  ProductID             BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  Price                 DECIMAL(10,2)            NOT NULL,
  TaxCategoryID         BIGINT                   NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  CategoryID            BIGINT                       NULL REFERENCES AvailableProductCategories(CategoryID),
  IsSaleAllowed         BOOLEAN                  NOT NULL DEFAULT(TRUE),
  IsDefaultRedemption   BOOLEAN                  NOT NULL DEFAULT(FALSE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Product IS 'Describes a product with its general product information. Used in Storage, too.';
COMMENT ON COLUMN Product.ProductID             IS 'The unique id is used to reference a specific product';
COMMENT ON COLUMN Product.Name                  IS 'The product name is unique to disallow multiple products with the same name.';
COMMENT ON COLUMN Product.Description           IS 'An optional description for the product. It might contain additional information, an appeareance description or an ingrediants list.';
COMMENT ON COLUMN Product.Price                 IS 'The sale price of the product';
COMMENT ON COLUMN Product.TaxCategoryID         IS 'The tax category of a product is used as a default / template for the tax category stored in PurchaseDetail';
COMMENT ON COLUMN Product.IsSaleAllowed         IS 'Indicates whether a product is allowed to be sold, or not. It might be needed to stop a product sale for administrative purposes.';
COMMENT ON COLUMN Product.IsDefaultRedemption   IS 'Indicates whether a product is normally sold or normally redempted.';
COMMENT ON COLUMN Product.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Product.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Barcode (
  BarcodeID             BIGSERIAL                NOT NULL PRIMARY KEY,
  Barcode               TEXT                     NOT NULL UNIQUE,
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Barcode IS 'Barcode contains all product barcode used during product purchase or product sale. Logins using usernames encoded in barcodes are not stored here. See Username, Credential for user logins.';
COMMENT ON COLUMN Barcode.BarcodeID             IS 'The unique id is used to reference a specific barcode';
COMMENT ON COLUMN Barcode.Barcode               IS 'The decoded barcode content. Might be a number or any kind of (short) text encoded in a barcode';
COMMENT ON COLUMN Barcode.ProductID             IS 'The product that is linked to this barcode. Each barcode can only reference a single product.';
COMMENT ON COLUMN Barcode.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Barcode.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE SafetyStockAmountLevels (
  SafetyStockAmountID   BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  ModuleIdentifier      TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SafetyStockAmountLevels IS 'Define a stock amount level at which can be assigned to a product and given an amount to trigger an action at the definad stock amount. It is more or less just a name, like "Storage empty" or "Storage full"';
COMMENT ON COLUMN SafetyStockAmountLevels.SafetyStockAmountID   IS 'The unique id is used to reference a specific stock amount';
COMMENT ON COLUMN SafetyStockAmountLevels.Name                  IS 'The unique name of the stock amount level';
COMMENT ON COLUMN SafetyStockAmountLevels.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN SafetyStockAmountLevels.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE ProductSafetyStockAmounts (
  ProductID               BIGINT                   NOT NULL REFERENCES Product(ProductID),
  SafetyStockAmountID     BIGINT                   NOT NULL REFERENCES SafetyStockAmountLevels(SafetyStockAmountID),
  Amount                  BIGINT                   NOT NULL,
  EnableNotification      BOOLEAN                  NOT NULL DEFAULT(TRUE),
  IsNotified              BOOLEAN                  NOT NULL DEFAULT(FALSE),
  NotifyOnUnderflow       BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT ProductSafetyStockAmounts_PrimaryKey PRIMARY KEY(ProductID, SafetyStockAmountID)
);
COMMENT ON TABLE  ProductSafetyStockAmounts IS 'Define a SafetyStockAmountLevel for a product. That is, relate a stock amount with a product at an amount.';
COMMENT ON COLUMN ProductSafetyStockAmounts.ProductID             IS 'The product for which the stock amount is defined';
COMMENT ON COLUMN ProductSafetyStockAmounts.SafetyStockAmountID   IS 'The safety stock amount level ';
COMMENT ON COLUMN ProductSafetyStockAmounts.Amount                IS 'The product amount at which the stock level is related to the product';
COMMENT ON COLUMN ProductSafetyStockAmounts.EnableNotification    IS 'Enable notifications for this entry. If set to FALSE, the entry is informational and can be displayed. If TRUE, additional e-mail or instant-messaging notifications may be sent.';
COMMENT ON COLUMN ProductSafetyStockAmounts.IsNotified            IS 'Stores if the enabled notification has already been sent if the notification condition remains true, to prevent excessive spam due to a large amount of notifications triggering again and again';
COMMENT ON COLUMN ProductSafetyStockAmounts.NotifyOnUnderflow     IS 'If TRUE, send a notification if the product amount is below the stored amount (useful for normal products). If FALSE, send a notification if the product amount is above the amount (useful for normally redempted products).';
COMMENT ON COLUMN ProductSafetyStockAmounts.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ProductSafetyStockAmounts.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT ProductSafetyStockAmounts_PrimaryKey ON ProductSafetyStockAmounts IS 'The n×m relation is defined between Product and SafetyStockAmountLevels, so both PKs together form this relation PK';


CREATE TABLE ProductTagAssignment (
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  TagID                 BIGINT                   NOT NULL REFERENCES AvailableProductTags(TagID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT ProductTagAssignment_PrimaryKey PRIMARY KEY(ProductID, TagID)
);
COMMENT ON TABLE  ProductTagAssignment IS 'Assign product tags to products. Both tag and product are referenced by their numerical primary key.';
COMMENT ON COLUMN ProductTagAssignment.ProductID             IS 'The product';
COMMENT ON COLUMN ProductTagAssignment.TagID                 IS 'The product tag that is assigned to the product';
COMMENT ON COLUMN ProductTagAssignment.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ProductTagAssignment.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT ProductTagAssignment_PrimaryKey ON ProductTagAssignment IS 'Define both foreign keys as a composite PK to prevent duplicate assignments, as there are additional columns in the table definition';


CREATE TABLE StorageContent (
  StorageID             BIGINT                   NOT NULL REFERENCES Storage(StorageID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  Amount                BIGINT                   NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT StorageContent_PrimaryKey PRIMARY KEY( StorageID, ProductID )
);
COMMENT ON TABLE  StorageContent IS 'StorageContent defines the stored amount of each product in a storage';
COMMENT ON COLUMN StorageContent.StorageID             IS 'The storage';
COMMENT ON COLUMN StorageContent.ProductID             IS 'The referenced product';
COMMENT ON COLUMN StorageContent.Amount                IS 'The product amount stored in the storage. Should always be positive. A negative number is allowed but means an inconsistency occured like a double sold or unlogged product.';
COMMENT ON COLUMN StorageContent.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN StorageContent.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT StorageContent_PrimaryKey ON StorageContent IS 'The n×m relation is defined between Storage and Product, so both PKs together form this relation PK';


CREATE TABLE StorageLog (
  StorageLogID          BIGSERIAL                NOT NULL PRIMARY KEY,
  FromStorage           BIGINT                       NULL REFERENCES Storage(StorageID),
  ToStorage             BIGINT                       NULL REFERENCES Storage(StorageID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  Amount                BIGINT                   NOT NULL,
  TransferTimestamp     TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT OneStorageMustExist CHECK( FromStorage IS NOT NULL OR ToStorage IS NOT NULL )
);
COMMENT ON TABLE  StorageLog IS 'StorageLog is a logged product shift from one storage to another. If FromStorage is NULL, a newly purchased product is put into a storage. If ToStorage is NULL, a product is given out of the system, because it was sold or stolen.';
COMMENT ON COLUMN StorageLog.FromStorage           IS 'The storage where the product is taken from, If NULL, the product is newly put into a storage.';
COMMENT ON COLUMN StorageLog.ToStorage             IS 'The storage where the product is put into. If NULL, the product is completely removed from the system.';
COMMENT ON COLUMN StorageLog.ProductID             IS 'The shifted/added/removed product';
COMMENT ON COLUMN StorageLog.Amount                IS 'The shifted/added/removed product amount';
COMMENT ON COLUMN StorageLog.TransferTimestamp     IS 'The shift/transfer timestamp.';
COMMENT ON COLUMN StorageLog.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN StorageLog.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT OneStorageMustExist ON StorageLog IS 'At least one storage must exist. Both storages beeing NULL is invalid, as this has no useful semantics.';


CREATE TABLE Retailer (
  RetailerID            BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL,
  AdressCountry         TEXT                         NULL,
  AdressZipCode         TEXT                         NULL,
  AdressCity            TEXT                         NULL,
  AdressStreet          TEXT                         NULL,
  AdressStreetNumber    TEXT                         NULL,
  CustomerNumber        TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Retailer IS 'Products can be ordered or purchased at retailers.';
COMMENT ON COLUMN Retailer.RetailerID            IS 'The unique id is used to reference a specific retailer.';
COMMENT ON COLUMN Retailer.Name                  IS 'The retailer name is the only required attribute for a retailer, as the rest may not be known or existant.';
COMMENT ON COLUMN Retailer.AdressCountry         IS 'Retailer adress: Country';
COMMENT ON COLUMN Retailer.AdressZipCode         IS 'Retailer adress: Zip/postal code';
COMMENT ON COLUMN Retailer.AdressCity            IS 'Retailer adress: City';
COMMENT ON COLUMN Retailer.AdressStreet          IS 'Retailer adress: Street name';
COMMENT ON COLUMN Retailer.AdressStreetNumber    IS 'Retailer adress: Street number. May be any text like ''4A''';
COMMENT ON COLUMN Retailer.CustomerNumber        IS 'A customer number registered at the retailer.';
COMMENT ON COLUMN Retailer.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Retailer.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE RetailerContactPerson (
  ContactPersonID       BIGSERIAL                NOT NULL PRIMARY KEY,
  FirstName             TEXT                         NULL,
  LastName              TEXT                     NOT NULL,
  EMail                 TEXT                         NULL,
  Telephone             TEXT                         NULL,
  Fax                   TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  RetailerContactPerson IS 'Some retailers assign a contact person to a customer to aid the purchase process.';
COMMENT ON COLUMN RetailerContactPerson.ContactPersonID       IS 'The unique id is used to reference a specific contact person';
COMMENT ON COLUMN RetailerContactPerson.FirstName             IS 'The contact person’s first name might not be known';
COMMENT ON COLUMN RetailerContactPerson.LastName              IS 'The last name is required.';
COMMENT ON COLUMN RetailerContactPerson.EMail                 IS 'There might be an e-mail adress known used for e-mail conversations';
COMMENT ON COLUMN RetailerContactPerson.Telephone             IS 'The contact person might be reachable by telephone';
COMMENT ON COLUMN RetailerContactPerson.Fax                   IS 'The contact person might be reachable by fax';
COMMENT ON COLUMN RetailerContactPerson.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN RetailerContactPerson.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE ContactPersonFor (
  RetailerID            BIGINT                   NOT NULL REFERENCES Retailer(RetailerID),
  ContactPersonID       BIGINT                   NOT NULL REFERENCES RetailerContactPerson(ContactPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY(RetailerID, ContactPersonID)
);
COMMENT ON TABLE  ContactPersonFor IS 'ContactPersonFor models the work relation between a retailer and a contact person.';
COMMENT ON COLUMN ContactPersonFor.RetailerID            IS 'The workplace of the contact person.';
COMMENT ON COLUMN ContactPersonFor.ContactPersonID       IS 'The contact person.';
COMMENT ON COLUMN ContactPersonFor.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ContactPersonFor.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Person (
  PersonID              BIGSERIAL                NOT NULL PRIMARY KEY,
  FirstName             TEXT                     NOT NULL,
  LastName              TEXT                     NOT NULL,
  EMail                 TEXT                     NOT NULL UNIQUE,
  CreationDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Person IS 'A person that can be granted access to the system. See RetailerContactPerson for contact persons working at a retailer.';
COMMENT ON COLUMN Person.FirstName             IS 'The person’s first name';
COMMENT ON COLUMN Person.LastName              IS 'The person’s last name';
COMMENT ON COLUMN Person.EMail                 IS 'The e-mail must be unique to reset login credentials or uniquely identify a person';
COMMENT ON COLUMN Person.CreationDate          IS 'The creation date for the person';
COMMENT ON COLUMN Person.Active                IS 'Can be used to completely deactivate an account';
COMMENT ON COLUMN Person.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Person.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Customer (
  CustomerID            BIGINT                   NOT NULL PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);



CREATE TABLE SalesPerson (
  SalesPersonID         BIGINT                   NOT NULL PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);



CREATE TABLE PersonRoleAssignment (
  RoleID                BIGINT  NOT NULL REFERENCES AvailableRoles(RoleID),
  SalesPersonID         BIGINT  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(RoleID, SalesPersonID)
);



CREATE TABLE PurchaseHeader (
  PurchaseID            BIGSERIAL                NOT NULL PRIMARY KEY,
  OrderDate             DATE                     NOT NULL DEFAULT(CURRENT_DATE),
  InvoiceNumber         TEXT                         NULL,
  InvoiceCopy           BYTEA                        NULL,
  InvoiceIsPreTax       BOOLEAN                  NOT NULL,
  RetailerID            BIGINT                   NOT NULL REFERENCES Retailer(RetailerID),
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP) ,
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  PurchaseHeader IS 'PurchaseHeader is a cart at a retailer. Its elements are stored in PurchaseDetail.';
COMMENT ON COLUMN PurchaseHeader.PurchaseID            IS 'The unique id is used to reference a specific purchase';
COMMENT ON COLUMN PurchaseHeader.OrderDate             IS 'The order or purchase date. It is a still open order, if there are no product instances in the database for this purchase';
COMMENT ON COLUMN PurchaseHeader.InvoiceNumber         IS 'An optional invoice number. One is available, if products are oredered';
COMMENT ON COLUMN PurchaseHeader.InvoiceCopy           IS 'An optional copy of the invoice. Can be a scanned picture of the invoice for reference purposes.';
COMMENT ON COLUMN PurchaseHeader.InvoiceIsPreTax       IS 'Defines if the price on the associated purchase details already contains the taxes';
COMMENT ON COLUMN PurchaseHeader.RetailerID            IS 'The retailer where the order / purchase was done';
COMMENT ON COLUMN PurchaseHeader.SalesPersonID         IS 'Each order / purchase is done by a staff member';
COMMENT ON COLUMN PurchaseHeader.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN PurchaseHeader.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE PurchaseDetail (
  PurchaseDetailID      BIGSERIAL                NOT NULL PRIMARY KEY,
  PurchaseID            BIGINT                   NOT NULL REFERENCES PurchaseHeader(PurchaseID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  OrderAmount           BIGINT                   NOT NULL,
  IsShipped             BOOLEAN                  NOT NULL,
  PurchaseAmount        BIGINT                       NULL,
  PrimeCostPerUnit      DECIMAL(10, 2)           NOT NULL,
  TaxCategoryID         BIGINT                   NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  BestBeforeDate        DATE                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT PurchaseAmountSetIfShipped CHECK(IsShipped IS FALSE OR PurchaseAmount IS NOT NULL) -- IsShipped = TRUE implies PurchaseAmount IS NOT NULL
);
COMMENT ON TABLE  PurchaseDetail IS 'A purchase consists of several purchased products. Each oredered / purchased product has an entry in this table.';
COMMENT ON COLUMN PurchaseDetail.PurchaseDetailID      IS 'The unique id is used to reference a specific purchase detail';
COMMENT ON COLUMN PurchaseDetail.PurchaseID            IS 'The detail belongs to a purchase cart';
COMMENT ON COLUMN PurchaseDetail.ProductID             IS 'The ordered / purchased product';
COMMENT ON COLUMN PurchaseDetail.OrderAmount           IS 'The ordered product amount.';
COMMENT ON COLUMN PurchaseDetail.IsShipped             IS 'If TRUE, the ordered product is shipped and the purchase amount must be set. ';
COMMENT ON COLUMN PurchaseDetail.PurchaseAmount        IS 'The oredered / purchased product amount.';
COMMENT ON COLUMN PurchaseDetail.BestBeforeDate        IS 'Optional best before date.';
COMMENT ON COLUMN PurchaseDetail.PrimeCostPerUnit      IS 'The paid price per single product';
COMMENT ON COLUMN PurchaseDetail.TaxCategoryID         IS 'The tax category for this specific product purchase. It might be different from the default stored in Product';
COMMENT ON COLUMN PurchaseDetail.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN PurchaseDetail.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT PurchaseAmountSetIfShipped ON PurchaseDetail IS 'The PurchaseAmount is NULL, if the product is not yet shipped. It must be set, if the product is shipped.a';


CREATE TABLE SaleHeader (
  SaleID                BIGSERIAL                NOT NULL PRIMARY KEY,
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  CustomerID            BIGINT                   NOT NULL REFERENCES Customer(CustomerID),
  SalesDateTime         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SaleHeader IS 'SaleHeader is a sold customer cart. Its elements are stored in SaleDetail.';
COMMENT ON COLUMN SaleHeader.SaleID                IS 'The unique id is used to reference a specific sale cart.';
COMMENT ON COLUMN SaleHeader.SalesPersonID         IS 'The staff member that sold the products to the customer';
COMMENT ON COLUMN SaleHeader.CustomerID            IS 'The purchasing customer.';
COMMENT ON COLUMN SaleHeader.SalesDateTime         IS 'The timestamp at which the cart was sold.';
COMMENT ON COLUMN SaleHeader.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN SaleHeader.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE SaleDetail (
  SaleDetailID          BIGSERIAL                NOT NULL PRIMARY KEY,
  SaleID                BIGINT                   NOT NULL REFERENCES SaleHeader(SaleID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  UnitPrice             DECIMAL(10,4)            NOT NULL,
  UnitQuantity          BIGINT                   NOT NULL,
  IsRedemption          BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SaleDetail IS 'A sale consists of several sold products. Each sold product has an entry in this table.';
COMMENT ON COLUMN SaleDetail.SaleDetailID          IS 'The unique id is used to reference a specific sale detail.';
COMMENT ON COLUMN SaleDetail.SaleID                IS 'The detail belongs to a sale cart';
COMMENT ON COLUMN SaleDetail.ProductID             IS 'The sold product.';
COMMENT ON COLUMN SaleDetail.UnitPrice             IS 'The unit price at which the product is sold';
COMMENT ON COLUMN SaleDetail.UnitQuantity          IS 'The sold product amount';
COMMENT ON COLUMN SaleDetail.IsRedemption          IS 'If set to TRUE, the detail is a product redemption.';
COMMENT ON COLUMN SaleDetail.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN SaleDetail.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE ClientType (
  ClientTypeID          BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  ClientType IS 'ClientType defines a type of application that is connected to the backend. It may be something like a sale client, a storage management client, a customer web client or an admin client.
It can used to limit the scope of login credentials. It might be desireable to have credential-less logins for controlled clients, but not for the web interface, so each credential type can be limited to certain client types.';
COMMENT ON COLUMN ClientType.ClientTypeID          IS 'The unique id is used to reference a specific client type';
COMMENT ON COLUMN ClientType.Name                  IS 'The unique client type name. ';
COMMENT ON COLUMN ClientType.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ClientType.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Client (
  ClientID              BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  ClientTypeID          BIGINT                   NOT NULL REFERENCES ClientType(ClientTypeID),
  ClientSecret          BYTEA                    NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);


CREATE TABLE AvailableCredentialTypes (
  CredentialTypeID      BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  NeedsPassword         BOOLEAN                  NOT NULL,
  ModuleIdentifier      TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableCredentialTypes IS 'A credential secret blob might be of different types, like a hashed password or a X.509 certificate public key used for smartcard authentification';
COMMENT ON COLUMN AvailableCredentialTypes.CredentialTypeID      IS 'The unique id is used to reference a specific credential type.';
COMMENT ON COLUMN AvailableCredentialTypes.Name                  IS 'The unique name of this credential type. More or less informational purposes.';
COMMENT ON COLUMN AvailableCredentialTypes.NeedsPassword         IS 'If set to TRUE, all Credentials with this type need a password. If FALSE, dummy credentials without secret with this type are possible.';
COMMENT ON COLUMN AvailableCredentialTypes.ModuleIdentifier      IS 'A module that can be used for secrets of this type (LEGACY?)';
COMMENT ON COLUMN AvailableCredentialTypes.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableCredentialTypes.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AllowedCredentialUse (
  CredentialTypeID      BIGINT                   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  ClientTypeID          BIGINT                   NOT NULL REFERENCES ClientType(ClientTypeID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY (CredentialTypeID, ClientTypeID)
);


CREATE TABLE Username (
  UsernameID            BIGSERIAL                NOT NULL PRIMARY KEY,
  Username              TEXT                     NOT NULL UNIQUE,
  PersonID              BIGINT                   NOT NULL REFERENCES Person(PersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
  
);
COMMENT ON TABLE  Username IS 'A username identifies a person for login purposes. Belongs to exactly one person.';
COMMENT ON COLUMN Username.UsernameID            IS 'The unique id is used to reference a specific username';
COMMENT ON COLUMN Username.Username              IS 'The unique username is used to login a user into the system.';
COMMENT ON COLUMN Username.PersonID              IS 'The person to which this username belongs.';
COMMENT ON COLUMN Username.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Username.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Credential (
  CredentialID          BIGSERIAL                NOT NULL PRIMARY KEY,
  CredentialSecret      BYTEA                        NULL,
  UsernameID            BIGINT                   NOT NULL REFERENCES Username(UsernameID),
  CredentialTypeID      BIGINT                   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  IsSalesPersonLogin    BOOLEAN                  NOT NULL,
  CredentialCreateDate  DATE                     NOT NULL,
  LastSecretChange      TIMESTAMP WITH TIME ZONE     NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Credential IS 'A credential is a secret login information blob used together with a username.';
COMMENT ON COLUMN Credential.CredentialID          IS 'The unique id is used to reference a specific credential.';
COMMENT ON COLUMN Credential.CredentialSecret      IS 'The secret blob type depends on the credential type, which is a hashed password or a public key. It is not unique, so multiple users can have the same credential without knowing this fact.';
COMMENT ON COLUMN Credential.UsernameID            IS 'The username to which this credential belongs';
COMMENT ON COLUMN Credential.CredentialTypeID      IS 'The credential type defines the type of the credential blob.';
COMMENT ON COLUMN Credential.IsSalesPersonLogin    IS 'Defines if this credential is used for a customer or staff login.';
COMMENT ON COLUMN Credential.CredentialCreateDate  IS 'The creation date for this credential.';
COMMENT ON COLUMN Credential.LastSecretChange      IS 'The last password change timestamp. May be used to enforce password changes after a given time period elapsed.';
COMMENT ON COLUMN Credential.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Credential.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE CredentialUse (
  ClientTypeID          BIGINT                   NOT NULL REFERENCES ClientType(ClientTypeID),
  CredentialID          BIGINT                   NOT NULL REFERENCES Credential(CredentialID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY (CredentialID, ClientTypeID)
);
COMMENT ON TABLE  CredentialUse IS 'Defines which credential can be used at which client type.';



CREATE TABLE Charge (
  ChargeID              BIGSERIAL                NOT NULL PRIMARY KEY,
  CustomerID            BIGINT                   NOT NULL REFERENCES Customer(CustomerID),
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  Donation              BOOLEAN                  NOT NULL DEFAULT(FALSE),
  ChargeAmount          DECIMAL(10,2)            NOT NULL,
  ChargeDate            TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Charge IS 'Charge saves the customer balance recharges. If a customer credits his account by giving money to a staff member, an entry is created in this table.';
COMMENT ON COLUMN Charge.ChargeID              IS 'The unique id is used to reference a specific charge.';
COMMENT ON COLUMN Charge.CustomerID            IS 'The customer who credits his account.';
COMMENT ON COLUMN Charge.SalesPersonID         IS 'The staff member who receives the money. This debits the staff members account.';
COMMENT ON COLUMN Charge.Donation              IS 'A customer may donate money instead of crediting his account. If set to TRUE, the customer does not credit his account, but the staff member still debits his account.';
COMMENT ON COLUMN Charge.ChargeAmount          IS 'The received amount of money';
COMMENT ON COLUMN Charge.ChargeDate            IS 'The exact charge timestamp';
COMMENT ON COLUMN Charge.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Charge.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Repayment (
  RepaymentID             BIGSERIAL                NOT NULL PRIMARY KEY,
  SalesPersonID           BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  TransactionDate         DATE                     NOT NULL,
  Amount                  DECIMAL(10, 2)           NOT NULL,
  RequiredAmountRedeemers BIGINT                   NOT NULL DEFAULT(1),
  EntryAddedDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT PositiveRequiredAmountRedeemers CHECK(RequiredAmountRedeemers >= 0)
);
COMMENT ON TABLE  Repayment IS 'The recharge of money on a customer account debits the staff members account. The repayment balances the staff members account.';
COMMENT ON COLUMN Repayment.RepaymentID             IS 'The unique id is used to reference a specific repayment';
COMMENT ON COLUMN Repayment.SalesPersonID           IS 'The staff member who repaid money';
COMMENT ON COLUMN Repayment.TransactionDate         IS 'The transaction date.';
COMMENT ON COLUMN Repayment.Amount                  IS 'The paid amount of money';
COMMENT ON COLUMN Repayment.RequiredAmountRedeemers IS 'Required amount of acknowledgements by financial officers to mark this repayment as done.';
COMMENT ON COLUMN Repayment.EntryAddedDate          IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Repayment.EntryLastModifiedDate   IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT PositiveRequiredAmountRedeemers ON Repayment IS 'The required amount of acknowledgements must not be negative.';


CREATE TABLE RedeemerFor (
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  RepaymentID           BIGINT                   NOT NULL REFERENCES Repayment(RepaymentID),
  AcknowledgedDate      DATE                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(SalesPersonID, RepaymentID)
);
COMMENT ON TABLE RedeemerFor IS 'A repayment must be acknowledged by financial officers to be accepted. This table stores the acknowledgements.';


CREATE VIEW TaxCategory AS
  SELECT 
    n.TaxCategoryID,
    n.Name,
    '1337-01-01'::DATE AS ValidSince,
    n.BaseValue AS Value,
    n.BaseValueUnit AS Unit
  FROM TaxCategoryName AS n
  UNION ALL
  SELECT
    n.TaxCategoryID,
    n.Name,
    v.ValidSince,
    v.Value,
    v.Unit
  FROM TaxCategoryName AS n
  JOIN TaxCategoryValue AS v ON n.TaxCategoryID = v.TaxCategoryID
;
COMMENT ON VIEW TaxCategory IS 'TaxCategory joins TaxCategoryName and TaxCategoryValue.';


CREATE VIEW ProductTaxes AS
  SELECT
    p.ProductID,
    h.PurchaseID,
    d.PurchaseDetailID,
    p.Name AS ProductName,
    h.OrderDate AS ProductOrderDate,
    t.TaxCategoryID,
    t.ValidSince AS TaxCategoryValidSince,
    t.Name AS TaxCategoryName,
    t.Value AS TaxAmount,
    t.Unit AS TaxUnit
  FROM Product        AS p
  JOIN PurchaseDetail AS d ON p.ProductID     = d.ProductID
  JOIN PurchaseHeader AS h ON h.PurchaseID    = d.PurchaseID
    
  JOIN TaxCategory    AS t ON d.TaxCategoryID = t.TaxCategoryID
  WHERE t.ValidSince = (
    SELECT MAX(t2.ValidSince)
    FROM TaxCategory AS t2
    WHERE h.OrderDate >= t2.ValidSince
  )
;
COMMENT ON VIEW ProductTaxes IS 'Computes the exact taxes for each product purchase.';


CREATE VIEW CustomerCharges AS
  SELECT
    cu.CustomerID,
    cp.FirstName   AS CustomerFirstName,
    cp.LastName    AS CustomerLastName,
    sp.SalesPersonID,
    spp.FirstName  AS SalesPersonFirstName,
    spp.LastName   AS SalesPersonLastName,
    ch.ChargeID,
    ch.ChargeDate,
    ch.ChargeAmount,
    ch.Donation AS IsDonation
  FROM Person AS cp -- cp Customer Person
    JOIN Customer AS cu    ON cp.PersonID = cu.CustomerID
    JOIN Charge AS ch      ON cu.CustomerID = ch.CustomerID
    JOIN SalesPerson AS sp ON ch.SalesPersonID = sp.SalesPersonID
    JOIN Person AS spp     ON sp.SalesPersonID = spp.PersonID --spp SalesPerson Person
;
COMMENT ON VIEW CustomerCharges IS 'Computes an overview of all customer account charges.';


CREATE VIEW CustomerBalance AS
  SELECT
    cu.CustomerID,
    (cu.BaseBalance
      + COALESCE(CustChargeSum.Charge, 0) -- is NULL, if the customer has never charged his balance
      - COALESCE(CustSaleSum.SaleTotal, 0) -- is NULL, if the customer has never purchased or redempted any product
    ) AS Balance
  
  FROM Customer AS cu
  
  LEFT OUTER JOIN ( -- sum of all charges
    SELECT ch.CustomerID, SUM( ch.ChargeAmount) AS Charge
    FROM Charge AS ch
    WHERE ch.Donation IS FALSE
    GROUP BY ch.CustomerID
  ) AS CustChargeSum ON CustChargeSum.CustomerID = cu.CustomerID
  
  LEFT OUTER JOIN ( -- sum of all product sales and redemptions. The case structure inside the SUM aggregate replaces another left outer join for all redemptions
    SELECT sh.CustomerID,
    SUM( sd.UnitQuantity * 
      CASE
        WHEN sd.IsRedemption IS FALSE THEN sd.UnitPrice -- Sum up sales
        ELSE -sd.UnitPrice -- sd.IsRedemption IS TRUE, substract all redemptions
      END) AS SaleTotal
    FROM SaleHeader AS sh
    JOIN SaleDetail AS sd ON sh.SaleID = sd.SaleID
    GROUP BY sh.CustomerID
  ) AS CustSaleSum ON CustSaleSum.CustomerID = cu.CustomerID
;
COMMENT ON VIEW CustomerBalance IS 'Calculates the customer balance as a sum of all charges and product redemptions minus all product sales';


CREATE VIEW SalesPersonBalance AS
  SELECT
    sp.SalesPersonID,
    (sp.BaseBalance
      - COALESCE(SPChargeSum.Charge, 0) -- is NULL, if the staff member has never accepted any charges
      + COALESCE(SPRepaymentSum.RepaidAmount, 0) -- is NULL, if the staff member has no acknowledged repayments
    ) AS Balance,
    COALESCE(SPOpenRepaymentSum.OpenRepaymentAmount, 0) AS OpenRepaymentAmount -- is NULL, if the staff member has no open repayments
  
  FROM SalesPerson AS sp
  
  LEFT OUTER JOIN ( -- sum of all charges
    SELECT
      ch.SalesPersonID,
      SUM( ch.ChargeAmount ) AS Charge
    FROM Charge AS ch
    -- Do not filter out donations, as the stuff balance is charged for donations, too
    GROUP BY ch.SalesPersonID
  ) AS SPChargeSum ON SPChargeSum.SalesPersonID = sp.SalesPersonID
  
  LEFT OUTER JOIN ( -- sum of all completely redempted repayments
    SELECT
      rp.SalesPersonID,
      SUM( rp.Amount) AS RepaidAmount
    FROM Repayment AS rp
    WHERE rp.RequiredAmountRedeemers <= ( -- The number of acknowledges must be greater or equal to RequiredAmountRedeemers
      -- SELECT COUNT(*) is a safe aggregate function for subqueries,
      -- as it guarantees to always return exactly one value.
      SELECT COUNT(*) 
      FROM RedeemerFor AS rf
      WHERE rf.RepaymentID = rp.RepaymentID
    )
    GROUP BY rp.SalesPersonID
  ) AS SPRepaymentSum ON SPRepaymentSum.SalesPersonID = sp.SalesPersonID
  LEFT OUTER JOIN ( -- sum of still open repayments
    SELECT
      rp.SalesPersonID,
      SUM( rp.Amount) AS OpenRepaymentAmount
    FROM Repayment AS rp
    WHERE rp.RequiredAmountRedeemers > ( -- If the number of acknowledges is lesser than RequiredAmountRedeemers, the repayment is still open
      -- SELECT COUNT(*) is a safe aggregate function for subqueries,
      -- as it guarantees to always return exactly one value.
      SELECT COUNT(*) 
      FROM RedeemerFor AS rf
      WHERE rf.RepaymentID = rp.RepaymentID
    )
    GROUP BY rp.SalesPersonID
  ) AS SPOpenRepaymentSum ON SPOpenRepaymentSum.SalesPersonID = sp.SalesPersonID
  
;
COMMENT ON VIEW SalesPersonBalance IS 'Calculates the staff member balance as a sum of all charges and acknowleded repayments. It also supplies the sum of all still open repayments';


CREATE VIEW ProductsInStock AS
  SELECT
    p.ProductID,
    p.Name,
    p.Description,
    p.Price,
    p.TaxCategoryID,
    p.CategoryID,
    p.IsSaleAllowed,
    p.IsDefaultRedemption,
    COALESCE(InStock.InStockAmount, 0) AS InStockAmount
  FROM Product AS p
  LEFT OUTER JOIN (
    SELECT
      sc.ProductID,
      SUM(sc.Amount) AS InStockAmount
    FROM StorageContent AS sc
    GROUP BY sc.ProductID
  ) AS InStock ON p.ProductID = InStock.ProductID
;
COMMENT ON VIEW ProductsInStock IS 'Calculates the current product stock amounts for all products.';


COMMIT;--  COMMENT ON COLUMN . IS '';
--  COMMENT ON COLUMN .EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
--  COMMENT ON COLUMN .EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';



BEGIN TRANSACTION;

CREATE TABLE AvailableRights (
  RightID               BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableRights IS 'Detines the list of all atomic user or client rights used to recstrict access to the API calls. It is not meant to be modified as the right names are used inside the backend code.';
COMMENT ON COLUMN AvailableRights.RightID               IS 'The unique id is used as a reference to a specific right';
COMMENT ON COLUMN AvailableRights.Name                  IS 'The unique name of the right';
COMMENT ON COLUMN AvailableRights.Description           IS 'An optional description text that can clarify the intention of the right';
COMMENT ON COLUMN AvailableRights.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableRights.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AvailableRoles (
  RoleID                BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableRoles IS 'Defines the user roles. A role consists of API access rights and defines what a logged in user can do.';
COMMENT ON COLUMN AvailableRoles.RoleID                IS 'The unique id is used as a referecne to a specific role';
COMMENT ON COLUMN AvailableRoles.Name                  IS 'The usique name can be used instead of the id to reference a role';
COMMENT ON COLUMN AvailableRoles.Description           IS 'An optional description text that can clarify the intention of the role';
COMMENT ON COLUMN AvailableRoles.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableRoles.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE RoleRightAssignment (
  RoleID                BIGINT                   NOT NULL REFERENCES AvailableRoles(RoleID),
  RightID               BIGINT                   NOT NULL REFERENCES AvailableRights(RightID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(RoleID, RightID)
);
COMMENT ON TABLE  RoleRightAssignment IS 'Defines the user role scopes by assigning rights user roles.';
COMMENT ON COLUMN RoleRightAssignment.RoleID                IS 'The user role';
COMMENT ON COLUMN RoleRightAssignment.RightID               IS 'The right that is assiged to the role';
COMMENT ON COLUMN RoleRightAssignment.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN RoleRightAssignment.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Storage (
  StorageID             BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  IsSaleAllowed         BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Storage IS 'A storage is used to store products. Product sale is only allowed from a storage which has attribute IsSaleAllowed set to TRUE.';
COMMENT ON COLUMN Storage.StorageID             IS 'The unique id is used to reference a specific storage';
COMMENT ON COLUMN Storage.Name                  IS 'The unique name of a storage';
COMMENT ON COLUMN Storage.Description           IS 'The optional description can be used to provide additional location information or textual usage rules for a storage that do not (yet) fit in the database otherwise';
COMMENT ON COLUMN Storage.IsSaleAllowed         IS 'Boolean flag that indicates whether product sale is allowed in a specific storage';
COMMENT ON COLUMN Storage.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Storage.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AvailableProductCategories (
  CategoryID            BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  CategoryIconURI       TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableProductCategories IS 'Lists all available product categories. Each product can optionally be assigned to a product category. The granularity of the categories is up to the defining user.';
COMMENT ON COLUMN AvailableProductCategories.CategoryID            IS 'The unique id is used to reference a specific category';
COMMENT ON COLUMN AvailableProductCategories.Name                  IS 'The unique name of a product category.';
COMMENT ON COLUMN AvailableProductCategories.Description           IS 'An optional text description. It can be used to clarify the category intention or scope.';
COMMENT ON COLUMN AvailableProductCategories.CategoryIconURI       IS 'A URI to an external icon resource. The icon can be displayed instead of or in addition to the textual category name.';
COMMENT ON COLUMN AvailableProductCategories.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableProductCategories.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AvailableProductTags (
  TagID                 BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableProductTags IS 'Lists all available product tags. Each product can be assigned to any number of tags';
COMMENT ON COLUMN AvailableProductTags.TagID                 IS 'The unique id is used to reference a specific tag';
COMMENT ON COLUMN AvailableProductTags.Name                  IS 'The unique product tag. It should be short and to the point (like at most 3 words), as there may be many tags assigned to a product';
COMMENT ON COLUMN AvailableProductTags.Description           IS 'An optional text description, which might be useful to describe the intention or scope of the tag.';
COMMENT ON COLUMN AvailableProductTags.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableProductTags.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE TaxCategoryName (
  TaxCategoryID         BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  BaseValue             DECIMAL(10,4)            NOT NULL DEFAULT(0),
  BaseValueUnit         TEXT                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  TaxCategoryName IS 'Defines a tax category. It defines a administrative product category for which a certain amount of taxes have to be paid per sold product product unit. The exact values are defined in TaxCategoryValue';
COMMENT ON COLUMN TaxCategoryName.TaxCategoryID         IS 'The unique id is used to reference a specific tax category';
COMMENT ON COLUMN TaxCategoryName.Name                  IS 'The unique name of the tax category';
COMMENT ON COLUMN TaxCategoryName.BaseValue             IS 'The base value is a tax value that should be assigned to a product with the given tax category, if no other value is defined for this tax category, like when the earliest tax category value ValidSince value is in the future. It should rarely be useful and probably only ever be set to 0';
COMMENT ON COLUMN TaxCategoryName.BaseValueUnit         IS 'The unit used for the base value. Should probably be set to ''%'' or be left empty for an absolute base value. May also be set to values like ''‰''';
COMMENT ON COLUMN TaxCategoryName.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN TaxCategoryName.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
-- Standardsteuersätze anlegen: Standard, Reduziert und Steuerbefreit
-- Dies sind keine Testdaten, sondern die realen Daten für Deutschland, die als Standardwerte in der Datenbank vordefiniert werden sollen.
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (1, 'Standard', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (2, 'Reduziert', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (3, 'Steuerbefreit', 0, '%');


CREATE TABLE TaxCategoryValue (
  TaxCategoryID         BIGINT                   NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  ValidSince            DATE                     NOT NULL,
  Value                 DECIMAL(10,4)            NOT NULL,
  Unit                  TEXT                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  CONSTRAINT TaxCategoryValue_PrimaryKey PRIMARY KEY(TaxCategoryID, ValidSince)
);
COMMENT ON TABLE  TaxCategoryValue IS 'Defines a value for a tax category. It has a valid since date after which the entry is valid, until the next valid since entry for the same category';
COMMENT ON COLUMN TaxCategoryValue.TaxCategoryID         IS 'The tax value belongs to this tax category';
COMMENT ON COLUMN TaxCategoryValue.ValidSince            IS 'The value is valid since this date. The end date is defined the next valid since value for the same category';
COMMENT ON COLUMN TaxCategoryValue.Value                 IS 'The tax value that has to be paid for a product belonging to the category bought after the valid since date';
COMMENT ON COLUMN TaxCategoryValue.Unit                  IS 'The unit used for this value. Should probably be set to ''%'' or be left empty for an absolute base value. May also be set to values like ''‰''';
COMMENT ON COLUMN TaxCategoryValue.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN TaxCategoryValue.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT TaxCategoryValue_PrimaryKey ON TaxCategoryValue IS 'The tax category and the ValidSince date together form a primary key for the tax category value.';
-- Umsatzsteuerwerte seit 1968 laut Wikipedia. Für die verwendeten TaxCategoryIDs siehe Standardeinträge in Relation TaxCategoryName
-- Dies sind keine Testdaten, sondern die realen Daten für Deutschland, die als Standardwerte in der Datenbank vordefiniert werden sollen.
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


CREATE TABLE Product (
  ProductID             BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  Price                 DECIMAL(10,2)            NOT NULL,
  TaxCategoryID         BIGINT                   NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  CategoryID            BIGINT                       NULL REFERENCES AvailableProductCategories(CategoryID),
  IsSaleAllowed         BOOLEAN                  NOT NULL DEFAULT(TRUE),
  IsDefaultRedemption   BOOLEAN                  NOT NULL DEFAULT(FALSE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Product IS 'Describes a product with its general product information. Used in Storage, too.';
COMMENT ON COLUMN Product.ProductID             IS 'The unique id is used to reference a specific product';
COMMENT ON COLUMN Product.Name                  IS 'The product name is unique to disallow multiple products with the same name.';
COMMENT ON COLUMN Product.Description           IS 'An optional description for the product. It might contain additional information, an appeareance description or an ingrediants list.';
COMMENT ON COLUMN Product.Price                 IS 'The sale price of the product';
COMMENT ON COLUMN Product.TaxCategoryID         IS 'The tax category of a product is used as a default / template for the tax category stored in PurchaseDetail';
COMMENT ON COLUMN Product.IsSaleAllowed         IS 'Indicates whether a product is allowed to be sold, or not. It might be needed to stop a product sale for administrative purposes.';
COMMENT ON COLUMN Product.IsDefaultRedemption   IS 'Indicates whether a product is normally sold or normally redempted.';
COMMENT ON COLUMN Product.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Product.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Barcode (
  BarcodeID             BIGSERIAL                NOT NULL PRIMARY KEY,
  Barcode               TEXT                     NOT NULL UNIQUE,
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Barcode IS 'Barcode contains all product barcode used during product purchase or product sale. Logins using usernames encoded in barcodes are not stored here. See Username, Credential for user logins.';
COMMENT ON COLUMN Barcode.BarcodeID             IS 'The unique id is used to reference a specific barcode';
COMMENT ON COLUMN Barcode.Barcode               IS 'The decoded barcode content. Might be a number or any kind of (short) text encoded in a barcode';
COMMENT ON COLUMN Barcode.ProductID             IS 'The product that is linked to this barcode. Each barcode can only reference a single product.';
COMMENT ON COLUMN Barcode.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Barcode.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE SafetyStockAmountLevels (
  SafetyStockAmountID   BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  ModuleIdentifier      TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SafetyStockAmountLevels IS 'Define a stock amount level at which can be assigned to a product and given an amount to trigger an action at the definad stock amount. It is more or less just a name, like "Storage empty" or "Storage full"';
COMMENT ON COLUMN SafetyStockAmountLevels.SafetyStockAmountID   IS 'The unique id is used to reference a specific stock amount';
COMMENT ON COLUMN SafetyStockAmountLevels.Name                  IS 'The unique name of the stock amount level';
COMMENT ON COLUMN SafetyStockAmountLevels.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN SafetyStockAmountLevels.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE ProductSafetyStockAmounts (
  ProductID               BIGINT                   NOT NULL REFERENCES Product(ProductID),
  SafetyStockAmountID     BIGINT                   NOT NULL REFERENCES SafetyStockAmountLevels(SafetyStockAmountID),
  Amount                  BIGINT                   NOT NULL,
  EnableNotification      BOOLEAN                  NOT NULL DEFAULT(TRUE),
  IsNotified              BOOLEAN                  NOT NULL DEFAULT(FALSE),
  NotifyOnUnderflow       BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT ProductSafetyStockAmounts_PrimaryKey PRIMARY KEY(ProductID, SafetyStockAmountID)
);
COMMENT ON TABLE  ProductSafetyStockAmounts IS 'Define a SafetyStockAmountLevel for a product. That is, relate a stock amount with a product at an amount.';
COMMENT ON COLUMN ProductSafetyStockAmounts.ProductID             IS 'The product for which the stock amount is defined';
COMMENT ON COLUMN ProductSafetyStockAmounts.SafetyStockAmountID   IS 'The safety stock amount level ';
COMMENT ON COLUMN ProductSafetyStockAmounts.Amount                IS 'The product amount at which the stock level is related to the product';
COMMENT ON COLUMN ProductSafetyStockAmounts.EnableNotification    IS 'Enable notifications for this entry. If set to FALSE, the entry is informational and can be displayed. If TRUE, additional e-mail or instant-messaging notifications may be sent.';
COMMENT ON COLUMN ProductSafetyStockAmounts.IsNotified            IS 'Stores if the enabled notification has already been sent if the notification condition remains true, to prevent excessive spam due to a large amount of notifications triggering again and again';
COMMENT ON COLUMN ProductSafetyStockAmounts.NotifyOnUnderflow     IS 'If TRUE, send a notification if the product amount is below the stored amount (useful for normal products). If FALSE, send a notification if the product amount is above the amount (useful for normally redempted products).';
COMMENT ON COLUMN ProductSafetyStockAmounts.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ProductSafetyStockAmounts.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT ProductSafetyStockAmounts_PrimaryKey ON ProductSafetyStockAmounts IS 'The n×m relation is defined between Product and SafetyStockAmountLevels, so both PKs together form this relation PK';


CREATE TABLE ProductTagAssignment (
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  TagID                 BIGINT                   NOT NULL REFERENCES AvailableProductTags(TagID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT ProductTagAssignment_PrimaryKey PRIMARY KEY(ProductID, TagID)
);
COMMENT ON TABLE  ProductTagAssignment IS 'Assign product tags to products. Both tag and product are referenced by their numerical primary key.';
COMMENT ON COLUMN ProductTagAssignment.ProductID             IS 'The product';
COMMENT ON COLUMN ProductTagAssignment.TagID                 IS 'The product tag that is assigned to the product';
COMMENT ON COLUMN ProductTagAssignment.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ProductTagAssignment.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT ProductTagAssignment_PrimaryKey ON ProductTagAssignment IS 'Define both foreign keys as a composite PK to prevent duplicate assignments, as there are additional columns in the table definition';


CREATE TABLE StorageContent (
  StorageID             BIGINT                   NOT NULL REFERENCES Storage(StorageID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  Amount                BIGINT                   NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT StorageContent_PrimaryKey PRIMARY KEY( StorageID, ProductID )
);
COMMENT ON TABLE  StorageContent IS 'StorageContent defines the stored amount of each product in a storage';
COMMENT ON COLUMN StorageContent.StorageID             IS 'The storage';
COMMENT ON COLUMN StorageContent.ProductID             IS 'The referenced product';
COMMENT ON COLUMN StorageContent.Amount                IS 'The product amount stored in the storage. Should always be positive. A negative number is allowed but means an inconsistency occured like a double sold or unlogged product.';
COMMENT ON COLUMN StorageContent.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN StorageContent.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT StorageContent_PrimaryKey ON StorageContent IS 'The n×m relation is defined between Storage and Product, so both PKs together form this relation PK';


CREATE TABLE StorageLog (
  StorageLogID          BIGSERIAL                NOT NULL PRIMARY KEY,
  FromStorage           BIGINT                       NULL REFERENCES Storage(StorageID),
  ToStorage             BIGINT                       NULL REFERENCES Storage(StorageID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  Amount                BIGINT                   NOT NULL,
  TransferTimestamp     TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT OneStorageMustExist CHECK( FromStorage IS NOT NULL OR ToStorage IS NOT NULL )
);
COMMENT ON TABLE  StorageLog IS 'StorageLog is a logged product shift from one storage to another. If FromStorage is NULL, a newly purchased product is put into a storage. If ToStorage is NULL, a product is given out of the system, because it was sold or stolen.';
COMMENT ON COLUMN StorageLog.FromStorage           IS 'The storage where the product is taken from, If NULL, the product is newly put into a storage.';
COMMENT ON COLUMN StorageLog.ToStorage             IS 'The storage where the product is put into. If NULL, the product is completely removed from the system.';
COMMENT ON COLUMN StorageLog.ProductID             IS 'The shifted/added/removed product';
COMMENT ON COLUMN StorageLog.Amount                IS 'The shifted/added/removed product amount';
COMMENT ON COLUMN StorageLog.TransferTimestamp     IS 'The shift/transfer timestamp.';
COMMENT ON COLUMN StorageLog.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN StorageLog.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT OneStorageMustExist ON StorageLog IS 'At least one storage must exist. Both storages beeing NULL is invalid, as this has no useful semantics.';


CREATE TABLE Retailer (
  RetailerID            BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL,
  AdressCountry         TEXT                         NULL,
  AdressZipCode         TEXT                         NULL,
  AdressCity            TEXT                         NULL,
  AdressStreet          TEXT                         NULL,
  AdressStreetNumber    TEXT                         NULL,
  CustomerNumber        TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Retailer IS 'Products can be ordered or purchased at retailers.';
COMMENT ON COLUMN Retailer.RetailerID            IS 'The unique id is used to reference a specific retailer.';
COMMENT ON COLUMN Retailer.Name                  IS 'The retailer name is the only required attribute for a retailer, as the rest may not be known or existant.';
COMMENT ON COLUMN Retailer.AdressCountry         IS 'Retailer adress: Country';
COMMENT ON COLUMN Retailer.AdressZipCode         IS 'Retailer adress: Zip/postal code';
COMMENT ON COLUMN Retailer.AdressCity            IS 'Retailer adress: City';
COMMENT ON COLUMN Retailer.AdressStreet          IS 'Retailer adress: Street name';
COMMENT ON COLUMN Retailer.AdressStreetNumber    IS 'Retailer adress: Street number. May be any text like ''4A''';
COMMENT ON COLUMN Retailer.CustomerNumber        IS 'A customer number registered at the retailer.';
COMMENT ON COLUMN Retailer.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Retailer.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE RetailerContactPerson (
  ContactPersonID       BIGSERIAL                NOT NULL PRIMARY KEY,
  FirstName             TEXT                         NULL,
  LastName              TEXT                     NOT NULL,
  EMail                 TEXT                         NULL,
  Telephone             TEXT                         NULL,
  Fax                   TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  RetailerContactPerson IS 'Some retailers assign a contact person to a customer to aid the purchase process.';
COMMENT ON COLUMN RetailerContactPerson.ContactPersonID       IS 'The unique id is used to reference a specific contact person';
COMMENT ON COLUMN RetailerContactPerson.FirstName             IS 'The contact person’s first name might not be known';
COMMENT ON COLUMN RetailerContactPerson.LastName              IS 'The last name is required.';
COMMENT ON COLUMN RetailerContactPerson.EMail                 IS 'There might be an e-mail adress known used for e-mail conversations';
COMMENT ON COLUMN RetailerContactPerson.Telephone             IS 'The contact person might be reachable by telephone';
COMMENT ON COLUMN RetailerContactPerson.Fax                   IS 'The contact person might be reachable by fax';
COMMENT ON COLUMN RetailerContactPerson.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN RetailerContactPerson.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE ContactPersonFor (
  RetailerID            BIGINT                   NOT NULL REFERENCES Retailer(RetailerID),
  ContactPersonID       BIGINT                   NOT NULL REFERENCES RetailerContactPerson(ContactPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY(RetailerID, ContactPersonID)
);
COMMENT ON TABLE  ContactPersonFor IS 'ContactPersonFor models the work relation between a retailer and a contact person.';
COMMENT ON COLUMN ContactPersonFor.RetailerID            IS 'The workplace of the contact person.';
COMMENT ON COLUMN ContactPersonFor.ContactPersonID       IS 'The contact person.';
COMMENT ON COLUMN ContactPersonFor.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ContactPersonFor.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Person (
  PersonID              BIGSERIAL                NOT NULL PRIMARY KEY,
  FirstName             TEXT                     NOT NULL,
  LastName              TEXT                     NOT NULL,
  EMail                 TEXT                     NOT NULL UNIQUE,
  CreationDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Person IS 'A person that can be granted access to the system. See RetailerContactPerson for contact persons working at a retailer.';
COMMENT ON COLUMN Person.FirstName             IS 'The person’s first name';
COMMENT ON COLUMN Person.LastName              IS 'The person’s last name';
COMMENT ON COLUMN Person.EMail                 IS 'The e-mail must be unique to reset login credentials or uniquely identify a person';
COMMENT ON COLUMN Person.CreationDate          IS 'The creation date for the person';
COMMENT ON COLUMN Person.Active                IS 'Can be used to completely deactivate an account';
COMMENT ON COLUMN Person.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Person.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Customer (
  CustomerID            BIGINT                   NOT NULL PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);



CREATE TABLE SalesPerson (
  SalesPersonID         BIGINT                   NOT NULL PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);



CREATE TABLE PersonRoleAssignment (
  RoleID                BIGINT  NOT NULL REFERENCES AvailableRoles(RoleID),
  SalesPersonID         BIGINT  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(RoleID, SalesPersonID)
);



CREATE TABLE PurchaseHeader (
  PurchaseID            BIGSERIAL                NOT NULL PRIMARY KEY,
  OrderDate             DATE                     NOT NULL DEFAULT(CURRENT_DATE),
  InvoiceNumber         TEXT                         NULL,
  InvoiceCopy           BYTEA                        NULL,
  InvoiceIsPreTax       BOOLEAN                  NOT NULL,
  RetailerID            BIGINT                   NOT NULL REFERENCES Retailer(RetailerID),
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP) ,
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  PurchaseHeader IS 'PurchaseHeader is a cart at a retailer. Its elements are stored in PurchaseDetail.';
COMMENT ON COLUMN PurchaseHeader.PurchaseID            IS 'The unique id is used to reference a specific purchase';
COMMENT ON COLUMN PurchaseHeader.OrderDate             IS 'The order or purchase date. It is a still open order, if there are no product instances in the database for this purchase';
COMMENT ON COLUMN PurchaseHeader.InvoiceNumber         IS 'An optional invoice number. One is available, if products are oredered';
COMMENT ON COLUMN PurchaseHeader.InvoiceCopy           IS 'An optional copy of the invoice. Can be a scanned picture of the invoice for reference purposes.';
COMMENT ON COLUMN PurchaseHeader.InvoiceIsPreTax       IS 'Defines if the price on the associated purchase details already contains the taxes';
COMMENT ON COLUMN PurchaseHeader.RetailerID            IS 'The retailer where the order / purchase was done';
COMMENT ON COLUMN PurchaseHeader.SalesPersonID         IS 'Each order / purchase is done by a staff member';
COMMENT ON COLUMN PurchaseHeader.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN PurchaseHeader.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE PurchaseDetail (
  PurchaseDetailID      BIGSERIAL                NOT NULL PRIMARY KEY,
  PurchaseID            BIGINT                   NOT NULL REFERENCES PurchaseHeader(PurchaseID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  OrderAmount           BIGINT                   NOT NULL,
  IsShipped             BOOLEAN                  NOT NULL,
  PurchaseAmount        BIGINT                       NULL,
  PrimeCostPerUnit      DECIMAL(10, 2)           NOT NULL,
  TaxCategoryID         BIGINT                   NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  BestBeforeDate        DATE                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT PurchaseAmountSetIfShipped CHECK(IsShipped IS FALSE OR PurchaseAmount IS NOT NULL) -- IsShipped = TRUE implies PurchaseAmount IS NOT NULL
);
COMMENT ON TABLE  PurchaseDetail IS 'A purchase consists of several purchased products. Each oredered / purchased product has an entry in this table.';
COMMENT ON COLUMN PurchaseDetail.PurchaseDetailID      IS 'The unique id is used to reference a specific purchase detail';
COMMENT ON COLUMN PurchaseDetail.PurchaseID            IS 'The detail belongs to a purchase cart';
COMMENT ON COLUMN PurchaseDetail.ProductID             IS 'The ordered / purchased product';
COMMENT ON COLUMN PurchaseDetail.OrderAmount           IS 'The ordered product amount.';
COMMENT ON COLUMN PurchaseDetail.IsShipped             IS 'If TRUE, the ordered product is shipped and the purchase amount must be set. ';
COMMENT ON COLUMN PurchaseDetail.PurchaseAmount        IS 'The oredered / purchased product amount.';
COMMENT ON COLUMN PurchaseDetail.BestBeforeDate        IS 'Optional best before date.';
COMMENT ON COLUMN PurchaseDetail.PrimeCostPerUnit      IS 'The paid price per single product';
COMMENT ON COLUMN PurchaseDetail.TaxCategoryID         IS 'The tax category for this specific product purchase. It might be different from the default stored in Product';
COMMENT ON COLUMN PurchaseDetail.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN PurchaseDetail.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT PurchaseAmountSetIfShipped ON PurchaseDetail IS 'The PurchaseAmount is NULL, if the product is not yet shipped. It must be set, if the product is shipped.a';


CREATE TABLE SaleHeader (
  SaleID                BIGSERIAL                NOT NULL PRIMARY KEY,
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  CustomerID            BIGINT                   NOT NULL REFERENCES Customer(CustomerID),
  SalesDateTime         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SaleHeader IS 'SaleHeader is a sold customer cart. Its elements are stored in SaleDetail.';
COMMENT ON COLUMN SaleHeader.SaleID                IS 'The unique id is used to reference a specific sale cart.';
COMMENT ON COLUMN SaleHeader.SalesPersonID         IS 'The staff member that sold the products to the customer';
COMMENT ON COLUMN SaleHeader.CustomerID            IS 'The purchasing customer.';
COMMENT ON COLUMN SaleHeader.SalesDateTime         IS 'The timestamp at which the cart was sold.';
COMMENT ON COLUMN SaleHeader.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN SaleHeader.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE SaleDetail (
  SaleDetailID          BIGSERIAL                NOT NULL PRIMARY KEY,
  SaleID                BIGINT                   NOT NULL REFERENCES SaleHeader(SaleID),
  ProductID             BIGINT                   NOT NULL REFERENCES Product(ProductID),
  UnitPrice             DECIMAL(10,4)            NOT NULL,
  UnitQuantity          BIGINT                   NOT NULL,
  IsRedemption          BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SaleDetail IS 'A sale consists of several sold products. Each sold product has an entry in this table.';
COMMENT ON COLUMN SaleDetail.SaleDetailID          IS 'The unique id is used to reference a specific sale detail.';
COMMENT ON COLUMN SaleDetail.SaleID                IS 'The detail belongs to a sale cart';
COMMENT ON COLUMN SaleDetail.ProductID             IS 'The sold product.';
COMMENT ON COLUMN SaleDetail.UnitPrice             IS 'The unit price at which the product is sold';
COMMENT ON COLUMN SaleDetail.UnitQuantity          IS 'The sold product amount';
COMMENT ON COLUMN SaleDetail.IsRedemption          IS 'If set to TRUE, the detail is a product redemption.';
COMMENT ON COLUMN SaleDetail.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN SaleDetail.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE ClientType (
  ClientTypeID          BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  ClientType IS 'ClientType defines a type of application that is connected to the backend. It may be something like a sale client, a storage management client, a customer web client or an admin client.
It can used to limit the scope of login credentials. It might be desireable to have credential-less logins for controlled clients, but not for the web interface, so each credential type can be limited to certain client types.';
COMMENT ON COLUMN ClientType.ClientTypeID          IS 'The unique id is used to reference a specific client type';
COMMENT ON COLUMN ClientType.Name                  IS 'The unique client type name. ';
COMMENT ON COLUMN ClientType.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN ClientType.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Client (
  ClientID              BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  ClientTypeID          BIGINT                   NOT NULL REFERENCES ClientType(ClientTypeID),
  ClientSecret          BYTEA                    NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);


CREATE TABLE AvailableCredentialTypes (
  CredentialTypeID      BIGSERIAL                NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  NeedsPassword         BOOLEAN                  NOT NULL,
  ModuleIdentifier      TEXT                         NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableCredentialTypes IS 'A credential secret blob might be of different types, like a hashed password or a X.509 certificate public key used for smartcard authentification';
COMMENT ON COLUMN AvailableCredentialTypes.CredentialTypeID      IS 'The unique id is used to reference a specific credential type.';
COMMENT ON COLUMN AvailableCredentialTypes.Name                  IS 'The unique name of this credential type. More or less informational purposes.';
COMMENT ON COLUMN AvailableCredentialTypes.NeedsPassword         IS 'If set to TRUE, all Credentials with this type need a password. If FALSE, dummy credentials without secret with this type are possible.';
COMMENT ON COLUMN AvailableCredentialTypes.ModuleIdentifier      IS 'A module that can be used for secrets of this type (LEGACY?)';
COMMENT ON COLUMN AvailableCredentialTypes.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN AvailableCredentialTypes.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE AllowedCredentialUse (
  CredentialTypeID      BIGINT                   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  ClientTypeID          BIGINT                   NOT NULL REFERENCES ClientType(ClientTypeID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY (CredentialTypeID, ClientTypeID)
);


CREATE TABLE Username (
  UsernameID            BIGSERIAL                NOT NULL PRIMARY KEY,
  Username              TEXT                     NOT NULL UNIQUE,
  PersonID              BIGINT                   NOT NULL REFERENCES Person(PersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
  
);
COMMENT ON TABLE  Username IS 'A username identifies a person for login purposes. Belongs to exactly one person.';
COMMENT ON COLUMN Username.UsernameID            IS 'The unique id is used to reference a specific username';
COMMENT ON COLUMN Username.Username              IS 'The unique username is used to login a user into the system.';
COMMENT ON COLUMN Username.PersonID              IS 'The person to which this username belongs.';
COMMENT ON COLUMN Username.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Username.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Credential (
  CredentialID          BIGSERIAL                NOT NULL PRIMARY KEY,
  CredentialSecret      BYTEA                        NULL,
  UsernameID            BIGINT                   NOT NULL REFERENCES Username(UsernameID),
  CredentialTypeID      BIGINT                   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  IsSalesPersonLogin    BOOLEAN                  NOT NULL,
  CredentialCreateDate  DATE                     NOT NULL,
  LastSecretChange      TIMESTAMP WITH TIME ZONE     NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Credential IS 'A credential is a secret login information blob used together with a username.';
COMMENT ON COLUMN Credential.CredentialID          IS 'The unique id is used to reference a specific credential.';
COMMENT ON COLUMN Credential.CredentialSecret      IS 'The secret blob type depends on the credential type, which is a hashed password or a public key. It is not unique, so multiple users can have the same credential without knowing this fact.';
COMMENT ON COLUMN Credential.UsernameID            IS 'The username to which this credential belongs';
COMMENT ON COLUMN Credential.CredentialTypeID      IS 'The credential type defines the type of the credential blob.';
COMMENT ON COLUMN Credential.IsSalesPersonLogin    IS 'Defines if this credential is used for a customer or staff login.';
COMMENT ON COLUMN Credential.CredentialCreateDate  IS 'The creation date for this credential.';
COMMENT ON COLUMN Credential.LastSecretChange      IS 'The last password change timestamp. May be used to enforce password changes after a given time period elapsed.';
COMMENT ON COLUMN Credential.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Credential.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE CredentialUse (
  ClientTypeID          BIGINT                   NOT NULL REFERENCES ClientType(ClientTypeID),
  CredentialID          BIGINT                   NOT NULL REFERENCES Credential(CredentialID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY (CredentialID, ClientTypeID)
);
COMMENT ON TABLE  CredentialUse IS 'Defines which credential can be used at which client type.';



CREATE TABLE Charge (
  ChargeID              BIGSERIAL                NOT NULL PRIMARY KEY,
  CustomerID            BIGINT                   NOT NULL REFERENCES Customer(CustomerID),
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  Donation              BOOLEAN                  NOT NULL DEFAULT(FALSE),
  ChargeAmount          DECIMAL(10,2)            NOT NULL,
  ChargeDate            TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Charge IS 'Charge saves the customer balance recharges. If a customer credits his account by giving money to a staff member, an entry is created in this table.';
COMMENT ON COLUMN Charge.ChargeID              IS 'The unique id is used to reference a specific charge.';
COMMENT ON COLUMN Charge.CustomerID            IS 'The customer who credits his account.';
COMMENT ON COLUMN Charge.SalesPersonID         IS 'The staff member who receives the money. This debits the staff members account.';
COMMENT ON COLUMN Charge.Donation              IS 'A customer may donate money instead of crediting his account. If set to TRUE, the customer does not credit his account, but the staff member still debits his account.';
COMMENT ON COLUMN Charge.ChargeAmount          IS 'The received amount of money';
COMMENT ON COLUMN Charge.ChargeDate            IS 'The exact charge timestamp';
COMMENT ON COLUMN Charge.EntryAddedDate        IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Charge.EntryLastModifiedDate IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';


CREATE TABLE Repayment (
  RepaymentID             BIGSERIAL                NOT NULL PRIMARY KEY,
  SalesPersonID           BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  TransactionDate         DATE                     NOT NULL,
  Amount                  DECIMAL(10, 2)           NOT NULL,
  RequiredAmountRedeemers BIGINT                   NOT NULL DEFAULT(1),
  EntryAddedDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT PositiveRequiredAmountRedeemers CHECK(RequiredAmountRedeemers >= 0)
);
COMMENT ON TABLE  Repayment IS 'The recharge of money on a customer account debits the staff members account. The repayment balances the staff members account.';
COMMENT ON COLUMN Repayment.RepaymentID             IS 'The unique id is used to reference a specific repayment';
COMMENT ON COLUMN Repayment.SalesPersonID           IS 'The staff member who repaid money';
COMMENT ON COLUMN Repayment.TransactionDate         IS 'The transaction date.';
COMMENT ON COLUMN Repayment.Amount                  IS 'The paid amount of money';
COMMENT ON COLUMN Repayment.RequiredAmountRedeemers IS 'Required amount of acknowledgements by financial officers to mark this repayment as done.';
COMMENT ON COLUMN Repayment.EntryAddedDate          IS 'Timestamp at which the database entry was created. Read only';
COMMENT ON COLUMN Repayment.EntryLastModifiedDate   IS 'Timestamp at which the database entry was modified last. If equal to EntryAddedDate, then no modification was ever done. Automatically updated by a trigger';
COMMENT ON CONSTRAINT PositiveRequiredAmountRedeemers ON Repayment IS 'The required amount of acknowledgements must not be negative.';


CREATE TABLE RedeemerFor (
  SalesPersonID         BIGINT                   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  RepaymentID           BIGINT                   NOT NULL REFERENCES Repayment(RepaymentID),
  AcknowledgedDate      DATE                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(SalesPersonID, RepaymentID)
);
COMMENT ON TABLE RedeemerFor IS 'A repayment must be acknowledged by financial officers to be accepted. This table stores the acknowledgements.';


CREATE VIEW TaxCategory AS
  SELECT 
    n.TaxCategoryID,
    n.Name,
    '1337-01-01'::DATE AS ValidSince,
    n.BaseValue AS Value,
    n.BaseValueUnit AS Unit
  FROM TaxCategoryName AS n
  UNION ALL
  SELECT
    n.TaxCategoryID,
    n.Name,
    v.ValidSince,
    v.Value,
    v.Unit
  FROM TaxCategoryName AS n
  JOIN TaxCategoryValue AS v ON n.TaxCategoryID = v.TaxCategoryID
;
COMMENT ON VIEW TaxCategory IS 'TaxCategory joins TaxCategoryName and TaxCategoryValue.';


CREATE VIEW ProductTaxes AS
  SELECT
    p.ProductID,
    h.PurchaseID,
    d.PurchaseDetailID,
    p.Name AS ProductName,
    h.OrderDate AS ProductOrderDate,
    t.TaxCategoryID,
    t.ValidSince AS TaxCategoryValidSince,
    t.Name AS TaxCategoryName,
    t.Value AS TaxAmount,
    t.Unit AS TaxUnit
  FROM Product        AS p
  JOIN PurchaseDetail AS d ON p.ProductID     = d.ProductID
  JOIN PurchaseHeader AS h ON h.PurchaseID    = d.PurchaseID
    
  JOIN TaxCategory    AS t ON d.TaxCategoryID = t.TaxCategoryID
  WHERE t.ValidSince = (
    SELECT MAX(t2.ValidSince)
    FROM TaxCategory AS t2
    WHERE h.OrderDate >= t2.ValidSince
  )
;
COMMENT ON VIEW ProductTaxes IS 'Computes the exact taxes for each product purchase.';


CREATE VIEW CustomerCharges AS
  SELECT
    cu.CustomerID,
    cp.FirstName   AS CustomerFirstName,
    cp.LastName    AS CustomerLastName,
    sp.SalesPersonID,
    spp.FirstName  AS SalesPersonFirstName,
    spp.LastName   AS SalesPersonLastName,
    ch.ChargeID,
    ch.ChargeDate,
    ch.ChargeAmount,
    ch.Donation AS IsDonation
  FROM Person AS cp -- cp Customer Person
    JOIN Customer AS cu    ON cp.PersonID = cu.CustomerID
    JOIN Charge AS ch      ON cu.CustomerID = ch.CustomerID
    JOIN SalesPerson AS sp ON ch.SalesPersonID = sp.SalesPersonID
    JOIN Person AS spp     ON sp.SalesPersonID = spp.PersonID --spp SalesPerson Person
;
COMMENT ON VIEW CustomerCharges IS 'Computes an overview of all customer account charges.';


CREATE VIEW CustomerBalance AS
  SELECT
    cu.CustomerID,
    (cu.BaseBalance
      + COALESCE(CustChargeSum.Charge, 0) -- is NULL, if the customer has never charged his balance
      - COALESCE(CustSaleSum.SaleTotal, 0) -- is NULL, if the customer has never purchased or redempted any product
    ) AS Balance
  
  FROM Customer AS cu
  
  LEFT OUTER JOIN ( -- sum of all charges
    SELECT ch.CustomerID, SUM( ch.ChargeAmount) AS Charge
    FROM Charge AS ch
    WHERE ch.Donation IS FALSE
    GROUP BY ch.CustomerID
  ) AS CustChargeSum ON CustChargeSum.CustomerID = cu.CustomerID
  
  LEFT OUTER JOIN ( -- sum of all product sales and redemptions. The case structure inside the SUM aggregate replaces another left outer join for all redemptions
    SELECT sh.CustomerID,
    SUM( sd.UnitQuantity * 
      CASE
        WHEN sd.IsRedemption IS FALSE THEN sd.UnitPrice -- Sum up sales
        ELSE -sd.UnitPrice -- sd.IsRedemption IS TRUE, substract all redemptions
      END) AS SaleTotal
    FROM SaleHeader AS sh
    JOIN SaleDetail AS sd ON sh.SaleID = sd.SaleID
    GROUP BY sh.CustomerID
  ) AS CustSaleSum ON CustSaleSum.CustomerID = cu.CustomerID
;
COMMENT ON VIEW CustomerBalance IS 'Calculates the customer balance as a sum of all charges and product redemptions minus all product sales';


CREATE VIEW SalesPersonBalance AS
  SELECT
    sp.SalesPersonID,
    (sp.BaseBalance
      - COALESCE(SPChargeSum.Charge, 0) -- is NULL, if the staff member has never accepted any charges
      + COALESCE(SPRepaymentSum.RepaidAmount, 0) -- is NULL, if the staff member has no acknowledged repayments
    ) AS Balance,
    COALESCE(SPOpenRepaymentSum.OpenRepaymentAmount, 0) AS OpenRepaymentAmount -- is NULL, if the staff member has no open repayments
  
  FROM SalesPerson AS sp
  
  LEFT OUTER JOIN ( -- sum of all charges
    SELECT
      ch.SalesPersonID,
      SUM( ch.ChargeAmount ) AS Charge
    FROM Charge AS ch
    -- Do not filter out donations, as the stuff balance is charged for donations, too
    GROUP BY ch.SalesPersonID
  ) AS SPChargeSum ON SPChargeSum.SalesPersonID = sp.SalesPersonID
  
  LEFT OUTER JOIN ( -- sum of all completely redempted repayments
    SELECT
      rp.SalesPersonID,
      SUM( rp.Amount) AS RepaidAmount
    FROM Repayment AS rp
    WHERE rp.RequiredAmountRedeemers <= ( -- The number of acknowledges must be greater or equal to RequiredAmountRedeemers
      -- SELECT COUNT(*) is a safe aggregate function for subqueries,
      -- as it guarantees to always return exactly one value.
      SELECT COUNT(*) 
      FROM RedeemerFor AS rf
      WHERE rf.RepaymentID = rp.RepaymentID
    )
    GROUP BY rp.SalesPersonID
  ) AS SPRepaymentSum ON SPRepaymentSum.SalesPersonID = sp.SalesPersonID
  LEFT OUTER JOIN ( -- sum of still open repayments
    SELECT
      rp.SalesPersonID,
      SUM( rp.Amount) AS OpenRepaymentAmount
    FROM Repayment AS rp
    WHERE rp.RequiredAmountRedeemers > ( -- If the number of acknowledges is lesser than RequiredAmountRedeemers, the repayment is still open
      -- SELECT COUNT(*) is a safe aggregate function for subqueries,
      -- as it guarantees to always return exactly one value.
      SELECT COUNT(*) 
      FROM RedeemerFor AS rf
      WHERE rf.RepaymentID = rp.RepaymentID
    )
    GROUP BY rp.SalesPersonID
  ) AS SPOpenRepaymentSum ON SPOpenRepaymentSum.SalesPersonID = sp.SalesPersonID
  
;
COMMENT ON VIEW SalesPersonBalance IS 'Calculates the staff member balance as a sum of all charges and acknowleded repayments. It also supplies the sum of all still open repayments';


CREATE VIEW ProductsInStock AS
  SELECT
    p.ProductID,
    p.Name,
    p.Description,
    p.Price,
    p.TaxCategoryID,
    p.CategoryID,
    p.IsSaleAllowed,
    p.IsDefaultRedemption,
    COALESCE(InStock.InStockAmount, 0) AS InStockAmount
  FROM Product AS p
  LEFT OUTER JOIN (
    SELECT
      sc.ProductID,
      SUM(sc.Amount) AS InStockAmount
    FROM StorageContent AS sc
    GROUP BY sc.ProductID
  ) AS InStock ON p.ProductID = InStock.ProductID
;
COMMENT ON VIEW ProductsInStock IS 'Calculates the current product stock amounts for all products.';


COMMIT;