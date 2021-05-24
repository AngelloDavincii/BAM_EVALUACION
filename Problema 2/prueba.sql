SELECT TO_CHAR(salesorderheader.ModifiedDate,'YYYY-MM'), salesterritory.Name, salesorderheader.Status,  
COUNT(SalesOrderID), SUM(TotalDue)
FROM salesorderheader JOIN salesterritory ON salesorderheader.territoryID = salesterritory.territoryID
GROUP BY salesterritory.Name, salesorderheader.Status, TO_CHAR(salesorderheader.ModifiedDate,'YYYY-MM')