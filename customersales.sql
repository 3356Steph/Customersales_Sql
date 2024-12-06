-- Calculate the average order from each country
```Sql
SELECT country, Avg(priceEach * quantityOrdered) As Avg_order_value
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY country
ORDER BY Avg_order_value DESC;

-- Calculate the total sales amount sales for each product line
```Sql
SELECT productLine, SUM(priceEach * quantityOrdered) AS sales_value
FROM orderdetails od
INNER JOIN products p ON od.productCode = p.productCode
-- INNER JOIN productlines pl ON p.productLine = pl.productLine
GROUP BY productLine;

-- List the top 20 best selling products based on total quqntity sold
```Sql
SELECT productName, SUM(quantityOrdered) as units_sold
FROM orderdetails od
INNER JOIN products p ON od.productCode= p.productCode
GROUP BY productName
ORDER BY units_sold  DESC
LIMIT 20;

-- List the top 20 least selling products based on total quqntity sold
```Sql
SELECT productName, SUM(quantityOrdered) as units_sold
FROM orderdetails od
INNER JOIN products p ON od.productCode= p.productCode
GROUP BY productName
ORDER BY units_sold
LIMIT 20;

-- Calculate the average of orders per customer
```Sql
SELECT COUNT(o.orderNumber)/COUNT(DISTINCT c.customerNumber) AS AVg_sale_per_Cust
FROM customers c
LEFT JOIN orders o ON c.customerNumber= o.customerNumber;

-- Calcuate the percentage of orders that were shipped on time
```Sql
SELECT SUM(CASE WHEN shippedDate <= requiredDate THEN 1 ELSE 0 END)/COUNT(orderNumber)*100 as Shipped_on_Time
FROM orders;

-- Calculate net profit for each product
```Sql
SELECT productName, SUM((priceEach*quantityOrdered)-(buyPrice*quantityOrdered)) as Net_profit 
FROM products p
INNER JOIN orderdetails od ON p.productCode= od.productCode
GROUP BY productName;

-- Segement customers based on their total purchase amount
```Sql
SELECT c.customerName,t2.Customer_Segment
FROM customers c
LEFT JOIN 
(SELECT *,
CASE WHEN Total_Purchase_Amount > 100000 THEN 'High Value'
     WHEN Total_Purchase_Amount BETWEEN 50000 AND 100000 THEN 'Medium Value'
     WHEN Total_Purchase_Amount < 50000 THEN 'Low Value'
     ELSE 'other' End AS Customer_Segment
FROM
(SELECT customerNumber, SUM(priceEach*quantityOrdered) as Total_Purchase_Amount
FROM orders o
INNER JOIN orderdetails od ON o.orderNumber=od.orderNumber
GROUP BY customerNumber)t1
)t2
ON c.customerNumber = t2.customerNumber;

-- Identify frequently co-purchased products to understand cross-selling opportunties
```Sql
SELECT od.productCode, p.productName, od2.productCode, p2.productName, count(*) as purchased_together
FROM orderdetails od
INNER JOIN orderdetails od2 ON od.orderNumber = od2.orderNumber AND od.productCode != od2.productCode 
INNER JOIN products p 
ON od.productCode= p.productCode
INNER JOIN products p2 
ON od2.productCode= p2.productCode
GROUP BY od.productCode, p.productName, od2.productCode, p2.productName
ORDER BY purchased_together DESC;

-- Evaluate the sales performance for each sales representative
```Sql
SELECT e.firstName, e.lastName, SUM(quantityOrdered*priceEach) as Sales_value
FROM employees e
INNER JOIN customers c 
ON employeeNumber= salesRepEmployeeNumber AND e.jobTitle= 'Sales Rep'
LEFT JOIN orders o
ON c.customerNumber= o.customerNumber
LEFT JOIN orderdetails od
ON o.orderNumber = od.orderNumber
GROUP BY e.firstName, e.lastName
ORDER BY Sales_value DESC;
