SECTION 10

SELECT companyname FROM customers UNION SELECT companyname FROM suppliers ORDER BY companyname;
SELECT city FROM customers UNION ALL SELECT city FROM suppliers ORDER BY city;
SELECT country FROM customers UNION SELECT country FROM suppliers ORDER BY country;
SELECT country FROM customers UNION ALL SELECT country FROM suppliers;

SELECT country FROM customers INTERSECT SELECT country FROM suppliers;
SELECT country FROM customers INTERSECT ALL SELECT country FROM suppliers;
SELECT city FROM customers INTERSECT SELECT city FROM suppliers;
SELECT COUNT(*) FROM (SELECT city FROM customers INTERSECT ALL SELECT city FROM suppliers) AS SAMECITY;

SELECT country FROM customers EXCEPT SELECT country FROM suppliers;
SELECT COUNT(*) FROM(SELECT country FROM customers EXCEPT ALL SELECT country FROM suppliers)AS country;
SELECT city FROM suppliers EXCEPT SELECT city FROM customers;
SELECT COUNT(*) FROM (SELECT city FROM customers EXCEPT ALL SELECT city FROM suppliers)AS city;

=======================================================================================================
Section 11

--FIND customers that are in same country as the suppliers

SELECT companyname FROM customers WHERE COUNTRY IN ( SELECT country FROM suppliers);

-- FIND suppliers that are in same country as the customers

SELECT companyname FROM suppliers WHERE country IN (SELECT country FROM customers);

SELECT companyname FROM customers WHERE EXISTS 
(SELECT customerid FROM orders WHERE customers.customerid=orders.customerid AND orderdate 
 BETWEEN '1997-04-01' AND '1997-04-30');
 
SELECT companyname FROM customers WHERE NOT EXISTS 
(SELECT customerid FROM orders WHERE customers.customerid=orders.customerid AND orderdate 
 BETWEEN '1997-04-01' AND '1997-04-30');
 
 SELECT productname FROM products WHERE NOT EXISTS (SELECT productid FROM order_details
JOIN orders USING(orderid)
WHERE order_details.productid=products.productid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');

--  Find all suppliers with a product that costs more than $200
SELECT companyname from suppliers WHERE EXISTS
(SELECT productid FROM products WHERE products.supplierid=suppliers.supplierid AND unitprice>200)

-- Find all the suppliers that dont have orders in DEC 1996
SELECT companyname FROM suppliers WHERE NOT EXISTS
(SELECT products.productid FROM products JOIN order_details ON order_details.productid=products.productid
JOIN orders ON orders.orderid=order_details.orderid
WHERE products.supplierid=suppliers.supplierid AND orderdate BETWEEN '1996-12-01' AND '1996-12-31');

========================================================================================================

-- Find customers with order details with more than 50 items in  single product

SELECT companyname FROM customers WHERE customerid = ANY (SELECT customerid FROM  orders
														 JOIN order_details ON order_details.orderid=orders.orderid 
														 WHERE quantity>50);

-- Find all suppliers that have an order with 1 item

SELECT companyname FROM suppliers WHERE supplierid = ANY (SELECT supplierid FROM products 
														  JOIN order_details ON order_details.productid=products.productid
														 WHERE quantity=1);

--Find products which had order amounts that were higher than the avg of all products

SELECT productname FROM products JOIN order_details ON order_details.productid=products.productid
WHERE order_details.unitprice*quantity> ALL (SELECT AVG(order_details.unitprice*quantity)FROM order_details
											GROUP BY productid);

--FIND all distinct customers that ordered more in one item than the avg order amt per item of all customers


 SELECT DISTINCT companyname
 FROM customers
 JOIN orders ON orders.customerid=customers.customerid
 JOIN order_details ON orders.orderid=order_details.orderid
 WHERE  order_details.unitprice*quantity > ALL
 	(SELECT AVG(order_details.unitprice*quantity)
              FROM order_details
             JOIN orders ON orders.orderid=order_details.orderid
             GROUP BY orders.customerid);
=========================================================================================


SECTION 9

-- How many cust do we have in each country
SELECT country,COUNT(*) FROM customers GROUP BY country ORDER BY COUNT(*);

-- What is no of products from each category
SELECT categoryname,COUNT(*) FROM categories 
JOIN products ON products.categoryid=categories.categoryid GROUP BY categoryname ORDER BY COUNT(*);

--What is avg no of items ordered for products ordered by the avg amt
SELECT productname,ROUND(AVG(quantity))
FROM products JOIN order_details 
ON order_details.productid=products.productid GROUP BY productname ORDER BY AVG(quantity) DESC;

--How many suppliers we have in each country
SELECT country,COUNT(*) FROM suppliers GROUP BY country ORDER BY COUNT(*);

--Total value of each product sold for year 1997
SELECT productname,SUM(order_details.unitprice*quantity) FROM products 
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON orders.orderid=order_details.orderid
WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY productname 
ORDER BY SUM(order_details.unitprice*quantity) ;

=====================================================================================

SELECT productname,SUM(quantity*order_details.unitprice) AS AmountBrought FROM products 
JOIN order_details USING (productid)
GROUP BY productname
HAVING SUM(quantity*order_details.unitprice)<2000
ORDER BY AmountBrought ASC;

--Customers that have bought products more than 5000

SELECT companyname, SUM(quantity * order_details.unitprice) AS AmountBought
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
GROUP BY companyname
HAVING SUM(quantity * order_details.unitprice) >5000
ORDER BY AmountBought DESC;

SELECT companyname, SUM(quantity * order_details.unitprice) AS AmountBought
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
WHERE orderdate BETWEEN '1997-01-01' AND '1997-6-30'
GROUP BY companyname
HAVING SUM(quantity * order_details.unitprice) >5000
ORDER BY AmountBought DESC;
======================================================================================



