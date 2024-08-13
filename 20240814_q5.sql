#job_code에 따른 직업 구분
case when
decode_coacle

학생, 회사원, 공무원, 교사 , 기타
회원 아이디 이름, 주민번호, 주소 직업 출력

show DATABASES;
use books;

SHOW TABLES;

SELECT *
FROM tbl_member;

SELECT user_id, user_name, ssn, CONCAT(addr1, addr2) AS addr,
	case job_code  
		when '01' then '학생'
		when '02' then '회사원'
		when '03' then '공무원'
		when '04' then '교사'
	ELSE '기타'
	END AS job
FROM 	tbl_member;

START TRANSACTION;

UPDATE tbl_member SET `addr1` = '경기도 고양시'
WHERE user_id='user8';
SELECT ROW_COUNT();

COMMIT;
ROLLBACK;

INSERT INTO tbl_member (user_id, user_name,pwd, ssn, birth_date, addr1, addr2
								,zip_code, job_code, mileage, STATUS, reg_date, auto_login)
						VALUES('user11','강남','1234','456789-3467890','20221225'
						,'경기도 안양시 만안구','만안동123','12345','04',0,'Y',NOW(),'N');
						
SELECT LAST_INSERT_ID();
# 다시 확인




#현재 접속한 사용자의 정보조회ㅏ
SELECT USER(), CURRENT_USER();
#DB정보 조회
SELECT DATABASE(), VERSION();

SELECT *
FROM tbl_order_info;

SELECT *
FROM tbl_order_detail_info;

SELECT *
FROM tbl_goods_info;

SELECT *
FROM tbl_member;

DESC tbl_order_info;
DESC tbl_order_detail_info;
DESC tbl_goods_info;
DESC tbl_member;

SELECT OI.user_id, MB.user_name, OI.order_no
FROM tbl_order_info AS OI
RIGHT OUTER JOIN tbl_member AS MB ON OI.user_id = MB.user_id
ORDER BY OI.order_no
;

#주문번호가 있는 회원 출력
SELECT TI.user_id, MB.user_name, TI.order_no
FROM tbl_order_info AS TI
inner JOIN tbl_member AS MB ON TI.user_id = MB.user_id
ORDER BY TI.order_no
;


#주분번호 , 주문일자, 주문자id, 상품코드, 주문수량, 주문금액,쿼리작성

SELECT TI.order_no,TI.order_date,MB.user_id,TD.goods_code, TD.order_cnt,TD.order_amount
FROM tbl_order_info AS TI
inner JOIN tbl_member AS MB ON TI.user_id = MB.user_id
INNER JOIN tbl_order_detail_info AS TD ON TD.order_no = TI.order_no 
;

# tbl_order_info 기준으로 tbl_order_detail_info 내용을 보여주는 쿼리 작성
# 주문번호, 주문일자, 주문자id, 상품코드, 상품수량, 주문 금액
SELECT TI.order_no,TI.order_date,TI.user_id,TD.goods_code, TD.order_cnt,TD.order_amount
FROM tbl_order_info AS TI
LEFT OUTER JOIN tbl_order_detail_info AS TD ON TD.order_no = TI.order_no 
;

#직업 코드에 따른 평균 주문 금액과, 가장 관심이 많은 상품
SELECT MB.job_code, AVG(OI.order_amount) AS avg_amount
FROM tbl_order_info AS OI
LEFT OUTER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
inner JOIN tbl_member AS MB ON OI.user_id = MB.user_id
GROUP BY MB.job_code
;

SELECT MB.job_code, OD.goods_code,
			SUM(OD.order_cnt) AS order_cnt
FROM tbl_order_info AS OI
left outer JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
inner JOIN tbl_member AS MB ON OI.user_id = MB.user_id
GROUP BY MB.job_code, OD.goods_code
HAVING MB.job_code IS NOT NULL AND OD.goods_code IS NOT null
;

ALTER TABLE if EXISTS 테이블명
 	ADD COLUMN
 	
# 컬럼을 추가 / 변경 : ADD COLUMN IF EXISTS 컬럼명
# 인덱스 추가 / 변경 : ADD IDEX
# 제약 추가 / 변경	: ADD CONSTRINT
# UNIQUE KEY	 		: ADD CONSTRINT UNIQUE
# 외래키(참조키) 		: ADD CONSTRINT FOREIGN KEY~~

DROP COLUMN
DROP IDEX
DROP CONSTRINT
DROP FOREIGN KEY
#대괄호 안은 옵션 넣어도 되거나 안넣어도 되는거 

ALTER TABLE tbl_member
ADD COLUMN recommander VARCHAR(10) NULL DEFAULT '' AFTER `auto_login`
;

SELECT *
FROM tbl_member;

UPDATE tbl_member SET recommander = 'user2'
WHERE USER_id = 'user5';

# 추천을 한적이 있는사람
SELECT MB1.user_id, MB1.user_name, MB2.recommander
FROM tbl_member AS MB1
LEFT OUTER JOIN tbl_member AS MB2 ON MB1.user_id = MB2.recommander
ORDER BY MB1.user_id
;

#추천인을 적은사람 각각 목적이 다름
select user_id, USER_name, recommander
FROM tbl_member
ORDER BY user_id
;

#주문벊로, 주문일, <-주문 테이블
#주문자아이디, 이름, 직업이름, <-회원테이블
#상품코드, 상품명, 단위명,
#주문수량, 주문금액
# 이런식으로 테이블끼리 나눠서 조회하기
SELECT OI.order_no, OI.order_date
		, MB.user_id, MB.user_name
		, case MB.job_code
			when '01' then '학생'
			when '02' then '회사원'
			when '03' then '공무원'
			when '04' then '교사'
			ELSE '기타'
	END AS job
	, GI.goods_code, GI.goods_name, GI.unit_code
	, OD.order_cnt, OD.order_amount
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
INNER JOIN tbl_member AS MB ON OI.user_id = MB.user_id
LEFT OUTER JOIN tbl_goods_info AS GI ON OD.goods_code = GI.goods_code #주문기준으로 상품 가져오기
ORDER BY OI.order_no
;

CREATE TABLE tbl_jobinfo(
	`idx` INT NOT NULL COMMENT'인덱스' AUTO_INCREMENT,
	`job_code` CHAR(2) NOT NULL DEFAULT '' COMMENT '직업코드',
	`job_name` VARCHAR(20) NULL DEFAULT NULL COMMENT'직업명',
	PRIMARY KEY (`job_code`)USING BTREE,
	INDEX`IDX_tbl_jobinfo_idx`(`idx`) USING BTREE
	)
COMMENT='직업정보테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB
;

SHOW TABLES;

INSERT INTO tbl_jobinfo (job_code, job_name)
VALUES
('01','학생')
,('02','회사원')
,('03','공무원')
,('04','교사')
,('05','기타')
;


SELECT * 
FROM tbl_jobinfo;


#단위코드 정보 테이블 생성
#테이블명: tbl_unitcode_info
#1. idx AUTO_INCREMENT
#2. unit_code -> char(2), not null pk 
#3. unit_name -< varchar(20), not null

booksSELECT *
FROM tbl_unitcode_info;

DESC tbl_unitcode_info;

CREATE TABLE tbl_unitcode_info( 
 `idx` INT NOT NULL COMMENT'인덱스' AUTO_INCREMENT,
 `unit_code` CHAR(2) NOT NULL COMMENT'상품코드' ,
 `unit_name` VARCHAR(20) NOT NULL COMMENT'상품이름',
 PRIMARY KEY (`unit_code`)USING BTREE,
 INDEX`IDX_tbl_unitcode_info_idx`(`idx`) USING BTREE
 )
 COMMENT='상품정보테이블'
 COLLATE='utf8mb4_general_ci'
 ENGINE=innodb
 ;
 

 
 INSERT INTO tbl_unitcode_info( unit_code, unit_name)
 VALUES
  ('01','EA')
 ,('02','BOX')
 ,('03','다스')
 ,('04','축')
 ,('05','KG')
 ,('06','온스')
 ,('07','근')
 ,('08','기타')
 ;
 
  INSERT INTO tbl_unitcode_info( unit_code, unit_name)
 VALUES('99','기타')
 ;
 
 #회원 테이블 tbl_menber ->job_code
 #직업코드 tbl_jobcode -> job_code 매핑시켜서
 #회원테이블 기준으로
 #user_id, user_name, 
 #job_code, job_name
 #출력 쿼리
 
 SELECT MB.user_id,MB.user_name
 ,JI.job_code, JI.job_name
 FROM tbl_member AS MB
 LEFT outer JOIN tbl_jobinfo AS JI ON MB.job_code = JI.job_code
 GROUP BY  MB.user_id
 ;
 
 #tbl_goods_info + tbl_unitcode_info join
 #tbl_goods_info기준으로
 #goods_code, goods_name, unit_code, unit_name
 #출력 쿼리 작성
 
SELECT GI.goods_code,GI.goods_name, UI.unit_code, UI.unit_name
FROM tbl_goods_info AS GI
LEFT OUTER JOIN tbl_unitcode_info AS UI on GI.unit_code = UI.unit_code
;


#공통 코드 관리를 위하 테이블작성

CREATE TABLE tbl_common_code(
 `idx` INT NOT NULL COMMENT'인덱스' AUTO_INCREMENT,
 `group_code` VARCHAR(6) NOT NULL COMMENT'공통코드그룹',
 `common_code` VARCHAR(10) NOT NULL COMMENT'공통코드',
 `common_name` VARCHAR(30) NOT NULL COMMENT'공통코드이름',
 `reg_date` DATETIME NOT NULL DEFAULT NOW() COMMENT'등록일',
 `modify_date` DATETIME NULL DEFAULT NULL COMMENT'수정일' ,
 PRIMARY KEY(`group_code`, `common_code`)USING btree,
 INDEX `idx`(`idx`) USING btree
)
COMMENT = '공통 코드 관리 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB
;

INSERT INTO tbl_common_code(group_code, common_code, common_name, reg_date)
VALUES
('100','01','학생',NOW())
,('100','02','회사원',NOW())
,('100','03','공무원',NOW())
,('100','04','교사',NOW())
,('100','05','기타',NOW())
,('200','01','기타',NOW())
;

studystudy
INSERT INTO tbl_common_code(group_code, common_code, common_name, reg_date)
VALUES
('200','02','EA',NOW())
,('200','03','BOX',NOW())
,('200','04','다스',NOW())
,('200','05','축',NOW())
,('200','06','KG',NOW())
,('200','07','온스',NOW())
,('200','08','근',NOW())
,('200','99','기타',NOW())
;
