CREATE TABLE AvailableRoles (
  RoleID                SERIAL  NOT NULL PRIMARY KEY,
  Name                  TEXT    NOT NULL,
  Description           TEXT    NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE AvailableRights (
  RightID               SERIAL  NOT NULL PRIMARY KEY,
  Name                  TEXT    NOT NULL,
  Description           TEXT    NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE RoleRightAssignment (
  RoleID                INTEGER NOT NULL REFERENCES AvailableRoles(RoleID),
  RightID               INTEGER NOT NULL REFERENCES AvailableRights(RightID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(RoleID, RightID)
);
CREATE TABLE Storage (
  StorageID             SERIAL                   NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  IsSaleAllowed         BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON Storage IS 'Storage modelliert ein Warenlager. Ein solches Lager hat einen eindeutigen Namen und eine optionale Beschreibung.';
COMMENT ON Storage.StorageID             IS 'Eine eindeutige LagerID';
COMMENT ON Storage.Name                  IS 'Die eindeutige Bezeichnung für das Lager';
COMMENT ON Storage.Description           IS 'Eine optionale Textbeschreibung für das Lager';
COMMENT ON Storage.IsSaleAllowed         IS 'Gibt an, ob der Verkauf von Waren aus dem Lager erlaubt ist';
COMMENT ON Storage.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON Storage.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE SafetyStockAmountLevels (
  SafetyStockAmountID   SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL UNIQUE,
  ModuleIdentifier      TEXT      NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE AvailableProductCategories (
  CategoryID            SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL UNIQUE,
  Description           TEXT      NULL,
  CategoryIconURI       TEXT      NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP) ,
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE AvailableProductCategories IS 'Listet die verfügbaren Produktkategorien auf. Eine Produktkategorie hat einen Namen und eine optionale Textbeschreibung.';
COMMENT ON COLUMN AvailableProductCategories.CategoryID            IS 'Eindeutige Nummer zur Identifizierung der Produktkategorie';
COMMENT ON COLUMN AvailableProductCategories.Name                  IS 'Der Name der Produktkategorie';
COMMENT ON COLUMN AvailableProductCategories.Description           IS 'Eine optionale Textbeschreibung';
COMMENT ON COLUMN AvailableProductCategories.CategoryIconURI       IS 'Eine URI/URL zu einem Icon. Die GUI kann die URI benutzen, um ein zur Kategorie passendes Icon anzuzeigen';
COMMENT ON COLUMN AvailableProductCategories.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde.';
COMMENT ON COLUMN AvailableProductCategories.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch ausgefüllt.';
CREATE TABLE AvailableProductTags (
  TagID                 SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL UNIQUE,
  Description           TEXT      NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP) ,
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  AvailableProductTags IS 'Listet die verfügbaren Produkttags auf. Ein Produkttag hat einen Namen und eine optionale Textbeschreibung.';
COMMENT ON COLUMN AvailableProductTags.TagID                 IS 'Eindeutige Nummer zur Identifizierung des Tags';
COMMENT ON COLUMN AvailableProductTags.Name                  IS 'Der Name des Tags';
COMMENT ON COLUMN AvailableProductTags.Description           IS 'Eine optionale Textbeschreibung';
COMMENT ON COLUMN AvailableProductTags.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde.';
COMMENT ON COLUMN AvailableProductTags.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch ausgefüllt.';
CREATE TABLE TaxCategoryName (
  TaxCategoryID         SERIAL        NOT NULL PRIMARY KEY,
  Name                  TEXT          NOT NULL UNIQUE,
  BaseValue             DECIMAL(10,4) NOT NULL,
  BaseValueUnit         TEXT          NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
-- Standardsteuersätze anlegen: Standard, Reduziert und Steuerbefreit
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (1, 'Standard', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (2, 'Lebensmittel', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (3, 'Steuerbefreit', 0, '%');
CREATE TABLE TaxCategoryValue (
  TaxCategoryID         INTEGER       NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  ValidSince            DATE          NOT NULL,
  Value                 DECIMAL(10,4) NOT NULL,
  Unit                  TEXT          NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY(TaxCategoryID, ValidSince)
);
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
CREATE TABLE Product (
  ProductID             SERIAL        NOT NULL PRIMARY KEY,
  Name                  TEXT          NOT NULL UNIQUE,
  Description           TEXT          NULL,
  Price                 DECIMAL(10,2) NOT NULL,
  TaxCategoryID         INTEGER       NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  CategoryID            INTEGER       NULL REFERENCES AvailableProductCategories(CategoryID),
  IsSaleAllowed         BOOLEAN       NOT NULL,
  IsDefaultRedemption   BOOLEAN       NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE Barcode (
  BarcodeID             SERIAL    NOT NULL PRIMARY KEY,
  Barcode               TEXT      NOT NULL UNIQUE,
  ProductID             INTEGER   NOT NULL REFERENCES Product(ProductID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE Barcode IS 'Die Tabelle beinhaltet alle im Verkauf verwendeten Produktbarcodes. Kundenlogins via Barcode werden nicht von dieser Tabelle erfasst.';
COMMENT ON COLUMN Barcode.Barcode IS 'Der dekodierte Barcode-Inhalt. Wird nur für Produkte verwendet.';
COMMENT ON COLUMN Barcode.ProductID IS 'Das mit dem Barcode verknüpfte Produkt';
COMMENT ON COLUMN Barcode.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN Barcode.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE ProductSafetyStockAmounts (
  ProductID             INTEGER   NOT NULL REFERENCES Product(ProductID),
  SafetyStockAmountID   INTEGER   NOT NULL REFERENCES SafetyStockAmountLevels(SafetyStockAmountID),
  Amount                INTEGER   NOT NULL,
  IsNotified            BOOLEAN   NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY(ProductID, SafetyStockAmountID)
);
CREATE TABLE ProductTagAssignment (
  ProductID             INTEGER NOT NULL REFERENCES Product(ProductID),
  TagID                 INTEGER NOT NULL REFERENCES AvailableProductTags(TagID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE StorageContent (
  StorageID             INTEGER                  NOT NULL REFERENCES Storage(StorageID),
  ProductID             INTEGER                  NOT NULL REFERENCES Product(ProductID),
  Amount                INTEGER                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY( StorageID, ProductID )
);
COMMENT ON StorageContent IS 'Speichert die Produktverteilung von Produkten auf die vorhandenen Lager an';
COMMENT ON StorageContent.StorageID             IS 'Das referenzierte Lager';
COMMENT ON StorageContent.ProductID             IS 'Das referenzierte Produkt';
COMMENT ON StorageContent.Amount                IS 'Die im Lager verfügbare Produktmenge. Sollte positiv sein. Eine negative Produktmenge deutet auf ein inkonsistentes Lager hin.';
COMMENT ON StorageContent.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON StorageContent.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE StorageLog (
  StorageLogID          SERIAL                   NOT NULL PRIMARY KEY,
  FromStorage           INTEGER                      NULL REFERENCES Storage(StorageID),
  ToStorage             INTEGER                      NULL REFERENCES Storage(StorageID),
  ProductID             INTEGER                  NOT NULL REFERENCES Product(ProductID),
  Amount                INTEGER                  NOT NULL,
  TransferTimestamp     TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT OneStorageMustExist CHECK( FromStorage IS NOT NULL OR ToStorage IS NOT NULL )
);
COMMENT ON StorageLog IS 'Modelliert einen Lagergang. Ein Eintrag ist eine Warenverschiebung von einem Lager in ein anderes. Ist FromStorage NULL, wird ein neu gekauftes Produkt eingelagert. Ist ToStorage NULL, wird ein gekauftes Produkt verkauft oder ein verschwundenes Produkt während einer Inventur entfernt.';
COMMENT ON StorageLog.FromStorage           IS 'Das Lager, aus dem das Produkt entnommen wird. Ist es NULL, wird ein neues Produkt eingelagert.';
COMMENT ON StorageLog.ToStorage             IS 'Das Lager, in dem das Produkt eingelagert wird. Ist es NULL, wird ein Produkt endgültig entnommen.';
COMMENT ON StorageLog.ProductID             IS 'Das verschobene Produkt';
COMMENT ON StorageLog.Amount                IS 'Die Produktmenge, die verschoben wird';
COMMENT ON StorageLog.TransferTimestamp     IS 'Der Zeitpunkt, an dem das Produkt verschoben wird.';
COMMENT ON StorageLog.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON StorageLog.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
COMMENT ON CONSTRAINT OneStorageMustExist ON StorageLog IS 'Mindestens eins der Lager muss existieren. Beide Lager NULL ist ungültig.';
CREATE TABLE Retailer (
  RetailerID            SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL,
  AdressCountry         TEXT      NULL,
  AdressZipCode         TEXT      NULL,
  AdressCity            TEXT      NULL,
  AdressStreet          TEXT      NULL,
  AdressStreetNumber    TEXT      NULL,
  CustomerNumber        TEXT      NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE RetailerContactPerson (
  ContactPersonID       SERIAL    NOT NULL PRIMARY KEY,
  FirstName             TEXT      NULL,
  LastName              TEXT      NOT NULL,
  EMail                 TEXT      NULL,
  Telephone             TEXT      NULL,
  Fax                   TEXT      NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE ContactPersonFor (
  RetailerID            INTEGER   NOT NULL REFERENCES Retailer(RetailerID),
  ContactPersonID       INTEGER   NOT NULL REFERENCES RetailerContactPerson(ContactPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY(RetailerID, ContactPersonID)
);
COMMENT ON TABLE ContactPersonFor IS 'ContactPersonFor modelliert das Arbeitsverhältnis einer Kontaktperson und ihrem Arbeitgeber.';
COMMENT ON COLUMN ContactPersonFor.RetailerID IS 'Der Händler, für den die Kontaktperson arbeitet.';
COMMENT ON COLUMN ContactPersonFor.ContactPersonID IS 'Die Kontaktperson, die für den Händler arbeitet.';
COMMENT ON COLUMN ContactPersonFor.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN ContactPersonFor.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE Person (
  PersonID              SERIAL                   NOT NULL PRIMARY KEY,
  FirstName             TEXT                     NOT NULL,
  LastName              TEXT                     NOT NULL,
  EMail                 TEXT                     NOT NULL UNIQUE,
  CreationDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON Person IS 'Modelliert eine Person, die direkten Zugriff zum System benötigt. Händler-Kontaktpersonen werden nicht in dieser Tabelle abgelegt. Siehe dafür RetailerContactPerson';
COMMENT ON Person.FirstName             IS 'Der Vorname der Person';
COMMENT ON Person.LastName              IS 'Der Nachname der Person';
COMMENT ON Person.EMail                 IS 'Die E-Mail Adresse muss eindeutig sein und dient zur eindeutigen Identifikation und zur Zurücksetzung von Logins.';
COMMENT ON Person.CreationDate          IS 'Das Datum, an dem die Person angelegt wurde';
COMMENT ON Person.Active                IS 'Gibt an, ob die Person aktiv ist. Mit diesem Attribut kann die Handlungsfähigkeit einer Person deaktiviert werden';
COMMENT ON Person.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON Person.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE Customer (
  CustomerID            INTEGER                  NOT NULL PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SalesPerson (
  SalesPersonID         INTEGER                  NOT NULL PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL DEFAULT(TRUE),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE PersonRoleAssignment (
  RoleID                INTEGER NOT NULL REFERENCES AvailableRoles(RoleID),
  SalesPersonID         INTEGER NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(RoleID, SalesPersonID)
);
CREATE TABLE PurchaseHeader (
  PurchaseID            SERIAL    NOT NULL PRIMARY KEY,
  OrderDate             DATE      NOT NULL,
  InvoiceNumber         TEXT      NULL,
  InvoiceCopy           BYTEA     NULL,
  InvoiceIsPreTax       BOOLEAN   NOT NULL,
  RetailerID            INTEGER   NOT NULL REFERENCES Retailer(RetailerID),
  SalesPersonID         INTEGER   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP) ,
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE PurchaseDetail (
  PurchaseDetailID      SERIAL         NOT NULL PRIMARY KEY,
  PurchaseID            INTEGER        NOT NULL REFERENCES PurchaseHeader(PurchaseID),
  ProductID             INTEGER        NOT NULL REFERENCES Product(ProductID),
  PrimeCostPerUnit      DECIMAL(10, 2) NOT NULL,
  PurchaseAmount        INTEGER        NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE ProductInstance (
  ProductInstanceID     INTEGER       NOT NULL PRIMARY KEY REFERENCES PurchaseDetail(PurchaseDetailID),
  ProductID             INTEGER       NOT NULL REFERENCES Product(ProductID),
  AddedDate             DATE          NOT NULL,
  InStockAmount         INTEGER       NOT NULL,
  BestBeforeDate        DATE          NULL,
  PriceOverride         DECIMAL(10,2) NULL,
  TaxCategoryID         INTEGER       NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SaleHeader (
  SaleID                SERIAL    NOT NULL PRIMARY KEY,
  SalesPersonID         INTEGER   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  CustomerID            INTEGER   NOT NULL REFERENCES Customer(CustomerID),
  SalesDateTime         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SalesDetail (
  SalesDetailID         SERIAL        NOT NULL PRIMARY KEY,
  SaleID                INTEGER       NOT NULL REFERENCES SaleHeader(SaleID),
  ProductInstanceID     INTEGER       NOT NULL REFERENCES ProductInstance(ProductInstanceID),
  UnitPrice             DECIMAL(10,4) NOT NULL,
  UnitQuantity          INTEGER       NOT NULL,
  IsRedemption          BOOLEAN       NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE ClientType (
  ClientTypeID          SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL UNIQUE,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  ClientType IS 'Modelliert verschiedene Client-Typen, wie Verkaufsclient, Kunden-Webseite, Admin-Client etc.';
COMMENT ON COLUMN ClientType.ClientTypeID IS 'Eine eindeutige Identifikationsnummer';
COMMENT ON COLUMN ClientType.Name IS 'Eine Stringbezeichnung, die benutzt werden kann, um nicht mit der ID arbeiten zu müssen';
COMMENT ON COLUMN ClientType.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN ClientType.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE Client (
  ClientID              SERIAL  NOT NULL PRIMARY KEY,
  Name                  TEXT    NOT NULL,
  ClientTypeID          INTEGER NOT NULL REFERENCES ClientType(ClientTypeID)
  ClientSecret          BYTEA   NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE AvailableCredentialTypes (
  CredentialTypeID      SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL,
  NeedsPassword         BOOLEAN   NOT NULL,
  ModuleIdentifier      TEXT      NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE AvailableCredentialTypes IS NULL;
COMMENT ON COLUMN AvailableCredentialTypes.Name IS 'Der Name des Credentialtypen';
COMMENT ON COLUMN AvailableCredentialTypes.NeedsPassword IS 'Gibt an, ob der Credentialtyp zwingend ein gesetztes CredentialSecret vorraussetzt';
COMMENT ON COLUMN AvailableCredentialTypes.ModuleIdentifier IS 'Der Name des für den Typen zuständigen Programmmoduls';
COMMENT ON COLUMN AvailableCredentialTypes.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN AvailableCredentialTypes.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE AllowedCredentialUse (
  CredentialTypeID      INTEGER   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  ClientTypeID          INTEGER   NOT NULL REFERENCES ClientType(ClientTypeID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY (CredentialTypeID, ClientTypeID)
);
CREATE TABLE Username (
  UsernameID            SERIAL  NOT NULL PRIMARY KEY,
  Username              TEXT    NOT NULL UNIQUE,
  PersonID              INTEGER NOT NULL REFERENCES Person(PersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
  
);
CREATE TABLE Credentials (
  CredentialID          SERIAL    NOT NULL PRIMARY KEY,
  CredentialSecret      BYTEA     NULL,
  UsernameID            INTEGER   NOT NULL REFERENCES Username(UsernameID),
  CredentialTypeID      INTEGER   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  IsSalesPersonLogin    BOOLEAN   NOT NULL,
  CredentialCreateDate  DATE      NOT NULL,
  LastSecretChange      TIMESTAMP WITH TIME ZONE     NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE Credentials IS 'Credentials sind (geheime) Login-Informationen, welche die Anmeldung an Clients erlauben.';
COMMENT ON COLUMN Credentials.CredentialID IS 'Eine Eindeutige Identifikationsnummer';
COMMENT ON COLUMN Credentials.CredentialSecret IS 'Das Geheimnis, welches der Nutzer zum Login mit dem Credential benötigt. Format hängt vom CredentialType ab';
COMMENT ON COLUMN Credentials.UsernameID IS 'Referenziert über den Username die Person, zu der der Login gehört';
COMMENT ON COLUMN Credentials.CredentialTypeID IS 'Gibt den Typen des Credentials an.';
COMMENT ON COLUMN Credentials.IsSalesPersonLogin IS 'Gibt an, ob das Credential für einen Kunden- oder Mitarbeiterlogin verwendet wird.';
COMMENT ON COLUMN Credentials.CredentialCreateDate IS 'Das Datum, an dem der Login angelegt wurde.';
COMMENT ON COLUMN Credentials.LastSecretChange IS 'Das Datum, an dem das Geheimnis das letzte mal geändert wurde';
COMMENT ON COLUMN Credentials.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN Credentials.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE CredentialUse (
  ClientTypeID          INTEGER   NOT NULL REFERENCES ClientType(ClientTypeID),
  CredentialID          INTEGER   NOT NULL REFERENCES Credentials(CredentialID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY (CredentialID, ClientTypeID)
);
CREATE TABLE Charge (
  ChargeID              SERIAL        NOT NULL PRIMARY KEY,
  CustomerID            INTEGER       NOT NULL REFERENCES Customer(CustomerID),
  SalesPersonID         INTEGER       NOT NULL REFERENCES SalesPerson(SalesPersonID),
  Donation              BOOLEAN       NOT NULL,
  ChargeAmount          DECIMAL(10,2) NOT NULL,
  ChargeDate            TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE Charge IS 'Charge speichert die Guthabenaufladungen der Kunden. Wenn ein Kunde bei einem Verkäufer sein Kundenkonto auflädt, wird ein Eintrag für diese Aufladung in dieser Tabelle abgelegt.';
COMMENT ON COLUMN Charge.ChargeID IS 'Die eindeutige Identifikationsnummer der Guthabenaufladung';
COMMENT ON COLUMN Charge.CustomerID IS 'Der Kunde, dem das Geld auf sein Guthaben gutgeschrieben wird';
COMMENT ON COLUMN Charge.SalesPersonID IS 'Der Verkäufer, der die Guthabenaufladung durchführt und das Geld entgegennimmt.';
COMMENT ON COLUMN Charge.Donation IS 'Gibt an, ob es sich bei der Aufladung um eine Spende handelt. Bei einer Spende wird das Geld nicht auf dem Kundenkonto gutgeschrieben.';
COMMENT ON COLUMN Charge.ChargeAmount IS 'Der aufgeladene oder gespendete Geldbetrag';
COMMENT ON COLUMN Charge.ChargeDate IS 'Das Datum der Guthabenaufladung';
COMMENT ON COLUMN Charge.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN Charge.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE Repayment (
  RepaymentID           SERIAL         NOT NULL PRIMARY KEY,
  SalesPersonID         INTEGER        NOT NULL REFERENCES SalesPerson(SalesPersonID),
  TransactionDate       DATE           NOT NULL,
  Amount                DECIMAL(10, 2) NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE RedeemerFor (
  SalesPersonID         INTEGER   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  RepaymentID           INTEGER   NOT NULL REFERENCES Repayment(RepaymentID),
  AcknowledgedDate      DATE      NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY(SalesPersonID, RepaymentID)
);
CREATE VIEW TaxCategory AS
  SELECT n.TaxCategoryID, n.Name, '1337-01-01' AS ValidSince, n.BaseValue AS Value, n.BaseValueUnit AS Unit
  FROM TaxCategoryName AS n
  UNION ALL
  SELECT n.TaxCategoryID, n.Name, v.ValidSince, v.Value, v.Unit
  FROM TaxCategoryName  AS n
    JOIN TaxCategoryValue AS v ON n.TaxCategoryID = v.TaxCategoryID
;
CREATE VIEW ProductTaxes AS -- Berechnet die Steuerkategorie für jede Produktinstanz aus den verfügbaren Daten.
  SELECT p.ProductID, i.ProductInstanceID,
                     p.Name AS ProductName, i.AddedDate AS ProductAddedDate, i.InStockAmount,
    t.TaxCategoryID, t.ValidSince AS TaxCategoryValidSince, t.Name AS TaxCategoryName, t.Value AS TaxAmount, t.Unit AS TaxUnit
  FROM Product         AS p
    JOIN ProductInstance AS i ON p.ProductID     = i.ProductID
    JOIN TaxCategory     AS t ON i.TaxCategoryID = t.TaxCategoryID
  WHERE t.ValidSince = (
    SELECT MAX(t2.ValidSince)
    FROM TaxCategory AS t2
    WHERE i.AddedDate >= t2.ValidSince
  )
;
