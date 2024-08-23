# 20240822

USE employees;
DESC VW_SALARY_2022;

#전체 스키마 확인하는 데이터베이스..?
USE information_schema;
#에서 뷰만 확인
SELECT * FROM VIEWS;

# 뷰 생성할때 작성한 구문 가져오기
SELECT view_definition FROM VIEWS 
WHERE TABLE_NAME LIKE '%SALARY%';

select `b`.`title` AS `title`,`b`.`mon` AS `mon`,`b`.`dept_no` AS `dept_no`,`b`.`dept_sum` AS `dept_sum` from (select '1' AS `title`,month(`sa`.`from_date`) AS `mon`,`em`.`dept_no` AS `dept_no`,sum(`sa`.`salary`) AS `dept_sum` from (`employees`.`dept_emp` `em` join `employees`.`salaries` `sa` on(`em`.`emp_no` = `sa`.`emp_no`)) where substr(`sa`.`from_date`,1,4) = 2022 group by `em`.`dept_no`,month(`sa`.`from_date`) union select '2' AS `title`,NULL AS `mon`,`em`.`dept_no` AS `dept_no`,sum(`sa`.`salary`) AS `dept_sum` from (`employees`.`dept_emp` `em` join `employees`.`salaries` `sa` on(`em`.`emp_no` = `sa`.`emp_no`)) where substr(`sa`.`from_date`,1,4) = 2022 group by `em`.`dept_no`) `b` union select '3' AS `title`,NULL AS `mon`,NULL AS `dept_no`,sum(`sa`.`salary`) AS `dept_sum` from (`employees`.`dept_emp` `em` join `employees`.`salaries` `sa` on(`em`.`emp_no` = `sa`.`emp_no`)) where substr(`sa`.`from_date`,1,4) = 2022 order by `dept_no`,`title`,`mon`



# 뷰를 사용하는 이유
/*

	1.쿼리문의 단순화
	2. 보안성을 향상
	3. 숙련되지 않은 개발자들의 DB 성능 저하를 유발하는 쿼리의 생성 방지
	4. 주로 SELECT 용도지만, 정의하는 방식에 따라INSERT / UPDATE / DELETE도 가능
		(단 SELECT  이외 사용시 보안을 고려해봐야함)
	5. OPDER BY 사용 가능
		- 뷰 정의시 ORDER BY를 사용하였을 경우 
			-> 뷰를 조회시에ORDER BY를 사용하면, 정의시 적용한 ORDER BY는 무시
	6. 테이블 공개시에 원래 열 이름, 테이블 명을 숨기고 별칭 ALTAS를 사용하여 공개 가능
	7. 뷰 정의시에 SELECT 쿼리문에  예약어, 시스템 변수, 사용자 정의 변수 사용 불가
		( 필요시 프로시저 사용)

*/

USE employees;

USE books;
SELECT * FROM tbl_order_info

/*
정규화,, 확인하기..
3정규화깢 ㅣ진행했는데 업무 프로세스상 복잡할때 4정규화 ( 비정규화 진행)
분리된 상세정보 테이블에서는 키가 되는 컬럼ㅇ 다른 테이블에 종속되서는 안된다
*/
CREATE VIEW vw_order_detail_infos AS(
	SELECT OI.order_no, OI.order_date, OI.cancelYN, OI.order_amount AS oi_order_amount, OI.order_tot_amount, OI.reg_date AS oi_reg_date
	,OD.goods_code, OD.unit_code, OD.unit_price, OD.order_cnt AS od_order_cnt ,OD.order_amount AS od_order_amount, OD.reg_date AS od_reg_date
	,MB.user_id, MB.user_name, MB.mileage, MB.recommander
	FROM tbl_order_info AS OI
	INNER JOIN tbl_order_detail_info as OD ON OI.order_no = OD.order_no
	LEFT
	OUTER JOIN tbl_member AS MB ON MB.user_id = OI.user_id
);

SELECT * FROM vw_order_detail_infos
WHERE ORDER_date IN('20240801')
ORDER BY unit_code;

INSERT INTO vw_order_detail_infos (order_no, order_date, cancelYN, oi_order_amount, order_tot_amount, oi_reg_date
	,goods_code, unit_code, unit_price, od_order_cnt , od_order_amount, od_reg_date
	,user_id, user_name, mileage, recommander
	)
	VALUES('202408010101'
	
	);
	
	
# view에서 transaction 작용

	
USER books;
SELECT * FROM tbl_member;

CREATE VIEW `vw_member` AS (
	SELECT user_id AS userID, user_name AS userName, pwd,job_code, mileage ,`status`, auto_login, reg_date 
	FROM tbl_member
	ORDER BY reg_date DESC
	);
SELECT * FROM vw_member;
DROP VIEW vw_member;
#
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` 
SQL SECURITY DEFINER VIEW `vw_member` AS (
	select `tbl_member`.`user_id` AS `userID`,`tbl_member`.`user_name` AS `userName`,`tbl_member`.`pwd` AS `pwd`,`tbl_member`.`job_code` AS `job_code`,`tbl_member`.`mileage` AS `mileage`,'status' AS `status`,`tbl_member`.`auto_login` AS `auto_login`,`tbl_member`.`reg_date` AS `reg_date` 
	from `tbl_member` 
	order by `tbl_member`.`reg_date` DESC
)

desc vw_member;
SHOW CREATE VIEW vw_member;

#
START TRANSACTION ;
ROLLBACK;
COMMIT;
INSERT INTO vw_member (userID, userName, pwd, job_code, mileage, `status`, auto_login, reg_date)
VALUES ('user13', '강남', '1234', '04', 0, 'Y', 'N', '2024-08-13 09:36:05');
INSERT INTO tbl_member (user_id, user_name, pwd, job_code, mileage, status, auto_login, reg_date)
VALUES ('user12', '강남', '1234', '04', 0, 'Y', 'N', '2024-08-13 09:36:05');


use information_schema;
SELECT * from information_schema.VIEWS;

#테이블 구조, 속성변경 ->ALTER
/*
	
	ALTER TABLE IF EXISTS 대상 테이블명
	동작 내용을 기술
	1. COLUMN 추가/수정/삭제
	2. 인덱스/제약조건 추가 수정 삭제
	3. 외래키(참조키)

*/

/*

	1. COLUMN 추가
		ALTER TABLE 대상테이블명
		ADD COLUMN IF NOT EXISTS 컬럼이름 컬럼정의 (테이블 생성시 넣는 정의)
		[컬럼의 위치값 
			- 기본값 : 제일 마지막 다음
			- FIRST : 제일 앞
			- AFTER 컬럼명 : 컬럼명 다음
		]
	
	2. COLUMN 삭제
		ALTER TABLE 대상테이블명
		DROP COLUMN IF NOT EXISTS 대상 컬럼이름
		
		
		
	3. COLUMN 속성 값 변경, 추가 
		ALTER TABLE 대상 테이블명
		MODIFFY COLUMN IF NOT EXISTS 대상 컬럼이름
		
	4. COLUMN 의 이름 변경
		ALTER TABLE 대상 테이블명
		CHANGE COLUMN  대상 컬럼이름 바꿀 컬럼명 + 속성값

*/
SET autocommit =0
START TRANSACTION;
DESC tbl_member
;

# 컬럼 추가
ALTER TABLE tbl_member
#ADD COLUMN if NOT EXISTS `auto_login`CHAR(1) NULL DEFAULT'N' COMMENT'자동로그인' ;
ADD COLUMN if NOT EXISTS `nickname` VARCHAR(20) NULL DEFAULT '' COMMENT'닉네임' 
AFTER birth_date;

ALTER TABLE tbl_member
ADD COLUMN if NOT EXISTS `nickname2` VARCHAR(20) NULL DEFAULT '' COMMENT'닉네임' 
AFTER birth_date;

DESC tbl_member;

ALTER TABLE tbl_member DROP COLUMN nickname;

COMMIT;
ROLLBACK;

# 컬럼 속성 변경
ALTER TABLE tbl_member
MODIFY COLUMN if EXISTS `nickname2` 
VARCHAR(20) NULL DEFAULT '' COMMENT'닉네임2' `ssn` AFTER nickname2;
DESC tbl_member;

# 컬럼 이름 및 속성변경 
DESC tbl_member;
ALTER TABLE tbl_member
CHANGE COLUMN `nickname1` `nickname2` VARCHAR(20) NULL DEFAULT 'NICNK'
;

DESC tbl_member;

#컬럼 삭제 
ALTER TABLE tbl_member
DROP COLUMN nickname2;

ALTER TABLE tbl_member
DROP COLUMN nickname;


# 

/*
인덱스 조회
SHOW INDEX FROM tbl_member;

	인덱스 추가/수정/삭제

	1. 인덱스 추가
		ALTER TABLE 테이블명
		ADD INDEX [INDEX|KEY] IF NOT EXISTS 인덱스 이름
		[인덱스타입](인덱스에 사용할 컬럼1, 컬럼2, ,,,,) [옵션] <-자주 사용 x
	
	2. 인덱스 수정
	DROP후에 ADD
		ALTER TABLE 테이블명
		DROP INDEX 인덱스
		
		ALTER TABLE 테이블명
		ADD INDEX 인덱스

*/

SELECT * FROM tbl_member;

ALTER TABLE tbl_member
ADD INDEX if NOT EXISTS `IDX_tbl_member_user_name` (`user_name`)
;
SHOW INDEX FROM tbl_member;

ALTER TABLE tbl_member
drop INDEX `IDX_tbl_member_user_name` 
;

ALTER TABLE tbl_member
add INDEX `IDX_tbl_member_user_name` 
(`user_name`, `user_id`)
;
#


/*

	제약조건 : PRIMARY KEY, CONSTRAINT 이용한 구문
	
	1. PRIMARY KEY 설정
		ALTER TABLE 테이블명
		ADD CONSTRAINT PRIMARY KEY(컬럼명1,,,);
		
	2. PRIMARY KEY 설정
		ALTER TABLE 테이블명
		DROP PRIMARY KEY;	
		
	3. 조회
		SHOW INDEX FROM 테이블명;
		
	CONSTRAINT 적용시점에 데이터의 적합성 판단 => 속도가 느리다아
*/

SHOW INDEX FROM tbl_member 
WHERE key_name LIKE '%pr%';


/*
		ALTER 테이블명
		ADD CONSTRAINT
		UNIQUE [INDEX|KEY] [index_name]
			
		테이블 생성, 수정시에 특정 컬럼의 데이터에 제약사항 적용
		
	1. 제약 사항 추가
		ex)주민번호 
		ALTER TABLE 테이블명
		ADD CONSTRAINT `CHECK 제약사항이름` CHECK (mileage >=10)


	2. 제약 사항 삭제
		ALTER TABLE 테이블명
		DROP CONSTRAINT `CHECK 제약사항이름`
	
*/


CREATE TABLE `tbl_member` (
	`idx` INT(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
	`user_id` VARCHAR(20) NOT NULL COMMENT '아이디' COLLATE 'utf8mb4_general_ci',
	`user_name` VARCHAR(20) NOT NULL COMMENT '이름' COLLATE 'utf8mb4_general_ci',
	`pwd` VARCHAR(20) NOT NULL COMMENT '비밀번호' COLLATE 'utf8mb4_general_ci',
	`ssn` VARCHAR(14) NULL DEFAULT NULL COMMENT '주민번호(123456-1234567)' COLLATE 'utf8mb4_general_ci',
	`birth_date` CHAR(10) NULL DEFAULT NULL COMMENT '생년월일(YYYY-MM-DD)' COLLATE 'utf8mb4_general_ci',
	`addr1` VARCHAR(100) NULL DEFAULT NULL COMMENT '주소1' COLLATE 'utf8mb4_general_ci',
	`addr2` VARCHAR(100) NULL DEFAULT NULL COMMENT '주소2' COLLATE 'utf8mb4_general_ci',
	`zip_code` VARCHAR(7) NULL DEFAULT NULL COMMENT '우편번호' COLLATE 'utf8mb4_general_ci',
	`job_code` CHAR(2) NULL DEFAULT NULL COMMENT '직업코드' COLLATE 'utf8mb4_general_ci',
	`mileage` INT(11) NULL DEFAULT '0' COMMENT '마일리지',
	`status` CHAR(1) NULL DEFAULT NULL COMMENT '회원선택(사용중,N탈퇴,P중지)' COLLATE 'utf8mb4_general_ci',
	`reg_date` DATETIME NULL DEFAULT current_timestamp() COMMENT '등록일',
	`leave_date` DATETIME NULL DEFAULT NULL COMMENT '탈퇴일',
	`auto_login` CHAR(1) NULL DEFAULT 'N' COMMENT '자동로그인여부(Y:자동로그인,N:자동로그인안함)' COLLATE 'utf8mb4_general_ci',
	`recommander` VARCHAR(10) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`user_id`) USING BTREE,
	INDEX `인덱스 1` (`idx`) USING BTREE
	CONSTRAINT `CHK_mm <--입력가능
)
COMMENT='회원테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=19
;

ALTER TABLE tbl_member
ADD CONSTRAINT `CHK_tbl_member_mileage` CHECK (`mileage`>=0);

#/* SQL 오류 (4025): CONSTRAINT `CHK_tbl_member_mileage` failed for `books`.`tbl_member` */
# 위에 제약에 걸려 데이터 추가 안됌
INSERT INTO vw_member (userID, userName, pwd, job_code, mileage, `status`, auto_login, reg_date)
VALUES ('user14', '강남', '1234', '04', -10, 'Y', 'N', '2024-08-13 09:36:05');

UPDATE vw_member SET mileage = 0 WHERE mileage < 0 ;
DELETE FROM vw_member WHERE userID = 'user14';

# 만약 제약에 걸린 컬럼때문에 수정이 안되면 해당 컬럼을 찾아 삭제후 다시 작업을 한다..


/*

	외래키(참조키) 추가/ 삭제
	
	1. 추가
		ALTER TABLE 테이블명
		ADD CONSTRATNT FOREIGN KEY `외래키이름`(현재 테이블에 있는 컬럼1,2,,,)
		REFERENCES 참조 테이블명 (참조 테이블에 있는 컬럼명1,,2,,,)
		ON DELECTE (CASCADE | RESTRICT | SET NULL | NO ACTION | SET DEFAULT)
		
		
		delete RESTRICT  update NO ACTION 으로 해야 추적이 가능하다
		
	외래키 삭제할때는 인덱스도 함께 지워줘야함
	수정은 drop 후 add
	
	cascade 하는거 데이터의 정합성은 안깨지지만, 
	데이터 추적이 어려움
	

*/

# 주문 상세 테이블 -> goods_code <- 상품코드 테이블.goods_code

ALTER TABLE tbl_order_detail_info 
ADD CONSTRAINT FOREIGN KEY `FK_tbl_order_detail_info_goods_code` (goods_code)
REFERENCES `tbl_goods_info`(goods_code)
ON DELETE CASCADE ON UPDATE CASCADE 
;

DESC tbl_order_detail_info ;
DESC tbl_goods_info;

SHOW INDEX FROM tbl_order_detail_info ;
SELECT * FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN (tbl_order_detail_info)



# 테이블 표현식 (COMMON TABLE EXPRESSION)
/*
	with 임시테이블 as(
		select
	)
	
	select * form 임시테이블명;
	하나의 프로세스에서 시작하고 조회까지 종료, 메모리상에만 종료
	쿼리가 끝나면 사라진다
*/

# 임시 테이블 (TEMPORARY TABLE)
/*

	CREATE TEMPORARY TABLE 테이블명 ( 컬럼정의) ;

*/
# 메모리상에만 존재
/*

	임시테이블 특징
	1. db에 접속 후 부터 세션이 존재하는 동안 연결 가능
	2. 세션이 종료되거나, db가 재시작 되면 삭제
	3. DROP TABLE 이용하여 삭제 가능
	4. 임시 테이블을 만든 클라이언트(세션)에서만 접근 가능
	5. 테이블 명명을 일반 테이블과 혼동되지 않도록 정의
		TMP_TBL_xxx
		일반 테이블 스토리지
		임시 테이블 메모리
	6. 일반 테이블 이름고 임시 테이블 이름이 같으면 임시 테이블이 우선
	7. 다른 테이블과의 제약 관계를 추가할 수 없다ㅣ
	
	트랜잭션 적용 가능
*/
/*
인덱스가 키라면 오토값 삭제하고
추후에 alter 로 값을 넣어준다...

임시테이블로 뷰를 만들수 없는 이유 
뷰는 직접 삭제 전까지 남지만,
임시테이블만 세션이 끊어지거나, db를 종료하면 없어져서
생성이 불가하다 
*/

CREATE TEMPORARY TABLE `TMP_tbl_member`(
	`idx` INT(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
	`user_id` VARCHAR(20) NOT NULL COMMENT '아이디' COLLATE 'utf8mb4_general_ci',
	`user_name` VARCHAR(20) NOT NULL COMMENT '이름' COLLATE 'utf8mb4_general_ci',
	`pwd` VARCHAR(20) NOT NULL COMMENT '비밀번호' COLLATE 'utf8mb4_general_ci',
	`ssn` VARCHAR(14) NULL DEFAULT NULL COMMENT '주민번호(123456-1234567)' COLLATE 'utf8mb4_general_ci',
	`birth_date` CHAR(10) NULL DEFAULT NULL COMMENT '생년월일(YYYY-MM-DD)' COLLATE 'utf8mb4_general_ci',
	`addr1` VARCHAR(100) NULL DEFAULT NULL COMMENT '주소1' COLLATE 'utf8mb4_general_ci',
	`addr2` VARCHAR(100) NULL DEFAULT NULL COMMENT '주소2' COLLATE 'utf8mb4_general_ci',
	`zip_code` VARCHAR(7) NULL DEFAULT NULL COMMENT '우편번호' COLLATE 'utf8mb4_general_ci',
	`job_code` CHAR(2) NULL DEFAULT NULL COMMENT '직업코드' COLLATE 'utf8mb4_general_ci',
	`mileage` INT(11) NULL DEFAULT '0' COMMENT '마일리지',
	`status` CHAR(1) NULL DEFAULT NULL COMMENT '회원선택(사용중,N탈퇴,P중지)' COLLATE 'utf8mb4_general_ci',
	`reg_date` DATETIME NULL DEFAULT current_timestamp() COMMENT '등록일',
	`leave_date` DATETIME NULL DEFAULT NULL COMMENT '탈퇴일',
	`auto_login` CHAR(1) NULL DEFAULT 'N' COMMENT '자동로그인여부(Y:자동로그인,N:자동로그인안함)' COLLATE 'utf8mb4_general_ci',
	`recommander` VARCHAR(10) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`user_id`) USING BTREE,
	INDEX `인덱스 1` (`idx`) USING BTREE
)
COMMENT='임시회원테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=20
;

SELECT * FROM TMP_tbl_member;

INSERT INTO TMP_tbl_member (SELECT * FROM tbl_member);

SHOW TABLES;

SELECT OI.*
FROM tbl_order_info AS OI
INNER JOIN TMP_tbl_member AS TMB ON OI.user_id = TMB.user_id

