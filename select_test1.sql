SELECT NAME AS '이름', 
'common' AS language_usage,
floor(language_id * 3.1415927) AS lang_pi_value ,
UPPER(name)AS language_name,
NAME + 'man' AS another_name,
CONCAT(NAME,'man') AS another_name

FROM language;

SELECT distinct actor_id 
FROM film_actor 
ORDER BY actor_id DESC;

SELECT 
CONCAT (cust.first_name,' ' ,cust.last_name) AS full_name
FROM(
	SELECT first_name, last_name, email
	FROM customer
	WHERE first_name = 'Jessie') 
AS cust;

SELECT A.rental_id, A.rental_date, 
	ifnull(A.return_date, '반납안했음') AS return_date
	,B.first_name, B.last_name

 FROM rental as A
 	INNER JOIN customer as B
 	ON A.customer_id = B.customer_id
 	WHERE return_date IS null
 	ORDER BY rental_date DESC;
 	
DESC rental; -- 테이블을 설명할때, 안쓴다!

--ifull column의 값이 NULL을 반환할 때, 다른 값으로 출력할 수 있도록 하는 함수
 

 SELECT B.customer_id, B.first_name, B.last_name
  FROM customer B;
  
  SELECT * FROM film_actor
ORDER BY actor_id DESC, film_id ASC;

-- rental 테이블, staff_id = 1인 사람이 거래한 정보만 보고싶다

SELECT rental_id,rental_date, RETURN_date, customer_id 
FROM rental
WHERE staff_id = 1
ORDER BY rental_id DESC;