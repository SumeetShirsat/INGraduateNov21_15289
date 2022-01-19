SECTION 25

BEGIN TRANSACTION;
	UPDATE products
	SET reorderlevel = reorderlevel - 5;

	SELECT COUNT(*)
	FROM products
	WHERE unitsinstock + unitsonorder < reorderlevel;

END TRANSACTION;


BEGIN TRANSACTION;
	UPDATE orders
	SET requireddate = requireddate + INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-12-01' AND '1997-12-31';

	UPDATE orders
	SET requireddate = requireddate - INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-11-01' AND '1997-11-30';

END TRANSACTION;


START TRANSACTION;
	INSERT INTO employees (employeeid,firstname,lastname,title,birthdate,hiredate)
	VALUES(501,'Sue','Jones','Opearation Assistant','1997-05-21','2017-06-13');
	
	SAVEPOINT inserted_employee;
	
	UPDATE employees
	SET birthdate='2025-06-17';
	
	ROLLBACK TO inserted_employee;
	
	UPDATE employees
	SET birthdate='1997-10-14'
	WHERE employeeid=501;
	

	
COMMIT;
	END TRANSACTION;
================================================

SECTION 26

DROP TABLE IF EXISTS friends

CREATE TABLE friends(
name full_name,
	address address,
	specialdates dates_to_remember,
	children varchar(50) ARRAY
)

CREATE TABLE salary_employees(
	name text,
	pay_by_quarter int[4],
	schedule text[][]
)

INSERT INTO friends(name,address,specialdates,children)
VALUES(ROW('Gregory','L','Lloyd'),
	  ROW('7777','','Boise','Idaho','USA','7777'),
	   ROW('1997-10-14',14,'1997-12-10'),
	   ARRAY['Surja','Urmeet']
	  );

INSERT INTO salary_employees(name,pay_by_quarter,schedule)
VALUES('Bill',
	  ARRAY[2000,2000,2000,2000],
	  ARRAY[['meeting','training'],['lunch','salescall']]
	  )

SELECT children[2] FROM friends;

SELECT pay_by_quarter[2:3] FROM salary_employees;

SELECT array_dims(schedule) FROM salary_employees;
SELECT array_length(schedule,1),array_length(schedule,2) FROM salary_employees;

UPDATE friends
SET children=ARRAY['Madie','Sharly','Nik']
WHERE (name).first_name='Gregory';


UPDATE friends
SET children[2]='Ricky'
WHERE (name).first_name='Gregory';

SELECT children FROM friends WHERE (name).first_name='Gregory';

UPDATE friends
SET children[2:3]=ARRAY['Suzy','Billy']
WHERE (name).first_name='Gregory';
	
	
UPDATE salary_employees
SET pay_by_quarter=ARRAY[22000,25000,27000,22000]
WHERE name='Bill';

SELECT pay_by_quarter
FROM salary_employees
WHERE name='Bill';

UPDATE salary_employees
SET pay_by_quarter[4]=26000
WHERE name='Bill';

SELECT pay_by_quarter
FROM salary_employees
WHERE name='Bill';

UPDATE salary_employees
SET pay_by_quarter[2:3]=ARRAY[24000,25000]
WHERE name='Bill';

SELECT pay_by_quarter
FROM salary_employees
WHERE name='Bill';	

SELECT *
FROM friends
WHERE children[0] = 'Billy' OR children[1] = 'Billy'
OR children[2]='Billy' OR children[3]='Billy';

SELECT *
FROM friends
WHERE 'Austin' = ANY (children)

SELECT *
FROM salary_employees
WHERE 'sales call' = ANY (schedule);
	
----------

-- equal
SELECT ARRAY[1, 2, 3, 4] = ARRAY[1, 2, 3, 4];

-- not equal, the elements are not in same order
SELECT ARRAY[1, 2, 4, 3] = ARRAY[1, 2, 3, 4];

-- true
SELECT ARRAY[1, 2, 4, 3] > ARRAY[1, 2, 3, 4];

-- false
SELECT ARRAY[1, 2, 3, 4] > ARRAY[1, 2, 3, 4];

-- false 3 smaller than 4, doesn't look at 5 greater than 4
SELECT ARRAY[1, 2, 3, 5] > ARRAY[1, 2, 4, 4];

-- true
SELECT ARRAY[1, 2, 3, 5] @> ARRAY[2, 5];

-- false
SELECT ARRAY[1, 2, 3, 5] @> ARRAY[2, 5, 7];

-- true
SELECT ARRAY[1, 2] <@ ARRAY[2, 5, 7, 1];

-- true
SELECT ARRAY[1, 2, 13, 17] && ARRAY[2, 5, 7, 1];

--false
SELECT ARRAY[ 13, 17] && ARRAY[2, 5, 7, 1];

SELECT *
FROM friends
WHERE children && ARRAY['Billy'::varchar(50)];

SELECT *
FROM salary_employees
WHERE schedule && ARRAY['sales call'];

	
	
	
