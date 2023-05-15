-- 트랜잭션.

SET autocommit = 0;

INSERT INTO person
(person_id, fname, lname,birth_date,eye_color)
VALUES
(4,'테스트','김','2023-05-15','BR');

SELECT * FROM person;
ROLLBACK;
COMMIT;

-- 뷰d.

