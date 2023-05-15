-- 5/15

-- 가장 나중에 가입한 고객의 pk, 이름, 성을 출력하시오.

-- 비상관 서브쿼리.
SELECT customer_id, first_name,last_name,create_date FROM customer
WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

-- 도시id 도시명 > india (인도) 나라가 아닌 나라들의 도시 id와 

SELECT city_id, city FROM city
WHERE country_id != (SELECT country_id FROM country WHERE country = 'india');

-- Canada, Mexico 도시 id, 도시명을 출력.
SELECT city_id, city FROM city
WHERE country_id in (SELECT country_id FROM country WHERE country IN('Canada','Mexico'));

-- all 연산자.
SELECT * FROM customer 
WHERE customer_id != ALL (SELECT customer_id FROM payment WHERE amount = 0);


-- United States, Maxico, Canada 에 거주하는 소비자의 렌탈횟수보다 많이 렌탈한 사람들의 고객id. 횟수 
SELECT * FROM view_test1;
DROP VIEW view_test1;
CREATE VIEW VIEW_test1 AS
SELECT customer_id, COUNT(customer_id) 
FROM rental 
GROUP BY customer_id
HAVING COUNT(customer_id) > ALL(

	 SELECT COUNT(customer_id) FROM rental WHERE customer_id  IN
		(SELECT customer_id FROM customer WHERE address_id IN
		(SELECT address_id FROM address where city_id in
			(SELECT city_id FROM city where country_id IN (
				SELECT country_id FROM country WHERE country IN ('United States', 'Mexico', 'Canada')))))
				GROUP BY customer_id);
-- 배우 성이 'MonROE' 인 사람이 PG 영화 등급에 출연했다, 배우 id, 영화 id가 궁금하다.
SELECT  A.actor_id,A.first_name,A.last_name,C.film_id
FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id 
INNER JOIN film C
ON B.film_id = C.film_id
WHERE last_name = 'MonROE' AND
C.rating = 'PG';

-- 다중 열 서브쿼리.
SELECT * FROM actor
WHERE (first_name, last_name) IN
		(
			SELECT FIRST_name, last_name
			FROM actor
			WHERE last_name = 'MONROE'
			
			);
	-- case 문. -- if(){} -> case   when(조건식) end
SELECT customer_id,active,
	CASE when active = 1
		then '활성화'
		ELSE '비활성화'
	END active_str
	, if(active = 1, '활성화','비활성화') active_str2
	FROM customer;


-- PG, G 전체 이용, NC-17 청소년 이상,PG-13 13세 이상 R은 청소년이용불가.
SELECT rating,title, case 
when rating in ('PG','G') then '전체이용'
when rating = 'NC-17' then '17세이상'
when rating = 'PG-13' then '13세이상'
ELSE '청소년 이용 불가'	
END rating_str
FROM film;

-- first_name | last_name | num_rentals(active = 0 > 0)

SELECT * FROM rental;
SELECT * FROM rental;
SELECT * FROM customer;

SELECT customer_id, COUNT(rental_id) FROM rental group BY customer_id;

SELECT A.customer_id,A.first_name,A.last_name, 
case when active = 1 then COUNT(B.customer_id)
 when active = 0 then '0'
END num_rentals, A.active
FROM customer A
INNER JOIN rental B
ON A.customer_id = B.customer_id
GROUP BY A.customer_id;

SELECT customer_id,first_name,last_name,active,
case when active = 0 then '0'
ELSE(SELECT COUNT(1) 	
	FROM rental B 
	WHERE A.customer_id = B.customer_id)
 END num_rentals 
 FROM customer A;
 
 
 -- rental 테이블에서  2005-05,~ 2005-08 월 까지 각 달의 rental 수 출력.
 
 SELECT * FROM rental;
 SELECT date(rental_date) FROM rental
 WHERE date(rental_date) BETWEEN '2005-05-01' AND '2005-09-01';

   
   SELECT  DATE_FORMAT(rental_date, '%Y-%m')mon, COUNT(rental_date) cnt
   FROM rental
   WHERE DATE_FORMAT(rental_date, '%Y-%m') BETWEEN '2005-05' AND '2005-07'
   GROUP BY mon;
   
   
	
SELECT 
SUM(
	case  DATE_FORMAT(rental_date, '%Y-%m') when '2005-05' then 1 ELSE 0 end
) may_rentals

,SUM(
	case  DATE_FORMAT(rental_date, '%Y-%m') when '2005-06' then 1 ELSE 0 end
) june_rentals

,SUM(
	case  DATE_FORMAT(rental_date, '%Y-%m') when '2005-07' then 1 ELSE 0 end
) july_rentals

FROM  rental
WHERE DATE_FORMAT(rental_date, '%Y-%m') BETWEEN '2005-05' AND '2005-07';

-- 트랜잭션 ctrl + z  여러가지의 업무를 하나의 업무로 본다.
-- 그 업무들이 문제가 없으면 commit, 그 업무들이 하나의 문제라도 있으면 롤백


