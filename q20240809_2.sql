USE employees;

SELECT *
FROM departments;


SELECT dept_no
, LEFT(dept_no, 1) AS code, RIGHT(dept_no,3) AS num
,CONCAT (LEFT(dept_no, 1),RIGHT(dept_no,3)) AS FULL
FROM departments
;

SELECT *
FROM titles;

SELECT title, SUBSTRING(title,1,2)AS sub_title
, SUBSTRING(from_date, 1, 4) AS f_year
, SUBSTRING(to_date, 1, 4) AS t_year
FROM titles
;

DESC titles;


SELECT from_date
, substring_index(from_date, '-', 1)
, substring_index(from_date, '-', 2)
, substring_index(from_date, '-', 3)
FROM salaries
LIMIT 10
;

SELECT from_date,LOCATE('06',CONVERT(from_date, CHAR)) AS lo, POSITION('06' IN from_date) AS po
from salaries
;




#입력받아서 -> 데이터베이스에 값을 비교할때
SELECT ELT(3, '월', '화', '수', '목', '금', '토', '일');
#
SELECT FIELD('수', '화', '수', '목', '금', '토', '일','수');
#
SELECT FIND_IN_SET ('수','월,화,수,목,금,토,일,수');
#
SELECT title AS t1, LCASE(title) AS t2, LOWER(title) AS t3, UCASE(title) AS u1, UPPER(title) AS u2
FROM titles
LIMIT 100;
#

SET @str = " 빈 문자 열 ";
SELECT CONCAT('|',LTRIM(@str),'|') AS lstr, CONCAT('|',RTRIM(@str),'|') AS rstr, CONCAT('|',TRIM(@str),'|') AS tstr;
#


SELECT *
FROM employees LIMIT 10;

SELECT first_name, REPLACE(first_name,LEFT(first_name,1), 'K') AS f_name
FROM employees
;
#


SELECT first_name
	,LENGTH (first_name) AS f_len
	,CHAR_length (first_name) AS c_len
	,CHARACTER_LENGTH(first_name) AS cr_len
	,LENGTHB (first_name) AS lb_len
FROM employees
LIMIT 10
;

#한글
SELECT '조수진' AS 'name'
	,LENGTH ('조수진') AS f_len
	,CHAR_length ('조수진') AS c_len
	#CHAR_length 사용 추천
	,CHARACTER_LENGTH('조수진') AS cr_len
	,LENGTHB ('조수진') AS lb_len
;


#
SELECT CONCAT ('문자1','문자2') AS con
;
SELECT CONCAT_WS('|','Maria','DB','DB') AS con
;

SELECT CAST(from_date AS CHAR(4)), CONVERT(from_date, CHAR(4))
FROM salaries
LIMIT 100;

#
SELECT first_name, last_name
	,CONCAT_WS('@',first_name,'naver.com') AS email
FROM employees
LIMIT 100
;

#

SELECT repeat('*',20);
SELECT REVERSE(first_name) AS rf
FROM employees
LIMIT 100
;

#


SELECT FORMAT(1234567.6789,2,'ko_KR');

#

SELECT ASCII('a'),CHR(65),CHR(97);

#
SELECT HEX('AB'), UNHEX('4142');

SELECT NOW(), to_char(NOW(),'YYYY-MM-DD'), to_char(NOW(),'yyyy'), to_char(NOW(),'mm');

SELECT *
FROM employees
WHERE hire_date <= NOW()
LIMIT 100;


SELECT *
FROM employees
WHERE hire_date BETWEEN '2000-01-01' AND '2020-12-31'
ORDER BY hire_date;
#
SELECT NOW(), ADDDATE(NOW(),30) AS d1, to_char(NOW(), 'YYYY-MM-DD');
SELECT ADDDATE('2024-03-01', -1) AS dy;
#

SELECT SUBDATE(NOW(),30) AS sd, date_sub(NOW(),INTERVAL 30 DAY) AS ds
		,ADDDATE(NOW(),30) AS ad, ADDDATE(NOW(),-30) AS d2;
	
	
SELECT NOW(), CURDATE(), CURRENT_DATE(), CURTIME(), CURRENT_TIME();
SELECT NOW(), CURRENT_TIMESTAMP(), SYSDATE(), LOCALTIME(), LOCALTIMESTAMP();

SELECT to_char(NOW(),'HH24'),to_char(NOW(),'SS'),HOUR(NOW()),MINUTE(NOW()),SECOND(NOW());

#
use mysql

SHOW VARIABLES LIKE 'c%'

SELECT @@GLOBAL.time_zone, @@SESSION.time_zone;

SHOW VARIABLES LIKE '%TIME%';

USE employees;

SELECT DATE(NOW()), TIME(NOW());

SELECT DATEDIFF(NOW(), '2024-02-01'), TIMEDIFF(NOW(), '2024-02-31 00:00:00');

SELECT LAST_DAY('2024-02-01') AS '2024'
		,LAST_DAY('2025-02-01') AS '2025'
		,LAST_DAY('2026-02-01') AS '2026'
		

SELECT DATE_FORMAT(NOW(),'%Y-%m-%d','ko_KR');

#
use employees

SELECT *
FROM salaries
LIMIT 100
;

SELECT COUNT(salary) AS cnt
		, AVG(salary) AS AVG1
		, CEIL(AVG(salary)) AS c1
		, FLOOR(AVG(salary)) AS f1
		,truncate(AVG(salary),3) AS t1
		,ROUND(AVG(salary),1) AS a1
FROM salaries
WHERE from_date BETWEEN '2020-01-01' AND '2020-07-31'
#
#select count(YEAR(from_date)),YEAR(from_date)
#FROM salaries
#GROUP BY YEAR(from_date);


SELECT CONVERT((131/10), INT) AS c1, CONVERT(CEIL(131/10),INT) AS c2;
#

employeesbooksSELECT MIN(salary) AS m1, MAX(salary) AS M2
FROM salaries


#

USE books;