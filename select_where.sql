
-- 등급이 'G 면서 ' 빌릴수 있는 기간이 7일 이상인 레코드!
SELECT title FROM film
WHERE rating = 'G' or rental_duration >=7;

SELECT title,rating,rental_duration FROM film
WHERE (rating = 'G' and rental_duration >=7) OR (rating = 'PG-13' AND rental_duration < 4);

-- select from where group having oreder limt

-- group by 함수 : sum, avg, min, max, count
SELECT * FROM customer;

SELECT COUNT(*), SUM(active), COUNT(*)- SUM(active), MAX(address_id), MIN(address_id),Floor(AVG(address_id)) 
FROM customer;

SELECT store_id, COUNT(*)
FROM customer
WHERE active = 1
GROUP BY store_id
HAVING COUNT(*) >=300
ORDER BY store_id;

-- 3.8.1
SELECT actor_id, first_name,last_name
from actor
ORDER BY last_name,first_name;

-- 3.8.2
SELECT actor_id, first_name,last_name
from actor
WHERE last_name IN('WILLIAMS','DAVIS');

-- 3.8.3
SELECT distinct customer_id FROM rental
WHERE DATE(rental_date) = '2005-07-05'
ORDER BY customer_id;
SELECT * FROM customer;
SELECT * FROM rental;

-- 3.8.4
 SELECT c.email, r.return_date
 FROM customer c
 INNER JOIN rental r
 ON c.customer_id = r.customer_id
 WHERE DATE(r.rental_date) = '2005-06-14'
 ORDER BY return_date desc;customercustomer
 
 
 SELECT * FROM customer
 WHERE first_name = 'steven'
 and create_date > '2006-01-01';
 

 -- 생성 날짜는 2006년 1월 1일 또는 그이전!
 SELECT * FROM customer
 WHERE first_name = 'steven'
 AND create_date <='2006-01-01';
 
 -- 생성 날짜는 2006년 1월 1일 이후!
 SELECT * FROM customer
 WHERE first_name != 'steven'
 AND create_date > '2006-01-01';
 
 
 -- 이름은 steven이 아니거나 성이 'young'인 사람 중에!
 -- 생성날짜가 2006년 1월 1일 이후인 사람들!
 
 SELECT * FROM customer
 WHERE (FIRST_name != 'steven' or last_name !='young')
 AND create_date > '2006-01-01';
 
 -- 이름은 steven이 아니거나 성이 'young'이 아닌  사람 중에!
  -- 생성날짜가 2006년 1월 1일 이후인 사람들!
 SELECT * FROM customer
 WHERE (FIRST_name != 'steven' or last_name !='young')
 AND create_date > '2006-01-01';
 
 -- film_id : SASSY PACKER 인 레코드에 rental_duration 대여기간 보다 짧은 영화만 알고 싶다.
 SELECT * FROM film
 WHERE rental_duration < (SELECT rental_duration
 									FROM film
 									WHERE film_id =762) ;
 									
--  '2005-06-14' 일날 렌탄을 한 사람들의 이메일을 알고 싶다.

SELECT c.email 
FROM rental r
INNER JOIN customer c
ON c.customer_id = r.customer_id
WHERE DATE(rental_date) = '2005-06-14'
ORDER BY c.email;



-- 2004년 2005년을 제외한 렌탈정보를 알고싶다.

SELECT * FROM rental
-- WHERE YEAR(rental_date) != '2005' and YEAR(rental_date) != '2004';
WHERE YEAR(rental_date) NOT IN (2004,2005);

-- 2005-06-14 ~16 사이의 랜탈정보를 알고 싶다.

SELECT * FROM rental
-- WHERE date(rental_date) >= '2005-06-14' AND date(rental_date) <= '2005-06-16';
WHERE date(rental_date) BETWEEN  '2005-06-14' and '2005-06-16';



-- 고객 성이 'FA' 와 'FR' 사이에 속하는 사람이 알고 싶다.

SELECT * FROM customer
WHERE last_name BETWEEN 'FA' AND 'FS';

-- 영화 등급이 'G'  혹은 'PG'인 영화 정보를 알고 싶다.

SELECT * FROM film
-- WHERE rating  = 'G' or rating = 'PG' ;
WHERE rating IN ('G','PG');

-- 제목에 pet이 포함된 영화와 같은 등급을 가진 영화가 궁금하다.
SELECT title, rating
 FROM film
 WHERE rating in (SELECT distinct rating FROM film 
 WHERE title LIKE '%pet%');

-- 등급이 'pG-13', 'R', 'NC-17' 이 아닌 영화 정보를 알고 싶다.

 SELECT distinct * 
 FROM film 
 WHERE rating not IN('pG-13', 'R', 'NC-17');

 -- 문자열 함수.
 SELECT LEFT ('abcdefg',2), RIGHT('abcdefg',2), MID('abcdefg',1,3);
 
 -- 문자 함수 이용하여 고객 성이 'Q로 시작하는 사람 궁금하다'
 
 SELECT * FROM customer 
 -- WHERE last_name LIKE 'Q%';
 WHERE LEFT(last_name,1) = 'Q'; 
 
 SELECT  FROM customer 
 WHERE LEFT('Q',1);
 