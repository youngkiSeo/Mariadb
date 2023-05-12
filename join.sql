-- 05/10

SELECT last_name,first_name
FROM customer
WHERE last_name LIKE '_A_T%S';
-- _AT%S 1번째 자리는 아무거나 와도 되지만 2번째 A  4번째는 T 
-- %길이 상관없고 마지막은 S마지막은 S

-- 고객 중에  이메일 값이 네번째에 .이 있고 13번째가 @인사람.
SELECT * FROM customer;
SELECT last_name, first_name, email
from customer
WHERE email LIKE '____._______@%';

-- 이메일이 Q와 Y로 시작하는 사람을 뽑아내고 싶다/  REGEXP 정규식사용.
SELECT * FROM customer;
SELECT last_name, first_name, email
from customer
-- WHERE LEFT(last_name, 1) = 'Q' OR last_name LIKE 'Y%';
WHERE last_name REGEXP '^[LY]'; -- QY로 시작하는 성을 찾고싶다. ^이 시작값 찾기

SELECT * FROM customer
WHERE last_name REGEXP '[LY]$'; -- ly로 $가 끝값 찾기

SELECT * FROM customer
WHERE email REGEXP '^rosa';

SELECT * FROM rental;
WHERE return_date IS not NULL;

-- 반납일이  2005년 5월 1일 ~ 2005-09-01 이 아닌 렌탄 정보 알고싶다.

SELECT * FROM rental
WHERE date(return_date) NOT BETWEEN '2005-05-24'  and '2005-08-31' 
OR return_date IS NULL;

-- 4-1

SELECT * FROM payment
WHERE payment_id between 101 AND 120
AND customer_id <> 5 AND (amount > 8 OR DATE(payment_date) = '2005-08-23');

SELECT * FROM payment
WHERE payment_id between 101 AND 120
AND customer_id = 5 AND NOT (amount > 6 OR DATE(payment_date) = '2005-06-19');

SELECT * FROM payment
WHERE amount IN(1.98,7.98,9.98);

SELECT * FROM customer
WHERE last_name LIKE '_A%W%';


-- 다중 쿼리.
SELECT * FROM person;
sELECT * FROM favorite_food;

SELECT A.food, A.person_id, B.person_id, B.fname, B.lname
FROM favorite_food A
INNER JOIN person B
ON A.person_id = B.person_id;

SELECT * 
FROM person A -- A가 기준.
LEFT JOIN favorite_food B
ON A.person_id = B.person_id;

-- 고객id, 이름,성,address, district 값이 나오는 쿼리문 완성.

SELECT * FROM customer;
SELECT * FROM address;

SELECT c.customer_id, c.first_name, c.last_name,a.address_id, a.address, a.district
FROM customer c
LEFT JOIN address a
ON c.address_id = a.address_id;


-- 고객 id , 이름, 성, 도시명 나오는 뭐리문 작성.
SELECT * from address;
SELECT * FROM customer;
SELECT * FROM city;
SELECT c.customer_id, c.first_name, c.last_name,ci.city AS city_name
FROM customer c
LEFT JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id;

-- adress 'California' 값만 알고 있다 미국 주중에 Californina에 사는 소비자의 정보를 알고 싶다.
SELECT  * FROM customer
WHERE address_id in(SELECT address_id
FROM address
WHERE district = 'California'); 

SELECT * FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id
WHERE B.district='California';

SELECT  * FROM customer A -- 서브쿼리(column 값은 Scala값.
INNER join(SELECT address_id
FROM address
WHERE district = 'California'
) B
ON A.address_id = B.address_id;

-- 배우 이름이 Cate MCQueen, CUBA BIRCH

SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT  DISTINCT f.film_id, f.title 
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor ai
ON fa.actor_id = ai.actor_id
WHERE (ai.first_name,ai.last_name) IN (('Cate','MCQueen'), ('CUBA','BIRCH'))
GROUP BY f.film_id
HAVING COUNT(*) = 2;

SELECT f.film_id, f.title 
FROM film f
INNER JOIN (
	SELECT  B.film_id FROM  actor A
	INNER JOIN film_actor B
	ON A.actor_id = B.actor_id
	WHERE (A.first_name,A.last_name) IN (('Cate','MCQueen'), ('CUBA','BIRCH'))
	GROUP BY B.film_id
	HAVING COUNT(*) = 2
) S
ON S.film_id = F.film_id;


film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor ai
ON fa.actor_id = ai.actor_id
WHERE (ai.first_name,ai.last_name) IN (('Cate','MCQueen') ('CUBA','BIRCH'));

-- 실습 5-1
SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';

-- 실습 5-2 john 이라는 이름의 배우가 출연한 모든 영화의 제목

SELECT f.title
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor ac
ON fa.actor_id = ac.actor_id
WHERE ac.first_name= 'John';

-- 실습 5-3

SELECT a1.address addr1, a2.address addr2, a1.city_id, a2.city_id
FROM address a1
INNER JOIN address a2
ON a1.city_id  = a2.city_id
WHERE a1.address_id <> a2.address_id;

SELECT * FROM address
WHERE city_id IN (
SELECT city_id FROM address
GROUP BY city_id
HAVING COUNT(*) > 1);


