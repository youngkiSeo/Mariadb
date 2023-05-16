
-- 정규화.

ALTER TABLE t_deal MODIFY price INT NOT NULL DEFAULT 0;
CREATE TABLE t_deal (
	id INT UNSIGNED AUTO_INCREMENT,
	deal_date DATE NOT NULL,
	price INT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (id)	
);

INSERT INTO t_deal
(deal_date)
VALUES
('2023-10-20'),
('2023-10-20'),
('2023-10-22');

UPDATE t_deal A
INNER JOIN (
	SELECT deal_id, SUM(A.quantity * C.price) total_price
	FROM t_deal_sub A
	INNER JOIN t_parts C
	ON A.parts_id = C.id
	GROUP BY deal_id
) B
ON A.id = B.deal_id
SET A.price = B.total_price;

SELECT * FROM t_deal;

DROP TABLE t_deal_sub;
CREATE TABLE t_deal_sub(
	deal_id INT UNSIGNED,
	seq INT UNSIGNED,
	provider_cd CHAR(1) NOT null,
	parts_id INT UNSIGNED NOT null,
	quantity	INT UNSIGNED NOT NULL,
	PRIMARY KEY (deal_id,seq),
	FOREIGN KEY (deal_id) REFERENCES t_deal(id),
	FOREIGN KEY (provider_cd) REFERENCES t_provider(cd),
	FOREIGN KEY (parts_id) REFERENCES t_parts(id)
);

INSERT INTO t_deal_sub
(deal_id,seq,provider_cd,parts_id,quantity)
VALUES
(1,1,'A',1,10),
(1,2,'B',3,10),
(1,3,'C',2,10),
(2,1,'A',1,20),
(2,2,'B',3,10),
(3,1,'A',3,30),
(3,2,'C',2,5);
SELECT * FROM t_deal_sub;

CREATE TABLE t_provider(
	cd CHAR(1) PRIMARY KEY,
	nm VARCHAR(10)NOT NULL
);

INSERT INTO t_provider
(cd,nm)
VALUES
('A','알파')
('B','브라보')
('C','찰리');
SELECT * FROM t_provider;

CREATE TABLE t_parts(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nm VARCHAR(10) NOT NULL,
	price INT UNSIGNED NOT null
);

INSERT INTO t_parts
(nm,price)
VALUES
('마우스',10000);
INSERT INTO t_parts
(nm,price)
VALUES
('키보드',30000);


SELECT * FROM t_provider;
SELECT * FROM t_deal_sub;
SELECT * FROM t_deal;
SELECT * FROM t_parts;

SELECT  A.deal_id '전표번호', DATE_FORMAT(B.deal_date,'%m/%d') '날짜',A.provider_cd AS '공급자',C.nm AS '공급자명', D.nm AS '부품명',
D.price AS '단가', A.quantity AS '수량',SUM( D.price * A.quantity) AS '금액'
FROM t_deal_sub A
INNER JOIN t_deal B
ON A.deal_id = B.id
INNER JOIN t_provider C
ON A.provider_cd = C.cd
INNER JOIN t_parts D
ON A.parts_id = D.id
GROUP BY deal_id ,deal_date,provider_cd;
	-- 
