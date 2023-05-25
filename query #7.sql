
SELECT * from t_board
LIMIT 0,30;
DROP table t_board_cmt;
CREATE table t_board_cmt (
	icmt INT UNSIGNED AUTO_INCREMENT PRIMARY key,
	iboard INT UNSIGNED NOT null,
	ctnt VARCHAR(300) NOT null,
	writer VARCHAR(10) NOT NULL,
	pw VARCHAR(10) NOT NULL
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY(iboard) REFERENCES t_board(iboard)

);
SELECT * 
FROM t_board
ORDER BY iboard DESC;

/*
	pk
	파일경로
	업로더.
	중요도.
*/
CREATE TABLE t_file(
	ifile INT UNSIGNED AUTO_INCREMENT,
	path VARCHAR(200) NOT NULL,
	uploader VARCHAR(10) NOT NULL,
	levelvalue INT UNSIGNED NOT NULL,
	PRIMARY KEY (ifile)
);
DROP TABLE t_file;
SELECT * FROM t_file;