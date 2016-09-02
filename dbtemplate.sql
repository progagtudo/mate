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
COMMENT ON TABLE  Storage IS 'Storage modelliert ein Warenlager. Ein solches Lager hat einen eindeutigen Namen und eine optionale Beschreibung.';
COMMENT ON COLUMN Storage.StorageID             IS 'Eine eindeutige LagerID';
COMMENT ON COLUMN Storage.Name                  IS 'Die eindeutige Bezeichnung für das Lager';
COMMENT ON COLUMN Storage.Description           IS 'Eine optionale Textbeschreibung für das Lager';
COMMENT ON COLUMN Storage.IsSaleAllowed         IS 'Gibt an, ob der Verkauf von Waren aus dem Lager erlaubt ist';
COMMENT ON COLUMN Storage.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Storage.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
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
COMMENT ON TABLE  AvailableProductCategories IS 'Listet die verfügbaren Produktkategorien auf. Eine Produktkategorie hat einen Namen und eine optionale Textbeschreibung.';
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
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
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
-- Dies sind keine Testdaten, sondern die realen Daten für Deutschland, die als Standardwerte in der Datenbank vordefiniert werden sollen.
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (1, 'Standard', 0, '%');
INSERT INTO TaxCategoryName (TaxCategoryID, Name, BaseValue, BaseValueUnit) VALUES (2, 'Reduziert', 0, '%');
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
  ProductID             SERIAL                   NOT NULL PRIMARY KEY,
  Name                  TEXT                     NOT NULL UNIQUE,
  Description           TEXT                         NULL,
  Price                 DECIMAL(10,2)            NOT NULL,
  TaxCategoryID         INTEGER                  NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  CategoryID            INTEGER                      NULL REFERENCES AvailableProductCategories(CategoryID),
  IsSaleAllowed         BOOLEAN                  NOT NULL,
  IsDefaultRedemption   BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Product IS 'Modelliert ein Produkt mit seinen allgemeinen Eigenschaften. Produkt wird auch in der Lagerverwaltung verwendet.';
COMMENT ON COLUMN Product.ProductID             IS 'Eindeutige Nummer zur Identifizierung eines Produktes';
COMMENT ON COLUMN Product.Name                  IS 'Eindeutiger Produktname. Ist UNIQUE, um nicht unterscheidbare Produkte mit gleichem Namen zu vermeiden.';
COMMENT ON COLUMN Product.Description           IS 'Eine optionale Textbeschreibung. Kann die Zutatenliste oder eine Produktbeschreibung enthalten.';
COMMENT ON COLUMN Product.Price                 IS 'Der Verkaufspreis des Produkts.';
COMMENT ON COLUMN Product.TaxCategoryID         IS 'Referenz auf die Steuerkategorie. Der genaue Steuersatz einer Produktinstanz ergibt sich aus der Kategorie und dem Einkaufsdatum.';
COMMENT ON COLUMN Product.IsSaleAllowed         IS 'Gibt an, ob das Produkt verkauft werden darf. Es ist möglich, dass ein Produkt aus administrativen Gründen nicht mehr verkauft werden darf.';
COMMENT ON COLUMN Product.IsDefaultRedemption   IS 'Gibt an, ob das Produkt normal verkauft oder zurückgegeben wird. Ein Rückgabeprodukt (Wert TRUE) ist z.B. Pfand.';
COMMENT ON COLUMN Product.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Product.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE Barcode (
  BarcodeID             SERIAL                   NOT NULL PRIMARY KEY,
  Barcode               TEXT                     NOT NULL UNIQUE,
  ProductID             INTEGER                  NOT NULL REFERENCES Product(ProductID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Barcode IS 'Die Tabelle beinhaltet alle im Verkauf verwendeten Produktbarcodes. Kundenlogins via Barcode werden nicht von dieser Tabelle erfasst.';
COMMENT ON COLUMN Barcode.Barcode               IS 'Der dekodierte Barcode-Inhalt. Wird nur für Produkte verwendet.';
COMMENT ON COLUMN Barcode.ProductID             IS 'Das mit dem Barcode verknüpfte Produkt';
COMMENT ON COLUMN Barcode.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
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
COMMENT ON TABLE  StorageContent IS 'Speichert die Produktverteilung von Produkten auf die vorhandenen Lager an';
COMMENT ON COLUMN StorageContent.StorageID             IS 'Das referenzierte Lager';
COMMENT ON COLUMN StorageContent.ProductID             IS 'Das referenzierte Produkt';
COMMENT ON COLUMN StorageContent.Amount                IS 'Die im Lager verfügbare Produktmenge. Sollte positiv sein. Eine negative Produktmenge deutet auf ein inkonsistentes Lager hin.';
COMMENT ON COLUMN StorageContent.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN StorageContent.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
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
COMMENT ON TABLE  StorageLog IS 'Modelliert einen Lagergang. Ein Eintrag ist eine Warenverschiebung von einem Lager in ein anderes. Ist FromStorage NULL, wird ein neu gekauftes Produkt eingelagert. Ist ToStorage NULL, wird ein gekauftes Produkt verkauft oder ein verschwundenes Produkt während einer Inventur entfernt.';
COMMENT ON COLUMN StorageLog.FromStorage           IS 'Das Lager, aus dem das Produkt entnommen wird. Ist es NULL, wird ein neues Produkt eingelagert.';
COMMENT ON COLUMN StorageLog.ToStorage             IS 'Das Lager, in dem das Produkt eingelagert wird. Ist es NULL, wird ein Produkt endgültig entnommen.';
COMMENT ON COLUMN StorageLog.ProductID             IS 'Das verschobene Produkt';
COMMENT ON COLUMN StorageLog.Amount                IS 'Die Produktmenge, die verschoben wird';
COMMENT ON COLUMN StorageLog.TransferTimestamp     IS 'Der Zeitpunkt, an dem das Produkt verschoben wird.';
COMMENT ON COLUMN StorageLog.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN StorageLog.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
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
COMMENT ON TABLE  ContactPersonFor IS 'ContactPersonFor modelliert das Arbeitsverhältnis einer Kontaktperson und ihrem Arbeitgeber.';
COMMENT ON COLUMN ContactPersonFor.RetailerID IS 'Der Händler, für den die Kontaktperson arbeitet.';
COMMENT ON COLUMN ContactPersonFor.ContactPersonID IS 'Die Kontaktperson, die für den Händler arbeitet.';
COMMENT ON COLUMN ContactPersonFor.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
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
COMMENT ON TABLE  Person IS 'Modelliert eine Person, die direkten Zugriff zum System benötigt. Händler-Kontaktpersonen werden nicht in dieser Tabelle abgelegt. Siehe dafür RetailerContactPerson';
COMMENT ON COLUMN Person.FirstName             IS 'Der Vorname der Person';
COMMENT ON COLUMN Person.LastName              IS 'Der Nachname der Person';
COMMENT ON COLUMN Person.EMail                 IS 'Die E-Mail Adresse muss eindeutig sein und dient zur eindeutigen Identifikation und zur Zurücksetzung von Logins.';
COMMENT ON COLUMN Person.CreationDate          IS 'Das Datum, an dem die Person angelegt wurde';
COMMENT ON COLUMN Person.Active                IS 'Gibt an, ob die Person aktiv ist. Mit diesem Attribut kann die Handlungsfähigkeit einer Person deaktiviert werden';
COMMENT ON COLUMN Person.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Person.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
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
  PurchaseID            SERIAL                   NOT NULL PRIMARY KEY,
  OrderDate             DATE                     NOT NULL,
  InvoiceNumber         TEXT                         NULL,
  InvoiceCopy           BYTEA                        NULL,
  InvoiceIsPreTax       BOOLEAN                  NOT NULL,
  RetailerID            INTEGER                  NOT NULL REFERENCES Retailer(RetailerID),
  SalesPersonID         INTEGER                  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP) ,
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  PurchaseHeader IS 'Speichert Wareneinkäufe eines Einkäufers bei einem Händler';
COMMENT ON COLUMN PurchaseHeader.PurchaseID            IS 'Eindeutige Identifikationsnummer des Einkaufs';
COMMENT ON COLUMN PurchaseHeader.OrderDate             IS 'Das Einkaufs- bzw. Bestelldatum. Eine Bestellung hat noch keine Produktinstanzen zu den Details in PurchaseDetail zugeordnet';
COMMENT ON COLUMN PurchaseHeader.InvoiceNumber         IS 'Eine optionale Rechnungsnummer.';
COMMENT ON COLUMN PurchaseHeader.InvoiceCopy           IS 'Eine optionale Rechnungskopie. Dieses Feld beinhaltet eine Digitalkopie der Rechnung oder des Kassenbons.';
COMMENT ON COLUMN PurchaseHeader.InvoiceIsPreTax       IS 'Gibt an, ob die Beträge auf der Rechnung (PurchaseDetail) die Steuern beinhalten oder nicht';
COMMENT ON COLUMN PurchaseHeader.RetailerID            IS 'Referenz auf den Händler, bei dem der Einkauf / die Bestellung getätigt wurde';
COMMENT ON COLUMN PurchaseHeader.SalesPersonID         IS 'Referenz auf den verantwortlichen Einkäufer';
COMMENT ON COLUMN PurchaseHeader.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN PurchaseHeader.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
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
  ProductInstanceID     INTEGER                  NOT NULL PRIMARY KEY REFERENCES PurchaseDetail(PurchaseDetailID),
  ProductID             INTEGER                  NOT NULL REFERENCES Product(ProductID),
  AddedDate             DATE                     NOT NULL,
  InStockAmount         INTEGER                  NOT NULL,
  BestBeforeDate        DATE                         NULL,
  PriceOverride         DECIMAL(10,2)                NULL,
  TaxCategoryID         INTEGER                  NOT NULL REFERENCES TaxCategoryName(TaxCategoryID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  ProductInstance IS 'Eine Produktinstanz ist ein reales Produkt, eingekauft bei einem Händler. Es hat einen Lagerbestand und Kaufdatum, eventuell Mindesthaltbarkeitsdatum.';
COMMENT ON COLUMN ProductInstance.ProductInstanceID     IS 'Eindeutiger Identifikator, wird durch das PurchaseDetail bestimmt und in Verkäufen (SaleDetail) verwendet.';
COMMENT ON COLUMN ProductInstance.ProductID             IS 'Die Produktinstanz ist eine Instanz des referenzierten Produktes und teilt alle Eigenschaften des Produkts';
COMMENT ON COLUMN ProductInstance.AddedDate             IS 'Das Einlagerdatum des Produkts. Wird auf das Datum des Produkteinkaufs oder der Lieferung gesetzt.';
COMMENT ON COLUMN ProductInstance.InStockAmount         IS 'Die Menge der Produktinstanz, die noch im Lager verfügbar ist.';
COMMENT ON COLUMN ProductInstance.BestBeforeDate        IS 'Ein optionales Mindesthaltbarkeitsdatum. Kann bei verderblichen Waren gesetzt werden, um bei Ablauf zu warnen.';
COMMENT ON COLUMN ProductInstance.PriceOverride         IS 'Überschreibt den Produktpreis für eine einzelne Instanz mit einem anderen Preis';
COMMENT ON COLUMN ProductInstance.TaxCategoryID         IS 'Die Steuerkategorie, unter der das Produkt eingekauft werden. Wird bei anlegen der Instanz aus Product kopiert und hält die Steuerkategorie auch nach Änderung am Produkt';
COMMENT ON COLUMN ProductInstance.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN ProductInstance.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE SaleHeader (
  SaleID                SERIAL                   NOT NULL PRIMARY KEY,
  SalesPersonID         INTEGER                  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  CustomerID            INTEGER                  NOT NULL REFERENCES Customer(CustomerID),
  SalesDateTime         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SaleHeader IS 'Modelliert einen Warenverkauf durch einen Verkäufer an einen Kunden. Speichert allgemeine Daten zum Verkauf';
COMMENT ON COLUMN SaleHeader.SaleID                IS 'Eine eindeutige Identifikationsnummer für den Warenverkauf';
COMMENT ON COLUMN SaleHeader.SalesPersonID         IS 'Der den Verkauf durchführende Verkäufer';
COMMENT ON COLUMN SaleHeader.CustomerID            IS 'Der die Waren kaufende Kunde';
COMMENT ON COLUMN SaleHeader.SalesDateTime         IS 'Der Zeitpunkt des Verkaufsabschlusses';
COMMENT ON COLUMN SaleHeader.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN SaleHeader.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE SaleDetail (
  SaleDetailID          SERIAL                   NOT NULL PRIMARY KEY,
  SaleID                INTEGER                  NOT NULL REFERENCES SaleHeader(SaleID),
  ProductInstanceID     INTEGER                  NOT NULL REFERENCES ProductInstance(ProductInstanceID),
  UnitPrice             DECIMAL(10,4)            NOT NULL,
  UnitQuantity          INTEGER                  NOT NULL,
  IsRedemption          BOOLEAN                  NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  SaleDetail IS 'Modelliert einen Warenverkauf durch einen Verkäufer an einen Kunden. Speichert die Warenwechsel. Analogie zu den einzelnen Zeilen eines Kassenbons';
COMMENT ON COLUMN SaleDetail.SaleDetailID          IS 'Eine eindeutige Identifikationsnummer für das Verkaufsdetail';
COMMENT ON COLUMN SaleDetail.SaleID                IS 'Der Verkaufsvorgang, zu dem das Detail gehört';
COMMENT ON COLUMN SaleDetail.ProductInstanceID     IS 'Die verkaufte Produktinstanz';
COMMENT ON COLUMN SaleDetail.UnitPrice             IS 'Der Stückpreis';
COMMENT ON COLUMN SaleDetail.UnitQuantity          IS 'Die verkaufte Menge';
COMMENT ON COLUMN SaleDetail.IsRedemption          IS 'Gibt an, ob es sich um eine Warenrückgabe handelt.';
COMMENT ON COLUMN SaleDetail.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN SaleDetail.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE ClientType (
  ClientTypeID          SERIAL    NOT NULL PRIMARY KEY,
  Name                  TEXT      NOT NULL UNIQUE,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  ClientType IS 'Modelliert verschiedene Client-Typen, wie Verkaufsclient, Kunden-Webseite, Admin-Client etc.';
COMMENT ON COLUMN ClientType.ClientTypeID IS 'Eine eindeutige Identifikationsnummer';
COMMENT ON COLUMN ClientType.Name IS 'Eine Stringbezeichnung, die benutzt werden kann, um nicht mit der ID arbeiten zu müssen';
COMMENT ON COLUMN ClientType.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN ClientType.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE Client (
  ClientID              SERIAL  NOT NULL PRIMARY KEY,
  Name                  TEXT    NOT NULL,
  ClientTypeID          INTEGER NOT NULL REFERENCES ClientType(ClientTypeID),
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
COMMENT ON TABLE  AvailableCredentialTypes IS NULL;
COMMENT ON COLUMN AvailableCredentialTypes.Name IS 'Der Name des Credentialtypen';
COMMENT ON COLUMN AvailableCredentialTypes.NeedsPassword IS 'Gibt an, ob der Credentialtyp zwingend ein gesetztes CredentialSecret vorraussetzt';
COMMENT ON COLUMN AvailableCredentialTypes.ModuleIdentifier IS 'Der Name des für den Typen zuständigen Programmmoduls';
COMMENT ON COLUMN AvailableCredentialTypes.EntryAddedDate IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN AvailableCredentialTypes.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
CREATE TABLE AllowedCredentialUse (
  CredentialTypeID      INTEGER   NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  ClientTypeID          INTEGER   NOT NULL REFERENCES ClientType(ClientTypeID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),

  PRIMARY KEY (CredentialTypeID, ClientTypeID)
);
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE Username (
  UsernameID            SERIAL                   NOT NULL PRIMARY KEY,
  Username              TEXT                     NOT NULL UNIQUE,
  PersonID              INTEGER                  NOT NULL REFERENCES Person(PersonID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
  
);
COMMENT ON TABLE  Username IS 'Ein Nutzername identifiziert einen Benutzer für den Login. Jeder Nutzername gehört zu genau einer Person.';
COMMENT ON COLUMN Username.UsernameID            IS 'Die eindeutige Identifikationsnummer des Nutzernamens wird bei den Secrets in Credential benutzt';
COMMENT ON COLUMN Username.Username              IS 'Der Nutzername, ermöglicht den Login einer Person an einem Client.';
COMMENT ON COLUMN Username.PersonID              IS 'Die Person, zu der der Nutzername gehört.';
COMMENT ON COLUMN Username.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Username.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE Credentials (
  CredentialID          SERIAL                   NOT NULL PRIMARY KEY,
  CredentialSecret      BYTEA                        NULL,
  UsernameID            INTEGER                  NOT NULL REFERENCES Username(UsernameID),
  CredentialTypeID      INTEGER                  NOT NULL REFERENCES AvailableCredentialTypes(CredentialTypeID),
  IsSalesPersonLogin    BOOLEAN                  NOT NULL,
  CredentialCreateDate  DATE                     NOT NULL,
  LastSecretChange      TIMESTAMP WITH TIME ZONE     NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Credentials IS 'Credentials sind (geheime) Login-Informationen, welche die Anmeldung an Clients erlauben.';
COMMENT ON COLUMN Credentials.CredentialID          IS 'Eine eindeutige Identifikationsnummer';
COMMENT ON COLUMN Credentials.CredentialSecret      IS 'Das Geheimnis, welches der Nutzer zum Login mit dem Credential benötigt. Format hängt vom CredentialType ab';
COMMENT ON COLUMN Credentials.UsernameID            IS 'Referenziert über den Username die Person, zu der der Login gehört';
COMMENT ON COLUMN Credentials.CredentialTypeID      IS 'Gibt den Typen des Credentials an.';
COMMENT ON COLUMN Credentials.IsSalesPersonLogin    IS 'Gibt an, ob das Credential für einen Kunden- oder Mitarbeiterlogin verwendet wird.';
COMMENT ON COLUMN Credentials.CredentialCreateDate  IS 'Das Datum, an dem der Login angelegt wurde.';
COMMENT ON COLUMN Credentials.LastSecretChange      IS 'Das Datum, an dem das Geheimnis das letzte mal geändert wurde';
COMMENT ON COLUMN Credentials.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Credentials.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE CredentialUse (
  ClientTypeID          INTEGER                  NOT NULL REFERENCES ClientType(ClientTypeID),
  CredentialID          INTEGER                  NOT NULL REFERENCES Credentials(CredentialID),
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY (CredentialID, ClientTypeID)
);
COMMENT ON TABLE CredentialUse IS 'Definiert, welche Credentials zur Anmeldung an welchen Client-Typen freigeschaltet ist.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE Charge (
  ChargeID              SERIAL                   NOT NULL PRIMARY KEY,
  CustomerID            INTEGER                  NOT NULL REFERENCES Customer(CustomerID),
  SalesPersonID         INTEGER                  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  Donation              BOOLEAN                  NOT NULL DEFAULT(FALSE),
  ChargeAmount          DECIMAL(10,2)            NOT NULL,
  ChargeDate            TIMESTAMP WITH TIME ZONE NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP)
);
COMMENT ON TABLE  Charge IS 'Charge speichert die Guthabenaufladungen der Kunden. Wenn ein Kunde bei einem Verkäufer sein Kundenkonto auflädt, wird ein Eintrag für diese Aufladung in dieser Tabelle abgelegt.';
COMMENT ON COLUMN Charge.ChargeID              IS 'Die eindeutige Identifikationsnummer der Guthabenaufladung';
COMMENT ON COLUMN Charge.CustomerID            IS 'Der Kunde, dem das Geld auf sein Guthaben gutgeschrieben wird';
COMMENT ON COLUMN Charge.SalesPersonID         IS 'Der Verkäufer, der die Guthabenaufladung durchführt und das Geld entgegennimmt.';
COMMENT ON COLUMN Charge.Donation              IS 'Gibt an, ob es sich bei der Aufladung um eine Spende handelt. Bei einer Spende wird das Geld nicht auf dem Kundenkonto gutgeschrieben.';
COMMENT ON COLUMN Charge.ChargeAmount          IS 'Der aufgeladene oder gespendete Geldbetrag';
COMMENT ON COLUMN Charge.ChargeDate            IS 'Das Datum der Guthabenaufladung';
COMMENT ON COLUMN Charge.EntryAddedDate        IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Charge.EntryLastModifiedDate IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE Repayment (
  RepaymentID             SERIAL                   NOT NULL PRIMARY KEY,
  SalesPersonID           INTEGER                  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  TransactionDate         DATE                     NOT NULL,
  Amount                  DECIMAL(10, 2)           NOT NULL,
  RequiredAmountRedeemers INTEGER                  NOT NULL DEFAULT(1),
  EntryAddedDate          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  CONSTRAINT PositiveRequiredAmountRedeemers CHECK(RequiredAmountRedeemers >= 0)
);
COMMENT ON TABLE  Repayment IS 'Eine Guthabenaufladung eines Kunden belastet das Verkäuferkonto. Dieses wird durch Eintragungen von Geldrückzahlungen in dieser Tabelle ausgeglichen';
COMMENT ON COLUMN Repayment.RepaymentID             IS 'Eindeutige Identifikationsnummer für die Geldrückzahlung';
COMMENT ON COLUMN Repayment.SalesPersonID           IS 'Der Geld rückzahlende Verkäufer';
COMMENT ON COLUMN Repayment.TransactionDate         IS 'Das Datum, an dem die Transaktion getätigt wurde';
COMMENT ON COLUMN Repayment.Amount                  IS 'Der zurückgezahlte Geldbetrag';
COMMENT ON COLUMN Repayment.RequiredAmountRedeemers IS 'Die minimale Anzahl an Bestätigungen durch Finanzbeauftragte, um den Eintrag als bestätigt anzusehen.';
COMMENT ON COLUMN Repayment.EntryAddedDate          IS 'Das Datum, an dem der Datenbankeintrag angelegt wurde. Vor Veränderungen geschützt.';
COMMENT ON COLUMN Repayment.EntryLastModifiedDate   IS 'Das Datum, an dem der Datenbankeintrag zuletzt bearbeitet wurde. Wird bei Änderungen am Datensatz von einem Datenbank-Trigger automatisch aktualisiert.';
COMMENT ON CONSTRAINT PositiveRequiredAmountRedeemers ON Repayment IS 'Die Minimalanzahl an Einträgen in RedeemerFor für das Akzeptieren des Eintrag darf nicht negativ sein.';
-- TODO: nächste Tabellendefinition zusammen mit den  SQL-Kommentaren ins Wiki kopieren
CREATE TABLE RedeemerFor (
  SalesPersonID         INTEGER                  NOT NULL REFERENCES SalesPerson(SalesPersonID),
  RepaymentID           INTEGER                  NOT NULL REFERENCES Repayment(RepaymentID),
  AcknowledgedDate      DATE                     NOT NULL,
  EntryAddedDate        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  EntryLastModifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
  PRIMARY KEY(SalesPersonID, RepaymentID)
);
COMMENT ON TABLE RedeemerFor IS 'Eine Geldrückzahlung muss von einem oder mehreren Finanzbeauftragten bestätigt werden, um wirksam zu sein. Diese Tabelle speichert die Bestätigungen';
CREATE VIEW TaxCategory AS
  SELECT n.TaxCategoryID, n.Name, '1337-01-01' AS ValidSince, n.BaseValue AS Value, n.BaseValueUnit AS Unit
  FROM TaxCategoryName AS n
  UNION ALL
  SELECT n.TaxCategoryID, n.Name, v.ValidSince, v.Value, v.Unit
  FROM TaxCategoryName  AS n
    JOIN TaxCategoryValue AS v ON n.TaxCategoryID = v.TaxCategoryID
;
CREATE VIEW ProductTaxes AS
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
COMMENT ON VIEW ProductTaxes IS 'Berechnet die Steuerkategorie für jede Produktinstanz aus den verfügbaren Daten.';
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
  FROM Person AS cp
  JOIN Customer AS cu    ON cp.PersonID = cu.CustomerID
  JOIN Charge AS ch      ON cu.CustomerID = ch.CustomerID
  JOIN SalesPerson AS sp ON ch.SalesPersonID = sp.SalesPersonID
  JOIN Person AS spp     ON sp.SalesPersonID = spp.PersonID
;
COMMENT ON VIEW CustomerCharges IS 'Berechnet eine Übersicht über alle Kundenkontoaufladungen';
CREATE VIEW CustomerBalance AS
  SELECT cu.CustomerID,
  (cu.BaseBalance
    + COALESCE(CustChargeSum.Charge, 0) -- ist NULL, wenn der Kunde noch keine Aufladung getätigt hat
    - COALESCE(CustSaleSum.SaleTotal, 0) -- ist NULL, wenn der Kunde noch nichts gekauft hat
    + COALESCE(CustRedemptSum.RedemptionTotal, 0) -- ist NULL, wenn der Kunde noch keine Waren zurückgegeben hat
  ) AS Balance
  
  FROM Customer AS cu
  
  LEFT OUTER JOIN ( -- Summe aller Aufladungen
    SELECT ch.CustomerID, SUM( ch.ChargeAmount) AS Charge
    FROM Charge AS ch
    WHERE ch.Donation IS FALSE
    GROUP BY ch.CustomerID
  ) AS CustChargeSum ON CustChargeSum.CustomerID = cu.CustomerID
  
  LEFT OUTER JOIN ( -- Summe aller Warenkäufe
    SELECT sh.CustomerID, SUM( sd.UnitQuantity * sd.UnitPrice) AS SaleTotal
    FROM SaleHeader AS sh
    JOIN SaleDetail AS sd ON sh.SaleID = sd.SaleID
    WHERE sd.IsRedemption IS FALSE
    GROUP BY sh.CustomerID
  ) AS CustSaleSum ON CustSaleSum.CustomerID = cu.CustomerID
  
  LEFT OUTER JOIN ( -- Summe aller Warenrückgaben
    SELECT sh.CustomerID, SUM( sd.UnitQuantity * sd.UnitPrice) AS RedemptionTotal
    FROM SaleHeader AS sh
    JOIN SaleDetail AS sd ON sh.SaleID = sd.SaleID
    WHERE sd.IsRedemption IS true
    GROUP BY sh.CustomerID
  ) AS CustRedemptSum ON CustRedemptSum.CustomerID = cu.CustomerID
;
COMMENT ON VIEW CustomerBalance IS 'Berechnet den aktuellen Kontostand der Kunden als Summe aller Aufladungen und Verkäufe';
CREATE VIEW SalesPersonBalance AS
  SELECT sp.SalesPersonID,
  (sp.BaseBalance
    - COALESCE(SPChargeSum.Charge, 0) -- ist NULL, wenn der Verkäufer noch kein Geld angenommen hat
    + COALESCE(SPRepaymentSum.RepaidAmount, 0) -- ist NULL, wenn der Verkäufer noch nichts zurückgezahlt hat
  ) AS Balance
  
  FROM SalesPerson AS sp
  
  LEFT OUTER JOIN ( -- Summe aller Aufladungen
    SELECT ch.SalesPersonID, SUM( ch.ChargeAmount ) AS Charge
    FROM Charge AS ch
    -- Hier nicht nach Donation filtern wie bei Customer, Das Verkäuferkonto wird auch für Spenden belastet
    GROUP BY ch.SalesPersonID
  ) AS SPChargeSum ON SPChargeSum.SalesPersonID = sp.SalesPersonID
  
  LEFT OUTER JOIN ( -- Summe aller vollständig bestätigten Geldrückzahlungen
    SELECT rp.SalesPersonID, SUM( rp.Amount) AS RepaidAmount
    FROM Repayment AS rp
    WHERE rp.RequiredAmountRedeemers <= ( -- Die Anzahl Bestätigungen muss größer/gleich dem Wert RequiredAmountRedeemers sein
      -- SELECT COUNT(*) ist ein sicheres Aggregat für eine solche Subanfrage,
      -- weil es garantiert immer exakt einen Wert liefert.
      SELECT COUNT(*) 
      FROM RedeemerFor AS rf
      WHERE rf.RepaymentID = rp.RepaymentID
    )
    GROUP BY rp.SalesPersonID
  ) AS SPRepaymentSum ON SPRepaymentSum.SalesPersonID = sp.SalesPersonID
;
COMMENT ON VIEW SalesPersonBalance IS 'Berechnet den aktuellen Kontostand des Verkäufers als Summe aller Kundenkontoaufladungen und Geldrückzahlungen';
