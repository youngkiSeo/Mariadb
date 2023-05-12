-- ch 6 05-11


-- union 연산 A와 B의 결합, union all 중복허용.
SELECT 1 num, 1 as str
UNION all
SELECT 9 num, 'xyzaa' as str
UNION all
SELECT 1 AS num, 3 AS str;

--  고객의 이름, 성/ 배우의 이름,성 같이 띄워주세요. union 이용.

SELECT * FROM customer;
SELECT * FROM actor;

SELECT 'customer' as typ,first_name, last_name 
FROM customer
UNION
SELECT 'actor',first_name, last_name 
FROM actor
ORDER BY typ,first_name;

-- 배우, 고객 둘다 이름이(first_name) J or D로 시작하는 사람 리스트.

SELECT first_name, last_name from customer
WHERE first_name REGEXP '^[JD]'
UNION
SELECT first_name, last_name FROM actor
WHERE first_name REGEXP '^[JD]';

SELECT T.first_name, T.last_name 
FROM(
	SELECT  'customer' AS typ, first_name, last_name
	FROM customer
	union
	SELECT 'actor',first_name, last_name 
	FROM actor 
)T
 WHERE T.first_name REGEXP '^J' AND T.last_name REGEXP '^D'
 GROUP BY T.first_name, T.last_name
 HAVING COUNT(1)>1;

-- except
SELECT typ,T.first_name, T.last_name 
FROM(
	SELECT  'customer' AS typ, first_name, last_name
	FROM customer
	union
	SELECT 'actor',first_name, last_name 
	FROM actor 
)T
 WHERE T.first_name REGEXP '^J' AND T.last_name REGEXP '^D'
 GROUP BY T.first_name, T.last_name
 HAVING COUNT(1) = 1;

-- exam

CREATE TABLE except_b(
id INT UNSIGNED);

INSERT INTO except_a
(id)
VALUES
(10),(11),(12),(10),(10);

INSERT INTO except_b
(id)
VALUES
(10),(10);

-- 10, 11,12

SELECT id FROM except_a
UNION
SELECT id FROM except_b;

SELECT T.first_name, T.last_name FROM (
SELECT first_name, last_name FROM actor
UNION
SELECT first_name, last_name FROM customer) T
WHERE T.last_name REGEXP '^L'
ORDER BY last_name0;