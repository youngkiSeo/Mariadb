-- Data definition Language

CREATE TABLE t_test(
	id BIGINT UNSIGNED AUTO_INCREMENT,
	nm VARCHAR(100) NOT NULL,
	jumin CHAR(9) NOT NULL,
	age INT NOT NULL,
	addr VARCHAR(200),
	created_at DATETIME DEFAULT NOW(), --현재시간을 나타내는 함수!
	PRIMARY KEY(id)
);


DROP TABLE t_test;
-- Data Manipulation Lanuage
INSERT INTO t_test
(nm, jumin, age, addr)
VALUE
('홍길동', '90121121',95,'대구시중구');
SELECT * FROM t_test
WHERE age =25 AND age =27;