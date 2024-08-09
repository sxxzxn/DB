CREATE TABLE tbl_test(
	`idx` INT NOT NULL AUTO_INCREMENT COMMENT'인덱스',
	`title_no` VARCHAR(10) NOT NULL COMMENT'글번호',
	`title` VARCHAR(100) NULL DEFAULT NULL COMMENT'글제목' COLLATE'utf8mb4_general_ci',
	PRIMARY KEY(`title_no`) USING BTREE,
	INDEX `idx` (`idx`) using btree
)

COMMENT='테스트테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB
;

DESC tbl_test;

#데이터 등록
INSERT INTO테이블명(컬럼명1, 컬럼명2,,,)
VALUE(값1, 값2, ,,,);

#데이터조회
SELECT 컬럼1, 컬럼2,,,, 
FROM 테이블명
SELECT *
FROM 테이블명
WHERE 컬럼1<10
LIMIT 0,10
/*
데이터값 넣어준거

INSERT INTO tbl_goods_info( goods_code, goods_name, unit_code, unit_price, goods_status, reg_date )
VALUES
('PN0001', '연필', '01', 1000, 'Y', '2024-07-01 00:00:00')
, ('PN0002', '샤프', '02', 2000, 'Y', '2024-07-02 00:00:00')
, ('ER0001', '지우개', '03', 3000, 'Y', '2024-07-03 00:00:00')
, ('PN0003', '볼펜', '04', 4000, 'Y', '2024-07-04 00:00:00')
, ('NT0001', '무지노트', '05', 1000, 'Y', '2024-07-05 00:00:00')
, ('NT0002', '연습장', '06', 1500, 'Y', '2024-07-06 00:00:00')
, ('PN0004', '볼펜심', '07', 500, 'Y', '2024-07-07 00:00:00')
, ('ER0002', '수정액', '08', 2500, 'Y', '2024-07-08 00:00:00')
;
SELECT * FROM tbl_goods_info;



INSERT INTO tbl_order_detail_info
( order_no, goods_code, unit_code, unit_price, order_cnt, order_amount, reg_date)
VALUEStbl_goods_info
	( '202408010001', 'PN0001', '01', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -7 DAY) )
	, ( '202408010001', 'PN0002', '02', 2000, 1, 2000, DATE_ADD(NOW(), INTERVAL -6 DAY) )
	, ( '202408010001', 'PN0003', '04', 4000, 1, 4000, DATE_ADD(NOW(), INTERVAL -6 DAY) )
	, ( '202408010002', 'PN0001', '01', 1000, 2, 2000, DATE_ADD(NOW(), INTERVAL -5 DAY) )
	, ( '202408020001', 'ER0001', '03', 3000, 2, 6000, DATE_ADD(NOW(), INTERVAL -4 DAY) )
	, ( '202408020002', 'NT0002', '06', 1500, 1, 1500, DATE_ADD(NOW(), INTERVAL -4 DAY) )
	, ( '202408020003', 'PN0004', '07', 500, 2, 1000, DATE_ADD(NOW(), INTERVAL -3 DAY) )
	, ( '202408020003', 'ER0002', '08', 2500, 1, 2500, DATE_ADD(NOW(), INTERVAL -3 DAY) )
	, ( '202408040001', 'NT0001', '05', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'PN0002', '02', 2000, 1, 2000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'ER0001', '03', 3000, 1, 3000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'PN0003', '04', 4000, 1, 4000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'NT0002', '06', 1500, 1, 1500, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050002', 'PN0001', '01', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050002', 'ER0002', '08', 2500, 2, 5000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408060001', 'PN0001', '01', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	, ( '202408060001', 'PN0002', '02', 2000, 2, 4000, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	, ( '202408060001', 'PN0003', '04', 4000, 2, 8000, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	, ( '202408070001', 'NT0002', '06', 1500, 1, 1500, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	;
*/
/*
DELETE FROM tbl_order_detail_info;
DELETE FROM tbl_order_info;
DELETE FROM tbl_goods_info;
DELETE FROM tbl_member;
tbl_goods_infotbl_goods_infotbl_goods_info
*/
/*
INSERT INTO tbl_member ( user_id, user_name, pwd ) VALUES ( 'user1', '홍길동', '1234' );
INSERT INTO tbl_member (
	`user_id`, `user_name`, `pwd`, `ssn`, `birth_date`
	, `addr1`, `addr2`, `zip_code`
	, `job_code`, `mileage`, `status`, `reg_date`, `leave_date`, `auto_login` )
VALUES (
	'user2', '홍길동2', '1234', '123456-1234567', '20240807'
	, '서울시 강남구 논현동', '37번길(레미안)', '12345', '', 0, 'P', NOW(), null, 'Y' );
INSERT INTO tbl_member (
	`user_id`, `user_name`, `pwd`, `ssn`, `birth_date`
	, `addr1`, `addr2`, `zip_code`
	, `job_code`, `mileage`, `status`, `reg_date`, `leave_date`, `auto_login` )
VALUES (
	'user3', '홍길순', '1234', '234567-3456789', '20240707'
	, '서울시 강서구 논현동', '17번길(자이)', '123-456', '', 0, 'Y', NOW(), null, 'Y' );
	*/

/*
INSERT INTO tbl_goods_info( goods_code, goods_name, unit_code, unit_price, goods_status, reg_date )
VALUES
('PN0001', '연필', '01', 1000, 'Y', '2024-07-01 00:00:00')
, ('PN0002', '샤프', '02', 2000, 'Y', '2024-07-02 00:00:00')
, ('ER0001', '지우개', '03', 3000, 'Y', '2024-07-03 00:00:00')
, ('PN0003', '볼펜', '04', 4000, 'Y', '2024-07-04 00:00:00')
, ('NT0001', '무지노트', '05', 1000, 'Y', '2024-07-05 00:00:00')
, ('NT0002', '연습장', '06', 1500, 'Y', '2024-07-06 00:00:00')
, ('PN0004', '볼펜심', '07', 500, 'Y', '2024-07-07 00:00:00')
, ('ER0002', '수정액', '08', 2500, 'Y', '2024-07-08 00:00:00')
;
*/
/*
INSERT INTO tbl_order_info (order_no, user_id, order_date, order_amount, reg_date)
VALUES ( '202408010001', 'user1', '20240801', 3, DATE_ADD(NOW(), INTERVAL -6 DAY) )
		, ( '202408010002', 'user2', '20240801', 2, DATE_ADD(NOW(), INTERVAL -6 DAY) )
		, ( '202408020001', 'user3', '20240802', 2, DATE_ADD(NOW(), INTERVAL -5 DAY) )
		, ( '202408020002', 'user1', '20240802', 1, DATE_ADD(NOW(), INTERVAL -5 DAY) )
		, ( '202408020003', 'user3', '20240802', 3, DATE_ADD(NOW(), INTERVAL -5 DAY) )
		, ( '202408030001', 'user3', '20240803', 2, DATE_ADD(NOW(), INTERVAL -4 DAY) )
		, ( '202408040001', 'user1', '20240804', 1, DATE_ADD(NOW(), INTERVAL -3 DAY) )
		, ( '202408050001', 'user2', '20240805', 4, DATE_ADD(NOW(), INTERVAL -2 DAY) )
		, ( '202408050002', 'user1', '20240805', 3, DATE_ADD(NOW(), INTERVAL -2 DAY) )
		, ( '202408060001', 'user3', '20240806', 5, DATE_ADD(NOW(), INTERVAL -1 DAY) )
		, ( '202408070001', 'user1', '20240807', 1, NOW() );
		*/
	/*
INSERT INTO tbl_order_detail_info
( order_no, goods_code, unit_code, unit_price, order_cnt, order_amount, reg_date)
VALUES
	( '202408010001', 'PN0001', '01', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -7 DAY) )
	, ( '202408010001', 'PN0002', '02', 2000, 1, 2000, DATE_ADD(NOW(), INTERVAL -6 DAY) )
	, ( '202408010001', 'PN0003', '04', 4000, 1, 4000, DATE_ADD(NOW(), INTERVAL -6 DAY) )
	, ( '202408010002', 'PN0001', '01', 1000, 2, 2000, DATE_ADD(NOW(), INTERVAL -5 DAY) )
	, ( '202408020001', 'ER0001', '03', 3000, 2, 6000, DATE_ADD(NOW(), INTERVAL -4 DAY) )
	, ( '202408020002', 'NT0002', '06', 1500, 1, 1500, DATE_ADD(NOW(), INTERVAL -4 DAY) )
	, ( '202408020003', 'PN0004', '07', 500, 2, 1000, DATE_ADD(NOW(), INTERVAL -3 DAY) )
	, ( '202408020003', 'ER0002', '08', 2500, 1, 2500, DATE_ADD(NOW(), INTERVAL -3 DAY) )
	, ( '202408040001', 'NT0001', '05', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'PN0002', '02', 2000, 1, 2000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'ER0001', '03', 3000, 1, 3000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'PN0003', '04', 4000, 1, 4000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050001', 'NT0002', '06', 1500, 1, 1500, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050002', 'PN0001', '01', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408050002', 'ER0002', '08', 2500, 2, 5000, DATE_ADD(NOW(), INTERVAL -2 DAY) )
	, ( '202408060001', 'PN0001', '01', 1000, 1, 1000, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	, ( '202408060001', 'PN0002', '02', 2000, 2, 4000, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	, ( '202408060001', 'PN0003', '04', 4000, 2, 8000, DATE_ADD(NOW(), INTERVAL -1 DAY) )
	, ( '202408070001', 'NT0002', '06', 1500, 1, 1500, DATE_ADD(NOW(), INTERVAL -1 DAY) )		
	;
*/
	
#SELECT * FROM tbl_goods_info;
	#
#오더 디테일에서 주문금액이 천원보다 작거나 크고 이천원보다 작은거

SELECT *
from tbl_order_detail_info;
# 주문 금액이 1000크고 2000작고


SELECT *
FROM tbl_order_detail_info
WHERE `order_amount` BETWEEN 1000 AND 2000;

#데이터 변경하기
UPDATE 테이블명 SET 컬럼명 1= 값1,  컬럼명2= 값2
WHERE 조건절

#TRANSACTIOM ==> 등록, 수정, 삭제 시 데이터의 정합성을 위하여 사용, 특징 ACID
START TRANSACTION;

UPDATE tbl_order_detail_info SET unit_code= '10';
COMMIT ;

ROLLBACK ; 

# 데이터 삭제하기
DELETE FROM 테이블명 WHERE 조건절

START TRANSACTION ;
DELETE 
FROM tbl_order_detail_info 
WHERE idx = '0';

#집계 함수 사용법
SELECT 그룹핑할  컬럼1, 그룹핑항 컬럼2,,,,그룹핑할 컬럼기준 계산할 컬럼(집계함수)
FROM 테이블명
WHERE 조건절
GROUP BY 그룹핑할 컬럼명1, 그룹핑할 컬럼명2,,,,
HAVING -> GROUP BY 조건절
ORDER BY -> 정렬조건
LIMIT : 시작값, 가져올 갯수 
			가져올 갯수
			시작값 offset 상위 n개 갯수

SELECT goods_code, SUM(order_amount) AS total_order_amount, COUNT(goods_code) AS goods_cnt
FROM tbl_order_detail_info
#where
GROUP BY goods_code 
#HAVING order_cnt > 1
ORDER BY total_order_amount DESC
LIMIT 0,2;


SELECT *
FROM tbl_member
#where
#GROUP BY order_no 
#HAVING order_cnt > 1
ORDER BY idx  DESC
LIMIT 0,2;

# cast convert 변환

SELECT *, idx AS `index`
FROM tbl_order_detail_info;

SELECT 
    CONCAT(addr1, ' ', addr2) AS 'address',
    REPLACE(LEFT(reg_date, 10), '-', '') AS reg_dates,
    LEFT(reg_date, 4) AS reg_year,
    RIGHT(LEFT(REPLACE(reg_date, '-', ''), 8), 2) AS reg_day,
    MID(REPLACE(reg_date, '-', ''), 5, 2) AS reg_month,
    cast(YEAR(reg_date) AS char) AS reg_year
FROM 
    tbl_member
ORDER BY 
    address ASC, 
    reg_date DESC;
    
    
#데이터를 백업받는 방법2
SELECT *
INTO OUTFILE 'D:\\java7\\mariadb\\tbl_member2.csv'
CHARACTER SET 'utf8'
FIELDS TERMINATED BY '||' ENCLOSED BY '"'
FROM tbl_member;

#백업받은 데이터를 불러와서 복구하는 방법
LOAD DATA LOCAL INFILE 
'D:\\java7\\mariadb\\tbl_member2.csv'
#CHARACTER SET 'EUCKR'
INTO TABLE tbl_member2 FIELDS TERMINATED BY '||' ENCLOSED BY '"';

SELECT * FROM tbl_order_detail_info;

#select 문제
#1. 등록일( 연도, 월, 날짜, 시간)
#2. 상품코드로 그룹핑하여 출력 -> 주문번호, 상품코드
#3. 상품 단가 500~ 1500이하 주문내역 출력


#1
SELECT CONVERT(YEAR(reg_date),CHAR) AS reg_year 
,RIGHT(LEFT(REPLACE(reg_date, '-', ''), 8), 2) AS reg_day
FROM tbl_order_detail_info;
		
		
		
#2		
SELECT order_no, count(order_no) AS cnt, goods_code
FROM tbl_order_detail_info
GROUP BY goods_code
#HAVING cnt = 2;
#그룹바이절에 대한 조건!그럼 상품코드가 두개씩인건?


#3 
SELECT * 
FROM tbl_order_detail_info
WHERE `unit_price` BETWEEN 500 AND 1500;


SELECT *
FROM tbl_order_detail_info
WHERE reg_date > '2024-08-06 00:00:00';

SELECT *
FROM tbl_order_detail_info
#WHERE unit_code = '02' OR unit_code = '04' OR unit_code = '06';
WHERE unit_code IN( '02','04','06');

SELECT *
FROM tbl_member
WHERE addr1 LIKE '서울%';


SELECT * 
FROM tbl_order_detail_info
WHERE modify_date is NULL;

SET @ADDR = '서울 강남구 논현동';
SET @TEL = '02-1234-5678';
SELECT @ADDR AS addr, @TEL AS tel WHERE;


SET @ADDR = '서울시 강남구 논현동';
SET @TEL = '02-1234-5678';
SELECT *
FROM tbl_member
WHERE addr1 LIKE @ADDR;

SET @ADDR = '서울시 강남구 논현동';
SET @TEL = '02-1234-5678';
SELECT *
FROM tbl_member
WHERE addr1 LIKE CONCAT('%', @ADDR, '%');

SELECT user_id AS '이름', user_name AS '이름', addr1 AS '주소'
FROM tbl_member
;

SELECT DISTINCT order_no 
FROM tbl_order_detail_info;


SELECT COUNT(DISTINCT order_no) AS cnt1, COUNT(order_no) AS cnt2
FROM tbl_order_detail_info;


SELECT *
FROM tbl_order_detail_info
ORDER BY idx DESC
LIMIT 2,2;
#시작 인덱스, 갯수
SELECT *
FROM tbl_order_detail_info
ORDER BY idx DESC
LIMIT 2 OFFSET 2 
;


SELECT unit_price, order_cnt, unit_price*order_cnt AS total_price, order_amount
FROM tbl_order_detail_info
;


SELECT *
FROM tbl_order_detail_info
WHERE unit_code != '06';


#기본산술연산자
+ : A+B
- : A-B
* : A*B
/ : A/B
DIV : A/B => 몫을 변환
%,MOD() : A/B => 나머지를 반환, X= A%B , x=MOD(A,B)
#할당연산자
= -> 값 할당 연산자
:= -> 변수에 값을 할당

SET @a = 1, @b = 2;
SELECT @a, @b;
SET @X := 1, @Y := 2;
SELECT @X, @Y


SELECT @nam := user_name 
FROM tbl_member ;
SELECT @nam;

#WHERE user_id = 'user3'

SELECT @nam;


