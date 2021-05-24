
--INCISO 1

--Seleccionamos las columnas de interes
SELECT TO_CHAR(salesorderheader.ModifiedDate,'YYYY-MM') AS MES, salesterritory.Name AS NombreTerritorio, salesorderheader.Status,  
COUNT(SalesOrderID), SUM(TotalDue) --Contamos cuantos elementos hay por cada status y sumamos las cantidades de la columna total due
FROM salesorderheader JOIN salesterritory ON salesorderheader.territoryID = salesterritory.territoryID # Combinamos tabla header con sales territory
GROUP BY salesterritory.Name, salesorderheader.Status, TO_CHAR(salesorderheader.ModifiedDate,'YYYY-MM') # Agrupamos por status, date y territorio

-- INCISO 2
SELECT TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'),salesorderheader.customerid, salesorderdetail.productID,
COUNT(salesorderdetail.productID), SUM(salesorderdetail.LineTotal) --Contamos el numero de elementos por cada subcategoria
FROM salesorderheader JOIN salesorderdetail ON salesorderheader.salesorderid = salesorderdetail.salesorderid --Hacemos join de header y detalle
WHERE salesorderheader.status = 2 --Obtenemos solo los estatus aprobados
GROUP BY salesorderdetail.productID,TO_CHAR(salesorderheader.OrderDate,'YYYY-MM'),
salesorderheader.customerid --Agrupamos por fecha y el cliente
ORDER BY COUNT(salesorderdetail.productID) DESC, SUM(salesorderdetail.LineTotal) DESC --Ordenamos ascendentemente por detalle de venta y descendentemente por total
LIMIT 3 --Obtenemos solo los top resultados

--INCISO 4

--Seleccionamos solamente los valores unicos en codigo
select distinct l1.codigo as ConsecutiveNums
from 
secuencial l1, # importamos la tabla secuencial con distintos alias 
secuencial l2, 
secuencial l3
where l1.secuencial = l2.secuencial-1 # Miramos si el secuencia actual es igual al anterior
and l2.secuencial = l3.secuencial-1 # miramos si el secuencial anterior es igual al anterior de este
and l1.codigo=l2.codigo # miramos que tenga el mismo codigo 
and l2.codigo=l3.codigo 

--INCISO 5
-- selecionamos la fecha con cambio de formato, el ID del customer porque no habia nombre, la ultima fecha que compro el customer
-- y la diferencia entre la ultima y penultima fecha
SELECT TO_CHAR(T.OrderDate,'YYYY-MM') AS MES,T.CustomerID AS CLIENTE, MAX(T.OrderDate) AS FechaUltCompra, 
			(MAX(T.OrderDate) - 
			(SELECT MAX(N.OrderDate) FROM salesorderheader N WHERE
            N.customerid = T.customerid AND
            N.OrderDate < MAX(T.OrderDate))) AS DIASUC_PC
FROM salesorderheader T -- Importamos la tabla header con un alias
GROUP BY TO_CHAR(T.OrderDate,'YYYY-MM'), T.CustomerID --agrupamos por mes y customer

--


