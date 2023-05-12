-- chapter7 05-11

 CREATE TABLE string_tb1 (
 CHAR_fld CHAR(30),
 vchar_fld varCHAR(30),
 text_fld text
 );
 
 INSERT INTO string_tb1
 (char_fld, vchar_fld, text_fld)
 values
 (
 	'This is char data',
 	'This is varchar data',
 	'This is text data'
 );
 -- 작은 따음표 사용 Quote
 SELECT *, QUOTE (text_fld) FROM string_tb1; 
 SELECT * FROM string_tb1;
 
 UPDATE STRING_tb1
 SET vchar_fld = 'this is a piece of extremely long varchar data';
  UPDATE STRING_tb1
 SET text_fld = 'This s\'tring didn\'t WORK, but it does now';
 
 SELECT @@SESSION.sql_mode;
 
 SET sql_mode = 'strict';
 
 SHOW WARNINGS;
  --문자열 합치기 CONCAT
 SELECT lname, fname, CONCAT(lname,' ',fname)
 FROM person;
 
 SELECT lname,char_LENGTH(lname)
 FROM person; 
 UPDATE person
 SET lname = 'Turner'
 ;
 
 -- 문자열 찾기. 
 SELECT lname, POSITION('터너' IN lname)
 FROM person
 POSITION 
 ;

SELECT * FROM string_tb1;
SELECT TEXT_fld, POSITION('n' IN text_fld), LOCATE('n', text_fld, 12) -- 12번째 부터 찾겠다.
FROM string_tb1;
SELECT '안녕' = '안녕', 'abc' = 'ABC', 'abc' = 'cba', STRCMP('abc', 'ABC');

SELECT NAME, name LIKE '%y',
NAME REGEXP '^[C]'
FROM category;


-- mysql에서는 사용불가능 연결연산자.
SELECT first_name || ' ' || last_name
FROM customer;

-- replace BA를 DA로 바꾸겠다!!
SELECT first_name, REPLACE(first_name, 'BA', 'DA')FROM customer;

-- 성에서 PH > TH 로 바꾸고 NI 는 NA 로바꿔라!
SELECT customer_id , first_name, REPLACE(REPLACE(first_name,'NI','NA'), 'PH','TH' ) FROM customer;

SELECT 'goodbyeworld', INSERT('goodbye world',9,0,'cruel ')
, INSERT('goodbye 1234 1234 world',POSITION('world' IN 'goodbye 1234 1234 world'),CHAR_LENGTH('world'),'cls')
;

-- 영화 제목 빈칸에 nice 추가해주세요.
SELECT * FROM film;
SELECT title , INSERT(title,POSITION(' 'IN title),0, ' nice ')FROM film;

SELECT title, REPLACE(title, ' ',' nice ' ) FROM film;

SELECT email, SUBSTRING(email,3),SUBSTRING(email,3,6),substr(email,3,6)
 FROM customer;
 
-- 사용자 이메일 쪼개서 출력 @기준으로.
SELECT email, 
SUBSTRING(email, 1,POSITION( '@' IN email)-1) AS email_1, 
SUBSTRING(email,POSITION( '@' IN email)+1) AS email_2,
LEFT(email,POSITION( '@' IN email)-1),
RIGHT(email, CHA0R_LENGTH(email) - POSITION( '@' IN email) )
FROM customer;

SELECT * FROM customer;

SELECT (38*59) / (78- (8*6));

SELECT MOD(10,7);

-- TRUNCATE: 실수 자르기 ABS: 양수값 만들기.
SELECT TRUNCATE(1123.3456,2), ABS(-10), ABS(10);


SELECT NOW(), CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

-- 형변환 CAST CONVERT
SELECT CAST('2019/05/11 16:46:30' AS DATETIME),
CONVERT ('2019-05-11 16:46:30', DATETIME);

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5000 DAY),
DATE_ADD(NOW(), INTERVAL '03:27:11' HOUR_SECOND);

SELECT * FROM employees
WHERE emp_no = 10001;

UPDATE employees
SET birth_date = DATE_ADD(birth_date, INTERVAL '2-1' YEAR_MONTH)
WHERE emp_no = 10001;

 SELECT 
 CURDATE(), 
 SYSDATE(),
 WEEKDAY(NOW())    -- 월(0) 화(1) 수(2) 목(3) 금(4) 토(5) 일(6)
 ,DAYNAME(NOW()),
 LAST_DAY(NOW()) -- 그 달의 마지막일.
 ,LAST_DAY('2023-06-11'),
 DATE_SUB(NOW(), INTERVAL '2' YEAR),
 EXTRACT(DAY FROM NOW()),
 DATEDIFF('2019-09-03' , '2019-06-21');

 -- 실습 7-1

 SELECT 
 SUBSTRING('Please find the substring in this string',17,9);
SELECT MID('Please find the substring in this string',17,9);

 -- 실습 7-2 반올림 해서 25.768
 SELECT ABS(-25.76823) ,sign(-25.76823) ,TRUNCATE(-25.76823,3),round(-25.76823,3);
 
 -- 실습 7-3
 select MONTH(NOW()), EXTRACT(MONTH FROM CURRENT_TIMESTAMP());
 
 