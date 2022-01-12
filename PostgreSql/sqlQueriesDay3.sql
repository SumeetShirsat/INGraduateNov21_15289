Northwind

SELECT DISTINCT country FROM suppliers ORDER BY country DESC;
SELECT DISTINCT country,city FROM suppliers ORDER BY country ASC,city ASC; 
SELECT productname,unitprice FROM products ORDER BY unitprice DESC,productname ASC;

SELECT MIN(shippeddate) FROM orders WHERE shipcountry='Italy';
SELECT MAX(shippeddate) FROm orders WHERE shipcountry='Canada';
SELECT MAX(shippeddate - orderdate) FROm orders WHERE shipcountry='France';

SELECT AVG(freight) FROM orders WHERE shipcountry='Brazil';
SELECT SUM(quantity) FROm order_details WHERE productid=14;
SELECT AVG(quantity) FROM order_details WHERE productid=35;

SELECT contactname FROM customers WHERE contactname LIKE 'D%';
SELECT companyname FROM suppliers WHERE companyname LIKE '_or%';
SELECT companyname FROM customers WHERE companyname LIKE '%er';

SELECT unitprice*quantity AS TotalSpent FROM order_details ORDER BY TotalSpent;
SELECT unitprice*unitsinstock AS TotalInventory FROM products ORDER BY TotalInventory DESC;

SELECT productid,unitprice*quantity AS TotalSpent FROM order_details ORDER BY TotalSpent DESC LIMIT 3;
SELECT productname,unitprice*unitsinstock AS TotalSpent FROM products ORDER BY TotalSpent ASC LIMIT 2;

SELECT COUNT(*) FROM customers WHERE region IS NULL;
SELECT COUNT(*) FROM suppliers WHERE region IS NOT NULL;
SELECT COUNT(*) FROM orders WHERE shipregion IS NULL;



*******SECTION 8*******

SELECT companyname,orderdate,shipcountry FROM orders JOIN customers ON customers.customerid=orders.customerid;
SELECT firstname,lastname,orderdate FROM orders JOIN employees ON employees.employeeid=orders.employeeid;
SELECT companyname,unitprice,unitsinstock FROM products JOIN suppliers ON suppliers.supplierid=products.supplierid;
SELECT companyname,orderdate,unitprice,quantity FROM orders JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON orders.customerid=customers.customerid;

SELECT companyname,orderdate,order_details.unitprice,quantity,productname FROM orders JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON orders.customerid=customers.customerid
JOIN products ON products.productid=order_details.productid;

SELECT companyname,orderdate,order_details.unitprice,quantity,productname,categoryname FROM orders JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON orders.customerid=customers.customerid
JOIN products ON products.productid=order_details.productid
JOIN categories ON categories.categoryid=products.categoryid;

SELECT companyname,orderdate,order_details.unitprice,quantity,productname,categoryname FROM orders JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON orders.customerid=customers.customerid
JOIN products ON products.productid=order_details.productid
JOIN categories ON categories.categoryid=products.categoryid
WHERE categoryname='SeaFood' AND order_details.unitprice*quantity>=500;

SELECT companyname,orderid FROM customers LEFT JOIN orders ON orders.customerid=customers.customerid WHERE orderid IS NULL;
SELECT productname,products.productid FROM order_details LEFT JOIN products ON products.productid=order_details.productid
WHERE orderid IS NULL;

SELECT companyname,orderid FROM orders RIGHT JOIN customers ON customers.customerid=orders.customerid WHERE orderid IS NULL;

SELECT companyname,customertypeid FROM customercustomerdemo RIGHT JOIN customers ON customers.customerid=customercustomerdemo.customerid;


SELECT companyname,orderid FROM customers FULL JOIN orders ON orders.customerid=customers.customerid;
SELECT categoryname,productname FROM products FULL JOIN categories ON categories.categoryid=products.categoryid;


SELECT c1.companyname AS CustomerName1,c2.companyname AS CustomerName2,c1.city 
FROM customers AS c1 
JOIN customers AS c2 
ON c1.city=c2.city
WHERE c1.customerid <> c2.customerid ORDER BY c1.city ASC;

SELECT s1.companyname AS SupplierName1,s2.companyname AS SupplierName2,s1.country 
FROM suppliers AS s1 
JOIN suppliers AS s2 
ON s1.country=s2.country
WHERE s1.supplierid <> s2.supplierid ORDER BY s1.country ASC;

SELECT * FROM orders JOIN order_details USING (orderid)
JOIN products USING(productid);

SELECT companyname,orderid FROM customers LEFT JOIN orders USING(customerid);

SELECT * FROM orders NATURAL JOIN order_details;
SELECT * FROM customers NATURAL JOIN orders
NATURAL JOIN order_details;

====================================================================================

AdventureWorks

SELECT name,weight,productnumber FROM production.product ORDER BY weight ASC; 
SELECT * FROM purchasing.productvendor WHERE productid=407 ORDER BY averageleadtime ASC;
SELECT * FROM sales.salesorderdetail WHERE productid=799 ORDER BY orderqty DESC;

SELECT MAX(discountpct)FROM sales.specialoffer;
SELECT MIN(sickleavehours) FROM humanresources.employee ;
SELECT MAX(rejectedqty) FROM purchasing.purchaseorderdetail;

SELECT AVG(rate) FROM humanresources.employeepayhistory;
SELECT AVG(standardcost) FROM production.productcosthistory WHERE productid=738;
SELECT SUM(scrappedqty) FROM production.workorder WHERE productid=529;

SELECT name FROM purchasing.vendor WHERE name LIKE 'G%';
SELECT name FROM purchasing.vendor WHERE name LIKE '%BIKE%';
SELECT firstname FROM person.person WHERE firstname LIKE '_t%';

SELECT * FROM person.emailaddress LIMIT 20;
SELECT * FROM production.productcategory LIMIT 2;

SELECT COUNT(*) FROM production.product WHERE weight IS NULL;
SELECT COUNT(*) FROM person.person WHERE additionalcontactinfo IS NOT NULL;

******Section 8 Assignment*********

SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity AS be ON be.businessentityid=ph.businessentityid
JOIN person.person AS pe ON pe.businessentityid=be.businessentityid
JOIN person.phonenumbertype AS pnt ON pnt.phonenumbertypeid=ph.phonenumbertypeid
ORDER BY ph.businessentityid DESC;

SELECT productmodel.name,productdescription.description,culture.name
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.productmodel USING(productmodelid)
JOIN production.culture USING(cultureid)
ORDER BY productmodel.name ASC;

SELECT productmodel.name,productdescription.description,culture.name,product.name
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.productmodel USING(productmodelid)
JOIN production.culture USING(cultureid)
JOIN production.product USING(productmodelid)
ORDER BY productmodel.name ASC;

SELECT product.name,productreview.rating,productreview.comments
FROM production.product LEFT JOIN production.productreview USING (productid) ORDER BY productreview.rating ASC;

SELECT product.name,workorder.orderqty,workorder.scrappedqty
FROM production.workorder RIGHT JOIN production.product USING(productid)
ORDER BY product.productid ASC;







 





