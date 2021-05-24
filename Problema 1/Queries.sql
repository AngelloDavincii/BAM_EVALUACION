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

--INCISO 1
SELECT TO_CHAR(salesorderheader.ModifiedDate,'YYYY-MM'), salesterritory.Name, salesorderheader.Status,  
COUNT(SalesOrderID), SUM(TotalDue)
FROM salesorderheader JOIN salesterritory ON salesorderheader.territoryID = salesterritory.territoryID
GROUP BY salesterritory.Name, salesorderheader.Status, TO_CHAR(salesorderheader.ModifiedDate,'YYYY-MM')

-- INCISO 2
SELECT TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'),salesorderheader.customerid, salesorderdetail.productID,
COUNT(salesorderdetail.productID), SUM(salesorderdetail.LineTotal)
FROM salesorderheader JOIN salesorderdetail ON salesorderheader.salesorderid = salesorderdetail.salesorderid
WHERE salesorderheader.status = 2
GROUP BY salesorderdetail.productID,TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'),
salesorderheader.customerid
ORDER BY COUNT(salesorderdetail.productID) DESC, SUM(salesorderdetail.LineTotal) DESC
LIMIT 3

--INCISO 3
SELECT TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'), SalesTerritory.Groupn AS Group,
AVG(salesorderheader.subtotal),SUM(salesorderheader.subtotal),

(SELECT SUM(salesorderheader.subtotal) FROM salesorderheader GROUP BY salesorderheader.Order)

FROM salesorderheader JOIN salesterritory ON salesorderheader.TerritoryID =salesterritory.TerritoryID
GROUP BY TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'), SalesTerritory.Groupn

--INCISO 4
select distinct l1.codigo as ConsecutiveNums
from 
secuencial l1, 
secuencial l2, 
secuencial l3
where l1.secuencial = l2.secuencial-1
and l2.secuencial = l3.secuencial-1
and l1.codigo=l2.codigo
and l2.codigo=l3.codigo

--INCISO 5
SELECT TO_CHAR(T.OrderDate,'YYYY-MM') AS MES,T.CustomerID AS CLIENTE, MAX(T.OrderDate) AS FechaUltCompra, 
			(MAX(T.OrderDate) - 
			(SELECT MAX(N.OrderDate) FROM salesorderheader N WHERE
            N.customerid = T.customerid AND
            N.OrderDate < MAX(T.OrderDate))) AS DIASUC_PC,
			((SELECT MAX(N.OrderDate) FROM salesorderheader N WHERE
            N.customerid = T.customerid AND
            N.OrderDate < MAX(T.OrderDate))
			-
			(SELECT N.Orderdate FROM salesorderheader N
			WHERE N.customerid = T.customerid
			ORDER BY N.salesorderid DESC
			limit 1 offset 2 rows 
			)) AS DiasPC_APC

FROM salesorderheader T
GROUP BY TO_CHAR(T.OrderDate,'YYYY-MM'), T.CustomerID

--ddddddddddddddddddddddddddddddddddddddddddddddd
SELECT TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'), SalesTerritory.Groupn AS Group,
AVG(salesorderheader.subtotal),SUM(salesorderheader.subtotal),

(SELECT SUM(salesorderheader.subtotal) FROM salesorderheader GROUP BY salesorderheader.Order)

FROM salesorderheader JOIN salesterritory ON salesorderheader.TerritoryID =salesterritory.TerritoryID
GROUP BY TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'), SalesTerritory.Groupn


29992

select fecha,sum(campo1) 
from
(
select fecha,campo1
from ejemplo1
union all
select fecha,campo2
from ejemplo2
union all
select fecha,campo3
from ejemplo3
) t
group by fecha