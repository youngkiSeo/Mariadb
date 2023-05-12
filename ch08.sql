-- ch08 05-12
SELECT customer_id, COUNT(1) FROM rental
GROUP BY customer_id
ORDER BY COUNT(1) DESC;


-- limit(1), limist(1,1)


SELECT customer_id, COUNT(1) 
FROM rental
group BY customer_id 
ORDER BY COUNT(1) DESC
LIMIT 1;



-- join 이용하여 사용자 이름 찍어주세요.
SELECT * FROM customer;

SELECT B.customer_id,B.first_name, B.last_name,COUNT(1)
FROM rental A
INNER JOIN customer B
ON B.customer_id = A.customer_id
GROUP BY B.customer_id 
ORDER BY COUNT(1) DESC
LIMIT 1;

-- 가장 적게 빌린 사람의 pk, 이름,빌린 수
SELECT * FROM customer;
SELECT * FROM rental;

SELECT B.customer_id , B.first_name,B.last_name,COUNT(1) AS rental_count 
FROM rental A
INNER JOIN customer B
ON B.customer_id = A.customer_id
GROUP BY B.customer_id
ORDER BY COUNT(1)
LIMIT 0,1;


SELECT customer_id, COUNT(1)
FROM rental
GROUP BY customer_id
ORDER BY 2 DESC;

-- 렌탈횟수가 40회 이상인 사람들 pk, 이름, 성 빌린수.

SELECT * FROM rental;
SELECT * FROM customer;

SELECT B.customer_id , B.first_name,B.last_name, COUNT(1)
FROM rental A
INNER JOIN customer B
ON B.customer_id = A.customer_id
GROUP BY B.customer_id
HAVING COUNT(1)> 39
ORDER BY customer_id;



-- max min avg sum count

SELECT customer_id, MAX(amount), MIN(amount), AVG(amount), SUM(amount)/COUNT(amount), SUM(amount), COUNT(amount)
FROM payment
GROUP BY customer_id;

SELECT COUNT(customer_id), COUNT(DISTINCT customer_id) FROM payment;


SELECT COUNT(1) FROM customer;

SELECT * FROM rental
WHERE return_date IS NULL;

SELECT COUNT(*), COUNT(return_date), COUNT(1)
FROM rental
WHERE return_date IS NULL;



--  DATEDIFF : 시간차이 구하기 함수 RETURN_date, rental_date 의 시간차이 구하기!
SELECT DATEDIFF(RETURN_date, rental_date) FROM rental;

-- 제일 늦게 반납한 사람.


SELECT distinct b.customer_id, b.first_name, b.last_name 
FROM rental a
INNER JOIN customer b
ON a.customer_id = b.customer_id
WHERE DATEDIFF(a.RETURN_date,a.rental_date) =
(SELECT MAX(DATEDIFF(RETURN_date, rental_date )) -- 스칼라 값
FROM rental
);

SELECT b.customer_id, b.first_name, b.last_name
FROM(
SELECT DISTINCT customer_id
FROM rental
WHERE DATEDIFF(RETURN_date, rental_date )=
	(SELECT MAX(DATEDIFF(RETURN_date, rental_date ))
FROM rental)
)A
INNER JOIN customer B
ON A.customer_id = B.customer_id
ORDER BY B.customer_id;

-- 배우의 등급별 출연횟수.
SELECT A.actor_id, B.rating , COUNT(1) cnt
FROM film_actor A
INNER JOIN film B
ON A.film_id = B.film_id
GROUP BY A.actor_id ,B.rating
ORDER BY cnt DESC;

-- 배우의 카테고리 별 출연횟수.

SELECT A.actor_id, D.first_name,D.last_name,C.name, COUNT(1) cnt
FROM film_category B
INNER JOIN category C
ON B.category_id = C.category_id
INNER JOIN film_actor A
ON A.film_id = B.film_id
INNER JOIN actor D
ON D.actor_id = A.actor_id
GROUP BY A.actor_id, C.category_id
ORDER BY cnt DESC;


-- 연도 별 렌탈 횟수 궁금쓰...
SELECT * FROM rental;

SELECT rental_id , year(rental_date),COUNT(1)
FROM rental
GROUP BY year(rental_date);


SELECT rental_id , concat(year(rental_date),'년') AS `sysysy`,COUNT(1)
FROM rental                
GROUP BY `sysysy`;

-- 롤업생성.
SELECT fa.actor_id, f.rating, COUNT(*) AS cnt
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY fa.actor_id, f.rating WITH ROLLUP ;

-- 배우의 등급('G', 'PG' 별 출연횟수 궁금함) 출현 횟수가 9 초과인 actor_id 궁금쓰

SELECT * FROM film;         
SELECT * FROM film_actor;   
SELECT * FROM actor;        
SELECT * FROM category;     
SELECT * FROM film_category;

SELECT a.actor_id, a.first_name,a.last_name,c.rating, COUNT(1) AS cnt
FROM actor a
INNER JOIN film_actor b
ON a.actor_id = b.actor_id
INNER JOIN film c
ON c.film_id = b.film_id
WHERE c.rating IN ('G', 'PG')
GROUP BY a.actor_id, c.rating
HAVING cnt>9
ORDER BY cnt;

-- 실습 8-1
SELECT * FROM payment;
SELECT COUNT(8) FROM payment;

-- 실습 8-2
SELECT * FROM customer;
SELECT * FROM payment;
SELECT a.customer_id, SUM(b.amount)
FROM customer a
INNER JOIN payment b
ON a.customer_id = b.customer_id
GROUP BY a.customer_id;


-- 실습 8-3
SELECT a.customer_id,SUM(b.amount), COUNT(1) AS cnt
FROM customer a                     
INNER JOIN payment b                
ON a.customer_id = b.customer_id    
GROUP BY a.customer_id
HAVING cnt >= 40;             