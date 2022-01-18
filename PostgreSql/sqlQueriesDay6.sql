CREATE TABLE subscribers (
	firstname varchar(200),
	 lastname varchar(200),
	email varchar(250),
	signup timestamp,
	frequency integer,
	iscustomer boolean
);

CREATE TABLE returns (
	returnrid serial,
	customerid char(5),
	returndate timestamp,
	productid integer,
	quantity smallint,
	orderid integer
);

ALTER TABLE subscribers RENAME firstname TO first_name;
ALTER TABLE returns RENAME returndate TO return_date;
ALTER TABLE subscribers RENAME TO email_subscribers;
ALTER TABLE returns RENAME TO bad_orders;


ALTER TABLE email_subscribers ADD COLUMN last_visit_date timestamp;
ALTER TABLE bad_orders ADD COLUMN reason text;
ALTER TABLE email_subscribers DROP COLUMN last_visit_date;
ALTER TABLE bad_orders DROP COLUMN reason;


ALTER TABLE email_subscribers ALTER COLUMN email SET DATA TYPE varchar(225);
ALTER TABLE bad_orders ALTER COLUMN quantity SET DATA TYPE int;

DROP TABLE email_subscribers;
DROP TABLE bad_orders;


Section 16

CREATE TABLE practices(
practiceid integer UNIQUE ,
practicefield varchar(50) NOT NULL);

DROP TABLE practices;

ALTER TABLE products
ALTER unitprice SET NOT NULL;

ALTER TABLE employees
ALTER lastname SET NOT NULL;

CREATE TABLE pets(
petid integer UNIQUE,
	name varchar(25) NOT NULL
);

DROP TABLE pets;

ALTER TABLE region
ADD CONSTRAINT regiondescription_region UNIQUE (regiondescription);

ALTER TABLE shippers
ADD CONSTRAINT companyname_shippers UNIQUE (companyname);

CREATE TABLE practices(
practiceid integer PRIMARY KEY ,
fieldname varchar(50) NOT NULL);

DROP TABLE practices;

INSERT INTO practices(practiceid,fieldname)
VALUES (1,'something');

CREATE TABLE pets(
petid integer PRIMARY KEY,
	name varchar(25) NOT NULL
);

INSERT INTO pets (petid,name)
VALUES(1)

ALTER TABLE practices
DROP CONSTRAINT practices_employeeid_fkey;

ALTER TABLE practices
ADD PRIMARY KEY (practiceid);

ALTER TABLE pets
DROP CONSTRAINT pets_customerid_fkey;

ALTER TABLE pets
ADD PRIMARY KEY (petid);

CREATE TABLE practices(
practiceid integer PRIMARY KEY ,
fieldname varchar(50) NOT NULL,
employeeid integer NOT NULL,
cost integer DEFAULT 50 CONSTRAINT practices_cost CHECK (cost>=0 AND cost<=1000),
FOREIGN KEY (employeeid) REFERENCES employees (employeeid)
);

INSERT INTO practices(practiceid,fieldname,employeeid,cost)
VALUES(1,'someone',1,1500);

CREATE TABLE pets(
	petid integer UNIQUE,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer DEFAULT 5 CONSTRAINT pets_weight CHECK (weight>=0 AND weight<=200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

INSERT INTO pets(petid,name,customerid,weight)
VALUES(1,)

DROP TABLE pets;

ALTER TABLE practices
ADD CONSTRAINT practices_employeeid_fkey
FOREIGN KEY (employeeid) REFERENCES employees (employeeid);

ALTER TABLE pets
ADD CONSTRAINT pets_customerid_fkey
FOREIGN KEY (customerid) REFERENCES customers (customerid);

ALTER TABLE orders
ADD CONSTRAINT orders_freight CHECK (freight>0);

ALTER TABLE products
ADD CONSTRAINT products_unitprice CHECK (unitprice>0);

ALTER TABLE orders
ALTER COLUMN shipvia SET DEFAULT 1;

ALTER TABLE products
ALTER COLUMN reorderlevel SET DEFAULT 5;

ALTER TABLE products
ALTER COLUMN reorderlevel DROP DEFAULT ;

ALTER TABLE suppliers
ALTER COLUMN homepage SET DEFAULT 'N/A';

ALTER TABLE suppliers
ALTER COLUMN homepage DROP DEFAULT;

ALTER TABLE products
ADD CHECK (reorderlevel>=0);

UPDATE products
SET reorderlevel =0
WHERE reorderlevel is null or reorderlevel < 0;

ALTER TABLE products 
ALTER COLUMN discontinued SET NOT NULL;

ALTER TABLE products
DROP CONSTRAINT products_reorderlevel_check;

ALTER TABLE products 
ALTER COLUMN discontinued DROP NOT NULL;

ALTER TABLE order_details
ADD CHECK (unitprice > 0);

ALTER TABLE order_details
ALTER COLUMN discount SET NOT NULL;

ALTER TABLE order_details
DROP CONSTRAINT order_details_unitprice_check;

ALTER TABLE order_details
ALTER COLUMN discount DROP NOT NULL;

=============================================================

Section 17

CREATE SEQUENCE test_sequence;
SELECT nextval('test_sequence');	//next value
SELECT currval('test_sequence');	//current value
SELECT lastval(); // last value
SELECT setval('test_sequence',14);   //sets value for sequence
SELECT nextval('test_sequence');
SELECT setval('test_sequence',25,false);

CREATE SEQUENCE IF NOT EXISTS test_sequence_2 INCREMENT 5;  // increments sequence by 5
SELECT nextval('test_sequence_2');

CREATE SEQUENCE IF NOT EXISTS test_sequence_3
INCREMENT 50 MINVALUE 350 MAXVALUE 5000 START WITH 550;

CREATE SEQUENCE IF NOT EXISTS test_sequence_4 INCREMENT 7 START WITH 33;

SELECT MAX(employeeid) FROM employees;

CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
START WITH 10 OWNED BY employees.employeeid;

INSERT INTO employees (lastname,firstname,title,reportsto)
VALUES('SMITH','BOB','Assistant',2);

ALTER TABLE employees
ALTER COLUMN employeeid SET DEFAULT nextval('employees_employeeid_seq');

INSERT INTO employees (lastname,firstname,title,reportsto)
VALUES('SMITH','BOB','Assistant',2) RETURNING employeeid;

SELECT MAX(orderid) FROM orders;

CREATE SEQUENCE IF NOT EXISTS orders_orderid_seq START WITH 11078;

ALTER TABLE orders
ALTER COLUMN orderid SET DEFAULT nextval('orders_orderid_seq');

INSERT INTO orders (customerid,employeeid,requireddate,shippeddate)
VALUES ('VINET',5,'1996-08-01','1996-08-10') RETURNING orderid;

---

ALTER SEQUENCE employees_employeeid_seq RESTART WITH 1000;
SELECT nextval('employees_employeeid_seq');

ALTER SEQUENCE orders_orderid_seq RESTART WITH 200000;
SELECT nextval('orders_orderid_seq');

ALTER SEQUENCE test_sequence RENAME TO test_sequence_1;

ALTER SEQUENCE test_sequence_4  RENAME TO test_sequence_four;

DROP SEQUENCE test_sequence_1;

DROP SEQUENCE test_sequence_four;

---

DROP TABLE IF EXISTS exes;

CREATE TABLE exes (
exid SERIAL,
name varchar(255)
);
INSERT INTO exes (name) VALUES ('Carrie') RETURNING exid

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
petid SERIAL,
name varchar(255)
);

INSERT INTO pets (name) VALUES ('Fluffy') RETURNING petid;

--------

WITH top_category_sales AS (
 SELECT categoryname,SUM(od.unitprice*quantity) AS sales
	FROM categories AS c
	JOIN PRODUCTS USING(categoryid)
	JOIN order_details AS od USING (productid)
	GROUP BY categoryname
	ORDER BY sales DESC LIMIT 3
);
SELECT categoryname,productname,SUM(od.quantity) AS product_units,
SUM(od.unitprice*quantity) AS product_sales
FROM categories AS c
JOIN PRODUCTS USING(categoryid)
JOIN order_details AS od USING (productid)
WHERE categoryname IN (SELECT categoryname FROM top_category_sales)
GROUP BY categoryname,productname
ORDER BY categoryname


WITH slowest_products AS (
	SELECT productid,SUM(od.quantity)
	FROM products
	JOIN order_details AS od USING (productid)
	GROUP BY productID
	ORDER BY SUM(od.quantity) ASC
	LIMIT 2
)
SELECT DISTINCT(companyname)
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
WHERE productid IN (SELECT productid FROM  slowest_products)

------

WITH new_order AS (
	INSERT INTO orders
	(customerid, employeeid, orderdate, requireddate)
	VALUES ('ALFKI', 1, '1997-03-10', '1997-03-25')
	RETURNING orderid
)

INSERT INTO order_details (orderid, productid, unitprice, quantity, discount)
SELECT orderid, 1, 20, 5, 0
FROM new_order;

SELECT * FROM orders
ORDER BY orderid DESC
LIMIT 1;

SELECT * FROM order_details
WHERE orderid = (SELECT MAX(orderid) FROM orders);

WITH new_employee AS (
	INSERT INTO employees
	(lastname,firstname,title,reportsto)
	VALUES ('Doger','Roger', 'Assistant', 2)
	RETURNING employeeid
)
INSERT INTO orders
(customerid, employeeid, orderdate, requireddate)
SELECT 'ALFKI', employeeid, '1997-03-10', '1997-03-25'
FROM new_employee;

SELECT * FROM employees
ORDER BY employeeid DESC
LIMIT 1;

SELECT * FROM orders
ORDER BY orderid DESC
LIMIT 1;

------

UPDATE employees
SET reportsto = NULL
WHERE employeeid= 2;


DELETE FROM employees WHERE employeeid > 9;

INSERT INTO employees (firstname,lastname,address,city,country,postalcode,homephone,title,employeeid,reportsto) VALUES
('Josephine','Boyer','463-4613 Ipsum Street','Saint-Prime','USA','73-638','741-0423','CEO',200,NULL),
('Marvin','Cole','P.O. Box 857, 9463 Et St.','Sauris','Philippines','91-806','717-0456','CFO',201,200),
('Lee','Hatfield','Ap #152-543 Facilisis. St.','Baden','Monaco','44981-785','990-7598','CTO',202,200),
('Chancellor','Hubbard','672-2470 Adipiscing Avenue','Chatteris','Macao','79613','1-655-930-7580','Head of Ops',203,200),
('Jakeem','Chaney','177 Mauris Road','Izmir','France','6729','1-849-661-5415','Ops Manager',204,203),
('Paul','Sutton','5572 Morbi St.','Fourbechies','United Kingdom','3072','1-664-924-2966','Ops Manager - Europe',205,203),
('Aaron','Erickson','2646 Sem, Avenue','Olen','USA','9656','1-713-526-0184','Ops Manager - USA',206,203),
('Azalia','Wagner','Ap #543-1195 Mi Av.','Swan Hills','USA','1481','544-1445','Warehouse USA',207,206),
('Elmo','Goodwin','Ap #609-977 Gravida Ave','Frascati','USA','5083','1-281-122-4910','Warehouse USA',208,206),
('Quon','Durham','523 Praesent Rd.','Lutsel K''e','USA','40535-562','951-4455','Warehouse USA',209,206),
('Keaton','Weber','Ap #228-2672 Nulla Av.','La Pintana','USA','6812','1-845-128-7756','Warehouse USA',210,206),
('Edward','Hahn','Ap #802-6505 Malesuada Rd.','Tuticorin','United Kingdom','017440','549-3727','Warehouse Europe',211,205),
('Ariana','Webster','7875 Tempus Avenue','Maltignano','United Kingdom','08573','137-2511','Warehouse Europe',212,205),
('Todd','Workman','3689 Ultrices Street','Northumberland','United Kingdom','8489','516-6304','Warehouse Europe',213,205),
('Zachery','May','Ap #995-8373 Urna. Ave','Malahide','Benin','60538','1-599-255-1156','Sales Assistant',214, 3),
('Bert','Hayden','Ap #302-641 Magna. Avenue','Erdemli','Netherlands','833743','699-3083','Sales Assistant',215, 6),
('Renee','Walter','P.O. Box 366, 9086 Molestie. Rd.','Spijkenisse','Turkey','24-954','1-346-528-1347','Sales Assistant',216, 3),
('Jessica','Moss','Ap #621-2177 Egestas. St.','Chépica','Ireland','2762','1-712-113-5307','Sales Assistant',217, 9),
('Kiona','Dudley','Ap #363-6364 Tincidunt Rd.','Antwerpen','Tonga','OL3H 6ZZ','1-365-255-0842','Sales Assistant',218, 4),
('Veronica','Sosa','Ap #261-3206 Tempus St.','Alcorcón','Malaysia','60804','479-1676','Sales Assistant',219, 8),
('Addison','Welch','P.O. Box 477, 206 Amet Avenue','Abbotsford','Zambia','34948-111','977-9391','Programmer',220, 202),
('Brendan','Parrish','Ap #875-923 In, Ave','Clovenfords','Ecuador','13168','949-4055','Data Analyst',221, 202),
('Dakota','Delgado','P.O. Box 653, 3364 Arcu Rd.','Valdivia','Antarctica','44623','1-206-971-7181','Accounting',222, 201),
('Kirby','Mullins','1166 Donec Rd.','Meridian','Mozambique','886609','807-6992','Accounting',223, 201),
('Stuart','Clarke','P.O. Box 177, 3565 Senectus St.','Viddalba','Libya','WS7 3JO','933-7681','Personal Assistant',224, 200);


UPDATE employees
SET reportsto = 200
WHERE employeeid= 2;

SELECT * FROM employees;

------


WITH RECURSIVE upto(t) AS (
	SELECT 1
	UNION ALL
	SELECT t+1 FROM upto
	WHERE t < 50
)
SELECT * FROM upto


WITH RECURSIVE downfrom(t) AS (
	SELECT 500

	UNION ALL
	SELECT t-2 FROM downfrom
	WHERE t > 2
)
SELECT * FROM downfrom


WITH RECURSIVE under_responsible(firstname,lastname,title, employeeid,reportsto,level) AS (
	SELECT firstname,lastname,title,employeeid,reportsto,0 FROM employees
	WHERE employeeid=200
	UNION ALL
	SELECT Managed.firstname,Managed.lastname,Managed.title,Managed.employeeid,Managed.reportsto,level+1
	FROM employees AS managed
	JOIN under_responsible ON managed.reportsto=under_responsible.employeeid
)
SELECT * FROM under_responsible

WITH RECURSIVE report_to(firstname,lastname,title, employeeid,reportsto,level) AS (
	SELECT firstname,lastname,title,employeeid,reportsto,0 FROM employees
	WHERE employeeid=218
	UNION ALL
	SELECT manager.firstname,manager.lastname,manager.title,manager.employeeid,manager.reportsto,level+1
	FROM employees AS manager
	JOIN report_to ON report_to.reportsto=manager.employeeid
)
SELECT * FROM report_to

================================================

Section 19

CREATE VIEW customer_order_details AS
SELECT companyname, Orders.customerid, employeeid, orderdate, requireddate, shippeddate
Shipvia, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry,
order_details.*
FROM customers
JOIN orders on customers.customerid=orders.customerid
JOIN order_details on order_details.orderid=orders.orderid;

SELECT *
FROM customer_order_details
WHERE customerid='TOMSP';

CREATE VIEW supplier_order_details AS
SELECT companyname, suppliers.supplierid, Products.productid, productname,
Order_details.unitprice, quantity, discount, orders.*
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid;

SELECT *  FROM supplier_order_details WHERE supplierid=5;

---------

CREATE OR REPLACE VIEW customer_order_details AS
SELECT companyname, Orders.customerid,employeeid,requireddate,shippeddate,
Shipvia,freight,shipname,shipcity,shipregion,shippostalcode,shipcountry,
order_details.*,contactname
FROM customers
JOIN orders on customers.customerid=orders.customerid
JOIN order_details on order_details.orderid=orders.orderid;

CREATE OR REPLACE VIEW supplier_order_details AS
SELECT companyname,suppliers.supplierid,
Products.productid,productname,
Order_details.unitprice,quantity,discount,
orders.*,phone
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid;

ALTER VIEW customer_order_details RENAME TO customer_order_detailed;

ALTER VIEW supplier_order_details RENAME TO supplier_orders;

------------

CREATE VIEW north_america_customers AS
SELECT *
FROM customers
WHERE country in ('USA','Canada','Mexico');

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','USA','555-555-5555',null);

UPDATE north_america_customers SET fax='555-333-4141' WHERE customerid='CFDCM';

DELETE FROM north_america_customers WHERE customerid='CFDCM';

CREATE VIEW protein_products AS
SELECT * FROM products
WHERE categoryid in (4,6,8);

INSERT INTO protein_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES (78,'Kobe Beef',12,8,0);

UPDATE protein_products SET unitprice=55 WHERE productid=78;

DELETE FROM protein_products WHERE productid=78;

----

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','Germany','555-555-5555',null);

SELECT FROM customers
WHERE customerid=’CFDCM’;

CREATE OR REPLACE VIEW north_america_customers  AS
SELECT *
FROM customers
WHERE country in ('USA','Canada','Mexico')
WITH LOCAL CHECK OPTION;

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','Germany','555-555-5555',null);

CREATE OR REPLACE VIEW protein_products AS
SELECT * FROM products
WHERE categoryid in (4,6,8)
WITH LOCAL CHECK OPTION;

INSERT INTO protein_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES (78,'Tasty Tea',12,1,0);

ALTER TABLE products
ALTER COLUMN unitprice DROP NOT NULL;

DROP VIEW IF EXISTS customer_order_detailed;

DROP VIEW IF EXISTS supplier_orders;






















