CREATE TABLE AvailableRoles (
  RoleID                SERIAL  PRIMARY KEY,
  Name                  TEXT    NOT NULL,
  Description           TEXT    NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE AvailableRights (
  RightID               SERIAL  PRIMARY KEY,
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
  StorageID             SERIAL  PRIMARY KEY,
  Name                  TEXT    NOT NULL,
  IsSaleAllowed         BOOLEAN NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SafetyStockAmountLevels (
  SafetyStockAmountID   SERIAL    PRIMARY KEY,
  Name                  TEXT      NOT NULL,
  ModuleIdentifier      TEXT      NULL,
  EntryAddedDate        TIMESTAMP NULL,
  EntryLastModifiedDate TIMESTAMP NULL
);
CREATE TABLE AvailableProductCategories (
  CategoryID            SERIAL    PRIMARY KEY,
  Name                  TEXT      NOT NULL,
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
  TagID                 SERIAL    PRIMARY KEY,
  Name                  TEXT      NOT NULL,
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
  TaxCategoryID         SERIAL        PRIMARY KEY,
  Name                  TEXT          NOT NULL,
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
  ProductID             SERIAL        PRIMARY KEY,
  Name                  TEXT          NOT NULL UNIQUE,
  Description           TEXT          NULL,
  Price                 DECIMAL(10,2) NOT NULL,
  TaxCategoryID         INTEGER       NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  CategoryID            INTEGER       NULL REFERENCES AvailableProductCategories(CategoryID),
  IsSaleProhibited      BOOLEAN       NOT NULL,
  IsDefaultRedemtion    BOOLEAN       NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE Barcode (
  BarcodeID             SERIAL    PRIMARY KEY,
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
  StorageID             INTEGER NOT NULL REFERENCES Storage(StorageID),
  ProductID             INTEGER NOT NULL REFERENCES Product(ProductID),
  Amount                INTEGER NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE StorageLog (
  StorageLogID          SERIAL  PRIMARY KEY,
  FromStorage           INTEGER NOT NULL REFERENCES Storage(StorageID),
  ToStorage             INTEGER NOT NULL REFERENCES Storage(StorageID),
  ProductID             INTEGER NOT NULL REFERENCES Product(ProductID),
  Amount                INTEGER NOT NULL,
  TransferTimeStamp     TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE Retailer (
  RetailerID            SERIAL    PRIMARY KEY,
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
  ContactPersonID       SERIAL    PRIMARY KEY,
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
CREATE TABLE ProductInstance (
  ProductInstanceID     SERIAL        PRIMARY KEY,
  ProductID             INTEGER       NOT NULL REFERENCES Product(ProductID),
  AddedDate             DATE          NOT NULL,
  InStockAmount         INTEGER       NOT NULL,
  BestBeforeDate        DATE          NULL,
  PriceOverride         DECIMAL(10,2) NULL,
  TaxCategoryID         INTEGER       NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE Person (
  PersonID              SERIAL    PRIMARY KEY,
  FirstName             TEXT      NOT NULL,
  LastName              TEXT      NOT NULL,
  EMail                 TEXT      UNIQUE NOT NULL,
  CreationDate          TIMESTAMP WITH TIME ZONE NOT NULL,
  Active                BOOLEAN   NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE Customer (
  CustomerID            INTEGER PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SalesPerson (
  SalesPersonID         INTEGER PRIMARY KEY REFERENCES Person(PersonID),
  BaseBalance           DECIMAL(10,2)            NOT NULL DEFAULT(0),
  BaseBalanceDate       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  AddedDate             TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  Active                BOOLEAN                  NOT NULL,
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
  PurchaseID            SERIAL    PRIMARY KEY,
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
  PurchaseDetailID      SERIAL         PRIMARY KEY,
  PurchaseID            INTEGER        NOT NULL REFERENCES PurchaseHeader(PurchaseID),
  ProductInstanceID     INTEGER        NOT NULL REFERENCES ProductInstance(ProductInstanceID),
  PrimeCostPerUnit      DECIMAL(10, 2) NOT NULL,
  PurchaseAmount        INTEGER        NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SalesHeader (
  SalesID               SERIAL    PRIMARY KEY,
  SalesPersonID         INTEGER   NOT NULL REFERENCES SalesPerson(SalesPersonID),
  CustomerID            INTEGER   NOT NULL REFERENCES Customer(CustomerID),
  SalesDateTime         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE SalesDetail (
  SalesDetailID         SERIAL        PRIMARY KEY,
  SalesID               INTEGER       NOT NULL REFERENCES SalesPerson(SalesPersonID),
  ProductInstanceID     INTEGER       NOT NULL REFERENCES Customer(CustomerID),
  UnitPrice             DECIMAL(10,4) NOT NULL,
  UnitQuantity          INTEGER       NOT NULL,
  IsRedemption          BOOLEAN       NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
CREATE TABLE ClientType (
  ClientTypeID          SERIAL    PRIMARY KEY,
  Name                  TEXT      NOT NULL UNIQUE,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  ClientType IS 'Modelliert Zugriffe über verschiedene Systeme und Logins: HTTP-Admin-Schnittstelle, HTTP-Kunden-Schnittstelle, Kunden-App,Lager-App, User-Terminal, User-Login gesicherter Client, etc.';
COMMENT ON COLUMN ClientType.ClientTypeID IS 'Eine eindeutige Identifikationsnummer';
COMMENT ON COLUMN ClientType.Name IS 'Eine Stringbezeichnung, die benutzt werden kann, um nicht mit der ID arbeiten zu müssen';
COMMENT ON COLUMN ClientType.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Durch einen Trigger vor Veränderungen geschützt.';
COMMENT ON COLUMN ClientType.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE AvailableCredentialTypes (
  CredentialTypeID      SERIAL    PRIMARY KEY,
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
CREATE TABLE Credentials (
  CredentialID          SERIAL    PRIMARY KEY,
  CredentialKey         TEXT      NOT NULL UNIQUE,
  CredentialSecret      BYTEA     NULL,
  PersonID              INTEGER   NOT NULL REFERENCES Person(PersonID),
  CredentialTypeID      INTEGER   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  IsSalesPersonLogin    BOOLEAN   NOT NULL,
  CredentialCreateDate  DATE      NOT NULL,
  LastSecretChange      TIMESTAMP WITH TIME ZONE     NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE Credentials IS 'Credentials sind abstrakte Kombinationen aus einem Nutzernamen und einem Geheimnis, welche die Anmeldung an einer Schnittstelle erlauben.';
COMMENT ON COLUMN Credentials.CredentialID IS 'Eine Eindeutige Identifikationsnummer';
COMMENT ON COLUMN Credentials.CredentialKey IS 'Der Schlüssel entspricht in etwa einem Benutzernamen';
COMMENT ON COLUMN Credentials.CredentialSecret IS 'Das Geheimnis, welches der Nutzer zum Login mit dem Credential benötigt. Format hängt vom CredentialType ab';
COMMENT ON COLUMN Credentials.PersonID IS 'Die Person, zu der der Login gehört';
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
  ChargeID              SERIAL        PRIMARY KEY,
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
  RepaymentID           SERIAL         PRIMARY KEY,
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


