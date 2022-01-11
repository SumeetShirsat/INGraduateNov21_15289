Northwind

SELECT * FROM customers;
SELECT * FROM employees;

SELECT companyname,city, country FROM suppliers;
SELECT categoryname,description FROM categories;

SELECT DISTINCT country FROM customers;
SELECT DISTINCT country,city FROM customers;
SELECT DISTINCT region FROM suppliers;

SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(DISTINCT(city)) FROM suppliers;
SELECT COUNT(DISTINCT(productid)) FROM order_details;

SELECT customerid,shippeddate - orderdate FROM orders;
SELECT orderid,unitprice*quantity FROM order_details;

SELECT companyname FROM suppliers WHERE city='Berlin';
SELECT companyname,contactname FROM customers WHERE country='Mexico';

SELECT COUNT(*) FROM orders WHERE employeeid=3;
SELECT COUNT(*) FROM order_details WHERE quantity>20;
SELECT COUNT(*) FROM orders WHERE freight>=250;

SELECT COUNT(*) FROM orders WHERE orderdate>= '1998-01-01';
SELECT COUNT(*) FROM orders WHERE shippeddate< '1997-07-05';

SELECT COUNT(*) FROM orders WHERE shipcountry='Germany' AND freight>100;
SELECT DISTINCT(customerid) FROM orders WHERE shipvia=2 AND shipcountry='Brazil';

SELECT COUNT(*) FROM customers WHERE country='USA' OR country='Canada'; 
SELECT COUNT(*) FROm suppliers WHERE country='Germany' OR country='Spain';
SELECT COUNT(*) FROm orders WHERE shipcountry='USA' OR shipcountry='Brazil' OR shipcountry='Argentia';

SELECT COUNT(*) FROM customers WHERE NOT country='France';
SELECT COUNT(*) FROm suppliers WHERE country!='USA';

SELECt COUNT(*) FROm orders WHERE shipcountry='Germany' AND (freight<50 OR freight>175);
SELECT COUNT(*) FROM orders WHERE (shipcountry='Canada' OR shipcountry='Spain') AND shippeddate>'1997-05-01';

SELECT COUNT(*) FROM order_details WHERE unitprice BETWEEN 10 AND 20;
SELECT COUNT(*) FROM orders WHERE shippeddate BETWEEN '1996-06-01' AND '1996-09-30';

SELECT COUNT(*) FROM suppliers WHERE country IN('Germany','France','Spain','Italy');
SELECT COUNT(*) FROM products WHERE categoryid IN (1,4,6,7);

============================================================================================================================================
Pagila

SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM staff;

SELECT address,district FROM address;
SELECT title,description FROM film;
SELECT city,country_id FROM city;

SELECT DISTINCT last_name FROM customer;
SELECT DISTINCT first_name FROM actor;
SELECT DISTINCT inventory_id FROM rental;

SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM category;

SELECT COUNT(DISTINCT(first_name)) FROM actor;

SELECT rental_id,return_date-rental_date FROM rental;

=======================================================================================================================================
Usda

SELECT COUNT(*) FROm data_src WHERE journal='Food Chemistry';
SELECT * FROM nutr_def WHERE nutrdesc='Retinol';
SELECT * FROM food_des WHERE manufacname='Kellogg,Co.';
SELECT COUNT(*) FROM data_src WHERE year>2000;
SELECT COUNT(*) FROM food_des WHERE fat_factor < 4;
SELECT * FROM weight WHERE gm_wgt =190;
SELECT COUNT(*) FROM food_des WHERE pro_factor BETWEEN 1.5 AND 5;
SELECT * FROM data_src WHERE year=1990 AND journal='Cereal Foods World';
SELECT COUNT(*) FROM weight WHERE gm_wgt BETWEEN 150 AND 200;
SELECT * FROM nutr_def WHERE units In ('kj','kcal');
SELECT * FROM data_src WHERE year =2000 OR journal='Food Chemistry';
SELECT fdgrp_cd FROM fd_group WHERE fddrp_desc = 'Breakfast Cereals';
SELECT * FROM food_des WHERE fdgrp_cd!='0800';
SELECT * FROM data_src WHERE year BETWEEN 1990 AND 2000 AND (journal = 'J. Food Protection' OR Journal='Food Chemistry');
SELECT COUNT(*) FROM weight WHERE gm_wgt BETWEEN 50 AND 75;
SELECT * FROM data_src WHERE year IN (1960,1970,1980,1990,2000);

===========================================================================================================================================
Adventure

SELECT * FROM production.product;
SELECT * FROM purchasing.vendor;