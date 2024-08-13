USE books;

#SHOW TABLES;

#SELECT *
#FROM tbl_member;

# 예약어
# DML
# DDL
# DCL
# TCL
# 식별자(identifier) ~~ 변수명, 테이블명, 컬럼명,,, 작성규칙
/*
- 0~9, a~z, A~z, $, _ 문자 사용 가능
	$,_ ==> 시스텝에서 사용하는 함수, 프로시저
	시작 문자 : 영문자, __ 
- 식별자와 인용문자 : 백틱(`), backtick
- 예약어 사용불가, Reserved Word
- 이름(변수)의 최대 길이 64문자
- 알기 쉬운 단어나, 단어의 약자(명쾌할 경우에만)
- 복합단어 : 단어와 단어 사이에 _ 를 사용 변수_변수, abcCarmel, param+_math
*/


/*
 INSERT : 데이터를 등록하는 기능 
 
 INNSERT INTO {`데이터베이스명`.} 테이블명 (칼럼명1, 칼럼명2 ,,,) VALUES (값1, 값2 ,,,);

*/

desc tbl_member;
INSERT INTO tbl_member(user_id, user_name, pwd) VALUES ('user1', '홍길동', '1234'); 
INSERT INTO tbl_member(
	`user_id`,
	`user_name`,
	`pwd`,
	`ssn`,
	`birth_date`,
	`addr1`,
	`addr2`,
	`zip_code`,
	`job_code`,
	`mileage`,
	`status`,
	`reg_date`,
	`leave_date`,
	`auto_login`)
VALUES ( 
	'user2',
	'홍길동2',
	'1234',
	'123456-1234567',
	'20240807',
	'서울시 강남구 논현동',
	'37번길(래미안)',
	'12345',
	'',
	0 ,
	'P' ,
	NOW(),
	null ,
	'Y');
	
INSERT INTO tbl_member(
	`user_id`,
	`user_name`,
	`pwd`,
	`ssn`,
	`birth_date`,
	`addr1`,
	`addr2`,
	`zip_code`,
	`job_code`,
	`mileage`,
	`status`,
	`reg_date`,
	`leave_date`,
	`auto_login`)
VALUES ( 
	'user3',
	'홍길순',
	'1234',
	'234567-3456789',
	'20240707',
	'서울시 강서구 논현동',
	'37번길(자이안)',
	'123-456',
	'',
	0 ,
	'Y' ,
	NOW(),
	null ,
	'Y'); 


/*
데이터 조회 기본 문법
SELECT 컬럼1, 컬럼2,,,
FROM{`데이터베이스명`}테이블명
*/

SELECT *
FROM tbl_member;


INSERT INTO tbl_order_info(order_no, user_id, order_date, order_amount, reg_date)
VALUES ('20240801001', 'user1', '20240801', 3, DATE_ADD(NOW(), INTERVAL -6 DAY))
		,('20240801002', 'user2', '20240801', 2, DATE_ADD(NOW(), INTERVAL -6 DAY))
		,('20240802001', 'user3', '20240802', 2, DATE_ADD(NOW(), INTERVAL -5 DAY))
		,('20240802002', 'user1', '20240802', 1, DATE_ADD(NOW(), INTERVAL -5 DAY))
		,('20240803001', 'user2', '20240803', 3, DATE_ADD(NOW(), INTERVAL -4 DAY))
		,('20240803002', 'user3', '20240803', 3, DATE_ADD(NOW(), INTERVAL -4 DAY))
		,('20240804001', 'user1', '20240804', 6, DATE_ADD(NOW(), INTERVAL -3 DAY))
		,('20240804002', 'user2', '20240804', 4, DATE_ADD(NOW(), INTERVAL -3 DAY))
		,('20240805001', 'user3', '20240805', 3, DATE_ADD(NOW(), INTERVAL -2 DAY))
		,('20240805002', 'user1', '20240805', 5, DATE_ADD(NOW(), INTERVAL -2 DAY))
		,('20240806001', 'user2', '20240806', 2, DATE_ADD(NOW(), INTERVAL -1 DAY))
		,('20240806002', 'user3', '20240806', 5, DATE_ADD(NOW(), INTERVAL -1 DAY))
		,('20240807001', 'user1', '20240807', 1, NOW())
	;
	
SELECT * FROM tbl_order_info;
DESC tbl_order_info;

# 상품 정보 등록
INSERT INTO tbl_goods_info(goods_code, goods_name, unit_code, unit_price, goods_status,reg_date)
VALUES 
('PN0001', '연필', '01', 1000, 'Y', '2024-07-01 00:00:00')
,('PN0002', '샤프', '02', 2000, 'Y', '2024-07-02 00:00:00')
,('EN0001', '지우개', '03', 3000, 'Y', '2024-07-03 00:00:00')
,('PN0003', '볼펜', '04', 4000, 'Y', '2024-07-04 00:00:00')
,('NT0001', '무지노트', '05', 1000, 'Y', '2024-07-05 00:00:00')
,('NT0002', '연습장', '05', 1500, 'Y', '2024-07-06 00:00:00')
,('PN0004', '볼펜심', '06', 500, 'Y', '2024-07-07 00:00:00')
,('ER0002', '수정펜', '07', 2500, 'Y', '2024-07-08 00:00:00')
;


#
INSERT INTO tbl_order_detail_info(order_no, goods_code, unit_code, unit_price, order_cnt, order_amount ,reg_date)
VALUES 
('20240801001', 'PN0001', '01', 1000,1,1000, DATE_ADD(NOW(), INTERVAL -6 DAY)
,('20240801002', 'PN0002', '02', 2000,1,2000, DATE_ADD(NOW(), INTERVAL -6 DAY)
,('20240802001', 'EN0001', '03', 3000,1,1000, DATE_ADD(NOW(), INTERVAL -6 DAY)
;






