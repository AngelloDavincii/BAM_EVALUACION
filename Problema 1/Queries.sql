--Queries para crear base de datos y tablas en postgres
CREATE DATABASE BAM;

CREATE TABLE datos_base_clientes(
    documento BIGINT,
	tipo_doc INT,
	categoria VARCHAR(255),
	mnt_trx_mm FLOAT,
	num_trx INT,
	pct_mnt_tot FLOAT,
	pct_num_trx_tot FLOAT,
	PRIMARY KEY (documento)
);

CREATE TABLE Person_Person(
    BusinessEntityID INT,
	PersonType VARCHAR(10),
	NameStyle INT,
	Title VARCHAR(10),
	FirstName VARCHAR(255),
	MiddleName VARCHAR(255),
	LastName VARCHAR(255),
	Suffix VARCHAR(10),
	EmailPromotion INT,
	AdditionalContactInfo VARCHAR(5000),
	Demographics VARCHAR(1000),
	rowguid VARCHAR(255),
	ModifiedDate DATE,
	PRIMARY KEY (BusinessEntityID)
);

CREATE TABLE Product(
    ProductID INT,
    Name VARCHAR(255),
    ProductNumber VARCHAR(100),
    MakeFlag INT,
    FinishedGoodsFlag INT,
    Color VARCHAR(100),
    SafetyStockLevel INT,
    ReorderPoint INT,
    StandardCost DOUBLE PRECISION,
    ListPrice DOUBLE PRECISION,
    Size VARCHAR(20),
    SizeUnitMeasureCode VARCHAR(10),
    WeightUnitMeasureCode VARCHAR(10),
    Weight VARCHAR(20),
    DaysToManufacture INT,
    ProductLine VARCHAR(10),
    Class VARCHAR(10),
	Style VARCHAR(10),
    ProductSubcategoryID INT,
    ProductModelID INT,
    SellStartDate DATE,
    SellEndDate DATE,
    DiscontinuedDate VARCHAR(4),
    rowguid CHAR,
    ModifiedDate DATE,
	
	PRIMARY KEY (ProductID)
);

CREATE TABLE Customer(
    CustomerID INT,
    PersonID VARCHAR(20),
    StoreID VARCHAR(20),
    TerritoryID INT,
    AccountNumber VARCHAR(30),
    rowguid CHAR(50),
    ModifiedDate DATE,
	
	PRIMARY KEY (CustomerID)
);

CREATE TABLE SalesTerritory(
	TerritoryID INT,
	Name VARCHAR(100),
	CountryRegionCode VARCHAR(5),
	Group VARCHAR(30),
	SalesYTD FLOAT,
	SalesLastYear FLOAT,
	CostYTD FLOAT,
	CostLastYear FLOAT,
	rowguid VARCHAR(50),
	ModifiedDate DATE,	
	PRIMARY KEY (TerritoryID)
);

CREATE TABLE Secuencial(
	Secuencial INT,
	Codigo INT,
	PRIMARY KEY (Secuencial)
);

CREATE TABLE SalesOrderHeader(
	SalesOrderID INT,
	RevisionNumber INT,
	OrderDate DATE,
	DueDate Date,
	ShipDate Date,
	Status INT,
	OnlineOrderFlag INT,
	SalesOrderNumber VARCHAR(20),
	PurchaseOrderNumber VARCHAR(20),
	AccountNumber VARCHAR(40),
	CustomerID INT,
	SalesPersonID INT NULL,
	TerritoryID INT,
	BillToAddressID INT,
	ShipToAddressID INT,
	ShipMethodID INT,
	CreditCardID VARCHAR(10),
	CreditCardApprovalCode VARCHAR(50),
	CurrencyRateID VARCHAR(10),
	SubTotal Float,
	TaxAmt Float,
	Freight Float,
	TotalDue Float,
	Comment VARCHAR(10),
	ModifiedDate TIMESTAMP,


	PRIMARY KEY (SalesOrderID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID),
	FOREIGN KEY (SalesPersonID) REFERENCES Person_Person(BusinessEntityID)
);

COPY salesorderheader FROM 'D:\00 BAM\BAM_EVALUACION\Data\Sales.SalesOrderHeader.csv' WITH (FORMAT CSV, DELIMITER ';', NULL 'NULL', HEADER);
