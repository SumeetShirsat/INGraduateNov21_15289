Section 20


SELECT companyname,country,
CASE WHEN country IN ('Austria','Germany','Poland','France','Sweden','Italy','Spain',
             'UK','Ireland','Belgium','Finland','Norway','Portugal','Switzerland') THEN 'Europe'
             WHEN country IN ('Canada','Mexico','USA') THEN 'North America'
             WHEN country IN ('Argentina','Brazil','Venezuela') THEN 'South America'
             ELSE country
END AS continent
FROM customers;

SELECT productname,unitprice,
CASE WHEN unitprice<10 THEN 'inexpensive'
     WHEN unitprice>=10 AND unitprice<=50 THEN 'mid-range'
	 WHEN unitprice > 50 THEN 'premium'
END AS quality
FROM products;

SELECT companyname,city,
CASE city WHEN 'New Orleans' THEN 'Big Easy'
                   WHEN 'Paris' THEN 'City of Lights'
	         ELSE 'Needs nickname'
END as nickname
FROM suppliers;

SELECT orderid,customerid,
CASE date_part('year', orderdate)
	WHEN 1996 THEN 'year1'
	WHEN 1997 THEN 'year2'
	WHEN 1998 THEN 'year3'
END
FROM orders;

----

SELECT customerid,COALESCE(shipregion,'N/A')		--COALESCE changes null value to N/A 
FROM orders;

SELECT companyname,COALESCE(homepage,'Call to find') from suppliers;

--

UPDATE suppliers
SET homepage = ''
WHERE homepage IS NULL;

UPDATE customers
SET fax = ''
WHERE fax IS NULL;

SELECT companyname,phone,
COALESCE(NULLIF(homepage,''),'Need to call')
FROM suppliers;

SELECT companyname,
COALESCE(NULLIF(fax,''),phone) AS confirmation
FROM customers;
================================

Section 22

SELECT companyname, orderid, amount , average_order FROM
( SELECT companyname, orderid, amount ,AVG(amount) OVER (PARTITION BY companyname) AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) as order_amounts) as order_averages
WHERE amount > 5 * average_order
ORDER BY companyname

-----------------

SELECT companyname, orderid, amount , average_order FROM
( SELECT companyname, orderid, amount ,AVG(amount) OVER (PARTITION BY companyname) AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) as order_amounts) as order_averages
WHERE amount > 5 * average_order
ORDER BY companyname

SELECT companyname,month,year,total_orders,average_monthly
FROM (
SELECT companyname,total_orders,month,year,
AVG(total_orders) OVER (PARTITION BY companyname) as average_monthly
FROM (
SELECT companyname,SUM(quantity) as total_orders,date_part('month',orderdate) as month,date_part('year',orderdate) as year
FROM order_details
JOIN products ON order_details.productid = products.productid
JOIN suppliers ON suppliers.supplierid=products.supplierid
JOIN orders ON orders.orderid=order_details.orderid
GROUP BY companyname,month,year)  as order_by_month) as average_monthly
WHERE total_orders > 3 * average_monthly

----------

SELECT * FROM
(SELECT orders.orderid, productid, unitprice, quantity,
 	rank() OVER (PARTITION BY order_details.orderid ORDER BY (quantity*unitprice) DESC) AS rank_amount
FROM orders
NATURAL JOIN order_details) as ranked
WHERE rank_amount <=2;

SELECT companyname,productname,unitprice FROM
(SELECT companyname,productname,unitprice,
rank() OVER (PARTITION BY products.supplierid ORDER BY unitprice ASC) AS price_rank
FROM suppliers
NATURAL JOIN products) as ranked_products
WHERE price_rank <=3;

====================

Section 23

CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TABLE friends (
	first_name varchar(100),
	last_name varchar(100),
	address	address
);

DROP TYPE address CASCADE;
DROP TABLE friends;


CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TABLE friends (
	name full_name,
	address	address
);

DROP TYPE address CASCADE;
DROP TYPE full_name CASCADE;
DROP TABLE friends;

-------------------------------------

CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TYPE dates_to_remember AS (
  birthdate date,
  age       integer,
  anniversary date
);

CREATE TABLE friends (
	name full_name,
	address	address,
  specialdates dates_to_remember
);

INSERT INTO friends (name, address, specialdates)
VALUES (ROW('Boyd','M','Gregory'),ROW('7777','','Boise','Idaho','USA','99999'),ROW('1969-02-01',49,'2001-07-15'));

SELECT * FROM friends;
SELECT name FROM friends;

SELECT (address).city,(specialdates).birthdate
FROM friends;

SELECT name FROM friends
WHERE (name).first_name = 'Boyd';

SELECT (address).state_region,(name).middle_name,(specialdates).age FROM friends
WHERE (name).last_name = 'Gregory';





