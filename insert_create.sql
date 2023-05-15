CREATE DATABASE exam;
DROP TABLE person;
DESC person;
CREATE TABLE person(
	person_id INT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color CHAR(2) CHECK(eye_color IN ('Br','BL','GR')),
	birth_date DATE,
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(20),
	country varchar(20),
	postal_code VARCHAR(20),
	PRIMARY KEY (person_id)
);
DROP TABLE favorite_food;
CREATE TABLEfavorite_food favorite_food(
	person_id INT UNSIGNED,
	food VARCHAR(20),
	PRIMARY KEY(person_id, food),
	FOREIGN KEY(person_id) REFERENCES person(person_id)
);

INSERT INTO person 
( person_id, fname, lname, birth_date, eye_color 
)
VALUES(
	1,'william', 'Turner', '1972-05-27', 'BR');

INSERT INTO person
SET person_id = 2,
fname = '길동',
lname = '홍',
birth_date='1990-05-27',
eye_color='GR';

INSERT INTO person
SET person_id = 3,
fname = '관순',
lname = '유',
birth_date='1985-07-27',
eye_color='BR';

	INSERT INTO favorite_food
	(person_id, food)
	values
	(1,'pizza'),
	(1,'cookies'),
	(1,'nachos');
	
SELECT * FROM favorite_food;
SELECT * FROM person;
SELECT person_id, fname, lname, birth_date, eye_color  FROM person;


UPDATE person
SET fname = '윌리엄'
,lname = '터너'
,country='대한민국'
WHERE person_id = 1;

UPDATE personsakila
SET birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
,lname = '터너'
,country='대한민국'
WHERE person_id = 1;

SELECT str_to_date('DEC-21-1980', '%b-%d-%Y');

DELETE FROM favorite_food;
TRUNCATE favorite_food;

SELECT * FROM person;