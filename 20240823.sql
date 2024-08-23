#20240823

#변수
/*
	1. 시스템 변수
	2. 사용자 정의 변수
		-@ 기호로 시작
		- 영문자, 기호( _ $ . ) , 숫자문자
		-변수명 @``, @'', @""
		- 대소문자 구분 안함
		- 변수의 값을 저장할 때 SET 키워드 사용
		- 대입, 할당 -> 변수에 값을 저장		
*/

SET @abc = 'Hello';
SELECT @abc;

SET @A = 100, @B = 200;
SET @C = @A + @B;
SELECT @A, @B, @C;

SELECT @C;
# 명시저ㅕㄱ
SET @Z = 'ABC';
SET @D = CAST('ABC' AS VARCHAR(30));
SET @E = CONVERT('가나다',CHAR(10));
SET @X = CONCAT(@D, @E);

SELECT @D, @E, @X, @G;

#변수를 쿼리문에서 할당하는 방법들 (기억기억)
# 1 :=
# INTO 절 사용

SET @USER_ID = '';

SELECT @USER_ID := user_id
FROM tbl_member
LIMIT 1;

SELECT @USER_ID;

#where 절이 없으면 오류 str변수라 arr입력 불가 , 하나만 입력 가능
SELECT user_id, user_name
from tbl_member
WHERE user_id = 'user1';


SELECT @USER_ID := user_id, @USER_NAME := user_name
from tbl_member
WHERE user_id = 'user1';


SELECT user_id, user_name 
INTO @USER_ID, @USER_NAME
from tbl_member
WHERE user_id = 'user1';

SELECT @USER_ID, @USER_NAME;

SELECT USER_ID, TO_CHAr(REG_DATE, 'YYYY-MM-DD')
INTO @USER_ID, @REG_DATE
FROM tbl_member
LIMIT 1;

SELECT @USER_ID, @REG_DATE;

#

SELECT *
FROM information_schema.user_variables;

# SQL 프로그래밍문 기본
# 절차적 질의형ㅇ
# 프로그래밍 내용이 한줄 이상일 경우 반드시
# 프로그래밍 블럭을 지정해줘야한다
# BEGIN ~~ END
/*

	BEGIN [NOT ATOMIC]
		실행구문1;
		실행구문2;
		,,,,,,, 
	END;
	
	- 내부에서 실행하는 실행구문의 구분은 ;
	- 레이블을 사용할 경우 BEGIN~END 레이블명이 동일해야함
	- BEGIN~END  중청사용 가능
	- NOT ATOMIC : 저장프로시저나, 사용자 정의 함수가 아닌 프로그램 블럭을 의미
	- 선언절 사용 가능
		- DECLARE 지역변수;
		- DECLARE CONDITION s;
		- DECLARE CURSOR s;
		- DECLARE HANDLER s;
		
	
*/


BEGIN NOT ATOMIC
	SET @A = 100, @B = 200;
	SET @C = @A + @B;
	SELECT @C;
END
;


# IF ~~ END IF;
/*

	기본 형식
	IF 조건문1 THEN
		실행구문 1;
	ELSEIF 조건문2 THEN
	 실행구문2;
	ELSE 
		실행구문3;
	
	END IF;

*/



BEGIN NOT ATOMIC
 SET @V = 70;
 SET @MSG = '';
	 IF @V >100 OR @V <0 THEN
	 	SET @MSG = '입력 범위를 초과하였습니다.';
	 ELSEIF @V >= 90 THEN
	 	SET @MSG = 'A';
	 ELSEIF @V >= 80 THEN
	 	SET @MSG = 'B';
	 ELSEIF @V >= 70 THEN
	 	SET @MSG = 'C';
	 ELSE 
	 	SET @MSG = 'c';
	 END IF;

SELECT CONCAT('입력하신 범위는',@MSG ,'입니다') AS `GRADE`;
END;

/*

CASE 구문 정리

*/ 


BEGIN NOT ATOMIC

 SET @V = 70;
 SET @MSG = '';
 SET @MSG = CASE  
	 WHEN @V>100 OR @V <0 THEN '입력 범위를 초과하였습니다.'
	 WHEN  @V >= 90 THEN 'A'
	 WHEN  @V >= 80 THEN 'B'
	 WHEN  @V >= 70 THEN 'C'
  	 ELSE 'C'
  END;
SELECT CONCAT('입력하신 범위는', @MSG ,'입니다') AS `GRADE`;

END;

# WHILE ~ END WHILE 문
/*
[]<- 옵션이라 없어도 무방

	- 기본형식
	[레아블명:] WHILE 조건식 DO
		실행문1;
		실행문2;
		,,.,,
	END WHILE [레이블명]

*/

#1~100 까지 합을 구하는 쿼리를 WHILE문을 이용하여 작성

BEGIN NOT ATOMIC

SET @I = 0;
SET @S = '';

 WHILE @I <= 100 DO
	  SET @S = @S + @I;
	  SET @I = @I + 1;
 END WHILE;

SELECT @S AS `SUMM`;


END;

#1~100 까지 수 중에서 홀수의 합, 짝수의 합을 구하는 쿼리 

#홀수
BEGIN NOT ATOMIC

SET @I = 1;
SET @S = 0;

	WHILE @I <= 100 DO
		 SET @S = @S + @I;
		 SET @I = @I + 2 ;
	END WHILE; 
SELECT @S AS `SUMM`;
END;


#짝수
BEGIN NOT ATOMIC

SET @I = 0;
SET @S = 0;

	WHILE @I <= 100 DO
		 SET @S = @S + @I;
		 SET @I = @I + 2 ;
	END WHILE; 
SELECT @S AS `SUMM`;
END;

#MOD 짝수
BEGIN NOT ATOMIC

SET @I = 0;
SET @S = 0;

	WHILE @I <= 100 DO
	IF @I MOD 2 = 0 THEN
		 SET @S = @S + @I;
		 END IF;
		 SET @I = @I +1;
	END WHILE; 
SELECT @S AS `SUMM`;
END;



#MOD 홓수
BEGIN NOT ATOMIC

SET @I = 0;
SET @S = 0;

	WHILE @I <= 100 DO
	IF @I MOD 2 = 1 THEN
		 SET @S = @S + @I;
		 END IF;
		 SET @I = @I +1;
	END WHILE; 
SELECT @S AS `SUMM`;
END;


#MOD 짝수
BEGIN NOT ATOMIC

SET @I = 1;
SET @S = 1;

	WHILE @I <= 10 DO
	IF @I MOD 2 = 0 THEN
		 SET @S = @S * @I;
		 END IF;
		 SET @I = @I +1;
	END WHILE; 
SELECT @S AS `SUMM`;
END;


#MOD 홓수
BEGIN NOT ATOMIC

SET @I = 1;
SET @S = 1;

	WHILE @I <= 10 DO
	IF @I MOD 2 = 1 THEN
		 SET @S = @S * @I;
		 END IF;
		 SET @I = @I +1;
	END WHILE; 
SELECT @S AS `SUMM`;
END;


# FOR ~END FOR 문
/*

	-기본 형식
	FOR 반복변수 IN [REVEESE] 초기값.. 목적값
	DO
		실행문1;
		실행문2;
		,,,,,
	END FOR
*/
	
#1~100 합
# FOR에서 변수 I는 @안붙이고 지역변수로 FOR 문 안에서만 사용, 조회 가능

BEGIN NOT ATOMIC
	SET @S = 0;
	FOR I IN 1..100 DO
	 SET @S = @S + I;
	END FOR;
SELECT @S AS `SUM`;	
	
END;
	
# 1~100  짝수

BEGIN NOT ATOMIC

SET @S = 0;
SET @P = 0;
FOR I IN 1..50 DO
	SET @S = @S+ @P;
	SET @P = @P + 2;
END FOR;

SELECT @S AS `SUM`;	

END;

# 1~100  짝수

BEGIN NOT ATOMIC

SET @S = 0;
SET @P = 1;
FOR I IN 1..50 DO
	SET @S = @S+ @P;
	SET @P = @P + 2;
END FOR;

SELECT @S AS `SUM`;	

END;

BEGIN NOT ATOMIC

SET @S = 0;
FOR I IN 1..100 DO
    IF I % 2 != 0 THEN
        SET @S = @S + I;
    END IF;
END FOR;

SELECT @S AS `SUM`;	

END;

#LABEL 이 필요한 경우
/*

	-WHERE, FOR 문의 탈출을 위해서 필요
	-LABEL 키워드 이용
	
*/

BEGIN NOT ATOMIC

SET @S = 0;
SET @START_NO = 1;
SET @END_NO = 100;
LOOP1:FOR I IN @START_NO .. @END_NO DO
	SET @S = @S+ I;
	IF I > 10 THEN
	LEAVE LOOP1;
	END IF;
END FOR LOOP1;

SELECT @S AS `SUM`;	

END;

#WHILE문으로 변경 



	
#LOOP ~ END LOOP문
/*
-기본형식
	레이블:LOOP
		실행문1;
		실행문2;
		,,,
		탈출조건;
	END LOOP 레이블
*/

BEGIN NOT ATOMIC
 	SET @CNT = 1;
 	SET @TOT = 0;
 	LOOP1: LOOP
 	IF @CNT > 100 THEN
 		LEAVE LOOP1;
 	END IF;
 	
 	SET @TOT = @TOT + @CNT;
 	SET @CNT = @CNT + 1;
 	END LOOP LOOP1;
 	
 	SELECT @TOT AS `SUM`, @CNT AS `CNT` ;

END;

# 실행 구문 실행, 조건절 판단
/*

	- 기본형식
	[레이블:] REPEAT
		실행문1;
		실행문2;
		,,,,,
		UNTIL 조건
	END REPEAT [레이블]

*/

# TRUE 일땐 팅겨 나가고 FALSE일때만 반복
BEGIN NOT ATOMIC
 	SET @CNT = 0;
 	SET @TOT = 0;

	LOOP1:REPEAT
 		SET @CNT = @CNT + 1;	
	 	SET @TOT = @TOT + @CNT;
		 	IF @CNT >10 THEN
			 	LEAVE LOOP1;
		 	END IF;
		UNTIL @CNT >= 100
	END REPEAT LOOP1;
	
	SELECT @TOT AS `SUM`, @CNT AS `CNT`;
END;
	
	
# SQL 프로그래밍에서 오류 발생시 처리용으로 주로 사용
/*

	- 기본형식
	DECLARE < 핸들러 처리 유형 > HANDLER FOR <조건1> [,<조건2>,,,,]
	BEGIN NOT ATOMIC
		실행문1;
		실행문2;
		,,,,,,,
	END
	
	- 핸들러 처리의 유형
		1. CONTINUE : 처리문을 실행하고 현재 프로그램 계속 실행
		2. EXIT : 처리문 실행 후 현재 프로그램 종료
		
	-조건값의 종류
		1. SQLSTATE : SQL상태값
		2. MARIA DB 의 에러코드 : mariadb_error_code
		3. 조건 이름 : condition_name
		4. SQLWARNING
		5. NOT FOUND

*/


#다시확인

BEGIN NOT atomic
	DECLARE exit handler FOR SQLSTATE '23000'
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @SQLSTATE = RETURNED_SQLSTATE,
		@errno = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
		
		SELECT 'pk 오류', @SQLSTATE AS 'sstate', @errno AS 'errno', @msg AS 'msg';
		#SHOW ERRORS;
	END;
	INSERT INTO tbl_member(user_id, user_name, pwd)
	VALUES('user1', '홍길동', '1234');
	SELECT '등록성공' AS 'result_msg', LAST_INSERT_ID() AS 'IDX';
END;
BEGIN NOT atomic
	DECLARE exit handler FOR SQLSTATE '23000'
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @SQLSTATE = RETURNED_SQLSTATE,
		@errno = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
		
		SELECT JSON_OBJECT('result_code', '500', 'result_msg', '사용자 등록실패' 'error_code', 'errno', 'error_msg');
		#SELECT '500' AS 'result_code', '사용자 등록실패' AS 'result_msg', @errno AS 'errno', @msg AS 'error_msg';
		#SHOW ERRORS;
		#SELECT 'pk 오류', @SQLSTATE AS 'sstate', @errno AS 'errno', @msg AS 'msg';
	END;
	INSERT INTO tbl_member(user_id, user_name, pwd)
	VALUES('user1', '홍길동', '1234');
	SELECT '등록성공' AS 'result_msg', LAST_INSERT_ID() AS 'IDX';
END;

/*
BEGIN NOT ATOMIC
	DECLARE EXIT HANDLER FOR SQLSTATE '23000'
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @SQLSTATE = RETURNED_SQLSTATE,
		@errno = MYSQL_ERRNO, @mas = MESSAGE_TEXT;
		SELECT JSON_OBJEC
		
		
		T(
				'RESULT_CODE','500','RESULT_MSG','마일리지 수정실패'
				,
		
		
		SELECT '500' AS 'RESULT_CODE', '사용자등록실패' AS 'RESULT_MSG', @errno AS 'ERRNO', @msg AS 'ERR_MSG'

	END;
	
	INSERT INTO tbl_member(user_id, user_name, pwd)
	VALUES ('user1', '홍길동', '1234' );
	SELECT '등록성공' AS 'RESULT_MSG', LAST_INSERT_ID() AS 'IDX';

END;
*/

# 오류 처리시 오류 정보 불러오는 방법
/*

	- 기본형식
	GET [CURRUNT] DIAGNOSTICS
						[구문속성,,,]
		CONDITION 상태번호 [상태에 따른 조회할 속성 값,,,]
		

*/




# 동적 SQL 문
/*
PREPARE, EXECUTR 암기


	- PREPARE 문은 여러개의 SQL 구문을 하나의  쿼리 문자열로 취급 
		=> 해당 이름에 해당
	- EXECUTR 문은 PREPARE 에 부여된 이름을 사용하여 쿼리문을 실행
	
	- 기본형식
		- prepare 문 지정 : PREPARE prepare이름 from preparable_stmt
		- 실행(execute) : EXCUTE prepare 이름 [using 구문1.,,,]
		- prepare 문으로 정의된 이름 해제
			DEALLOCATE PREPARE prepare 이름
			DROP PREPARE prepare 이름
		
*/


BEGIN NOT atomic

	PREPARE get_member  
		FROM "select user_id, user_name from tbl_member where user_id = 'user1'";
	EXECUTE get_member;
	
END;

#where 조건 동적 처리
# limit ?,? -> 파라미터 추가
BEGIN NOT atomic

	PREPARE get_member  
		FROM "select user_id, user_name from tbl_member limit ?,?";
	EXECUTE get_member  USING 2,3;
	
END;



#e동적 받기
BEGIN NOT atomic
	SET @USER_ID = 'user1';
	PREPARE get_member  
		FROM "select user_id, user_name from tbl_member where user_id =?";
	EXECUTE get_member  USING @USER_ID;
	
END;

#프로시저
BEGIN NOT atomic
	SET @USER_ID = 'user1';
	
	SET @BASCI_SQL = "select user_id, user_name";
	SET @SQL_FROM = "from tbl_member";
	SET @SQL_WHERE_BASCI = "where 1=1";
	SET @SQL_WHERE_CODITION = "AND user_id = ?";
	
	
	SET @FULL_SQL = "";
	SET @FULL_SQL = CONCAT(@FULL_SQL, @BASCI_SQL);
	SET @FULL_SQL = CONCAT(@FULL_SQL, @SQL_FROM);
	SET @FULL_SQL = CONCAT(@FULL_SQL, @SQL_WHERE_BASCI);
	SET @FULL_SQL = 
	
	CONCAT(@FULL_SQL, @SQL_WHERE_CODITION);
	
	PREPARE get_member  
		FROM "select user_id, user_name from tbl_member where user_id =?";
	EXECUTE get_member  USING @USER_ID;
	
	DEALLOCATE PREPARE get_member;

END;
	

#트랜잭션
/*
	- 기본형식
	START TRANSACTION;
	
	실행구문1;
	실행구문2;,,,
	
	COMMIT; -> 성공시 
	ROLLBACK; -> 실패시 복구 
	
	- BEGIN ~ END구문
	BEGIN NOT ATOMIC
		핸들러 등록 ==> 예외 발생 시 ROLLBACK처리
		
		START TRANSACTION;
	
		실행구문1;
		실행구문2;,,,
		
		루틴에 따라 
		IF 조건 then -> 성공시
			COMMIT;
			파라미터 셋팅
		ELSE --> 실패시 복구
			ROLLBACK;
			파라미터 셋팅
		END IF;
		
		리턴값 파라미터
	END;

*/


BEGIN NOT ATOMIC
	DECLARE exit handler FOR SQLEXCEPTION ROLLBACK;
	
	START TRANSACTION
	
	COMMIT;
	
	
END;

SHOW INDEX FROM tbl_member;
SELECT * FROM information_schema.TABLE_CONSTRAINTS;

BEGIN NOT atomic
	DECLARE exit handler FOR SQLEXCEPTION ROLLBACK;
	
	START TRANSACTION;
		SET @MILEAGE = -10;
		SET @USER_ID = 'user1';
		
		PREPARE set_member FROM "UPDATE tbl_member SET mileage = ? WHERE user_id = ?"
		EXECUTE set_member using
		
		DEALLOCATE PREPARE set_member;
	COMMIT;
	
	SELECT * FROM tbl_member WHERE user_id = @USER_ID;
END;


# 지역변수의 사용법
/*

	-기본형식
	DECLAER 변수명1 변수타입 기본값설정

	-특징
	 1. 저장 프로그램 Stored Program 내에서만 사용 가능
	 2. @사용 안함 
	 3. 영문, $ _ 시작
*/


BEGIN NOT ATOMIC

	DECLARE cnt INT DEFAULT 0;
	DECLARE tot INT DEFAULT 0;
	loop1 : loop
		SET cnt = cnt +1;
	
		if cnt > 100 then 
			leave loop1;
		END if;
			
		SET tot = tot + cnt;
	END loop loop1;
	SELECT tot, cnt;
END;

#지역변수를 사용하여 while for 사용

BEGIN NOT ATOMIC

	DECLARE tot INT DEFAULT 0;
	DECLARE cnt INT DEFAULT 0;
	
 
	FOR cnt in 1..100 DO 
	SET tot = tot + cnt;
	END FOR;

	SELECT tot;

END;

BEGIN NOT ATOMIC

	DECLARE tot INT DEFAULT 0;
	DECLARE cnt INT DEFAULT 0;

	while cnt <= 100 do
	
	SET tot = tot + cnt;
	SET cnt = cnt + 1;
	
	END while;

	SELECT tot;

END;


# CURSOR 
/*
	-특징
	 SELECT 결과를 결과 셋에서 순차적으로 가져올 수 있게 하는 프로세스
	
	사용방법
	1. 커서 선언 DECLARE 커서 이름 FOR 실행구문
	2. 반복 조건 설정 : HANDLER 
	3. 커서 열기 : OPEN 커서 이름
	4. 커서에서 데이터 가져오기 : FETCH --> loop(반복처리)
	 	=> 가져온 데이터를 처리
	5. 커서 닫기 : CLOSE
	
	# 사용하지 않아야 하는 이유 속도저하 리소스 많이 사용, 인덱스 안탐, 백업이 힘듬?

	- 기본 형식
		-필수조건 : 지역변수를 선언한 후에 선언해야함
						HANDLER 설정 전에 선언해야함
		
	DECLARE 커서이름 CURSOR FOR 실행구문;
	HANDLER 등록;
	OPEN 커서 이름; 
	FETCH 커서 이름 INTO 변수명,,, --> 반복처리
*/
DESC tbl_member;

BEGIN NOT ATOMIC

	DECLARE JOB_FLAG BOOLEAN DEFAULT FALSE;
	DECLARE pUSER_ID VARCHAR(20);
	DECLARE pUSER_NAME VARCHAR(20);
	
	#1. 커서 선언
	DECLARE mem_cur CURSOR FOR 
		SELECT user_id, user_name FROM tbl_member ORDER BY user_id;
		
	#2. 핸들러 등록 (작업량이 많으면 이렇게 BEGIN ~ END로 묶어준다)
	DECLARE CONTINUE handler FOR NOT FOUND SET JOB_FLAG = true;
		
	#3. OPEN 커서이름
	OPEN mem_cur;
	
	#4. FRTCH, 반복처리
	loop1:loop 
		fetch mem_cur INTO pUSER_ID, pUSER_NAME;
		
		#비즈니스 로직
		if JOB_FLAG then
		leave loop1;
		END if;
		SELECT pUSER_ID, pUSER_NAME;
	END loop loop1;
	
	#5. CLOSE커서이름, 커서 닫기
	CLOSE mem_cur;
END;

#저장 프로시저
/*


	-기본형식
	DELIMITER $$
	CREATE PROCEDURE 프로시저 이름( IN / OUT 매개변수,,,)
	BEGIN 
		실행구문1;
		조건;
		루프;
		,,,,
	END $$
	DELIMITER;
	
	-호출 : CALL프로시저 이름(IN / OUT 매개변수,,,)

*/
DELIMITER $$
CREATE OR REPLACE PROCEDURE USP_test(IN id VARCHAR(20))
BEGIN 
	SELECT user_id, user_name FROM tbl_member WHERE user_id = id;
END $$
DELIMITER;

SET @uID = 'user1';
CALL USP_test(@uID);

DELIMITER $$
CREATE OR REPLACE PROCEDURE USP_test2(in id VARCHAR(20), OUT nm VARCHAR(20))
BEGIN 
	SELECT user_name INTO nm FROM tbl_member WHERE user_id = id;
END $$
DELIMITER;

SET @uID = 'user1';
SET @uNM = '';
CALL USP_test2(@uID,@uNM);
SELECT @uNM AS 'USER_NAME';

#프로시저에 들어가는 루틴..? 정보
SELECT *
FROM information_schema.ROUTINES
WHERE routine_schema = 'books'
AND routine_type = 'PROCEDURE'
;

#프로시저에 들어가는 파라미터 정보
SELECT *
FROM information_schema.PARAMETERS
WHERE specific_schema = 'books'
AND specific_type = 'PROCEDURE'
;

# 시스템에 설정되어있는 모든 정보
# where 조건절 설정시 큰걸앞에 작은거 뒤에.. 
# 만약 타입이 프로시저인걸 먼저보면 시간이더 오래걸림 
# 모수를 줄여준다!
SELECT *
FROM mysql.proc
WHERE db ='books' and `TYPE` = 'PROCEDURE'

#회원가입할떄 프로시저 사용

DELIMITER $$
CREATE OR REPLACE PROCEDURE USP_MEMBER_REGIST(
     in pUserId VARCHAR(20)
	, in pUserName VARCHAR(20)
	, in pPwd VARCHAR(20)
	, out oResult VARCHAR(100)
)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
	GET DIAGNOSTICS
		ROLLBACK;
		SET oResult = -1;
	END;
	
	START TRANSACTION;
	INSERT INTO tbl_member(user_id, user_name, pwd)
	VALUES (pUserId, pUserName, pPwd)
	
	SET oResult = LAST_INSERT_ID();
	
	COMMIT;	
END $$
DELIMITER;

SET @pID = 'user1';
SET @pNAME = '홍길동';
SET @pPWD = '1234';
SET @oRESULT = '';

CALL USP_MEMBER_REGIST(@pID, @pNAME, @pPWD, @oRESULT);

SELECT @oResult;
/*

프로시저 장점
한번 컴파일하면 속도가 빠름
*/

# 트리거 p425
# 트리거가 있으면 데이터베이스 백업이 안된다
# 백업하려면 트리거 지우고 백업하고 복구하고 다시 반영=> 쓰지마라

/*

	- 데이터 베이스에서 특정 이벤트가 발생했을 떄 특정 동작하도록 하는 프로그램하는것
	- 트리거 내에서는 전역변수 사용 불가, 지역 변수만 사용 가능
	- 트리거는 결과셋을 반환하지 않음
	- 외래키 추가 삭제등 작업에 의해 활성화되지 않음
	
	-기본형식
		CREATE [OR REPLACE] TRIGGER 
				트리거 이름 트리거의 동작 시간 트리거가 동작할 이벤트
			on 테이블 이름 for EACH ROW
		트리거에서 실행할 구문;
		
	-트리거의 동작 시간 옶션 값
	 1. AFTER TRIGGER : INSERT, UPDATE, DELETE 문이 실행된 후에 동작하는 트리거
	 2. BEFORE TRIGGER : INSERT, UPDATE, DELETE 문이 실행되기 전에 동작하는 트리거
	

*/
DROP TABLE if EXISTS `TMP_member`;
CREATE TEMPORARY TABLE `TMP_member` (
	user_id VARCHAR(10) NULL,
	user_name VARCHAR(10) NULL,
	pwd VARCHAR(10) NULL
)
COLLATE = 'utf8mb4_general_ci'
ENGINE=INNODB:


DROP TABLE if EXISTS `TMP_TG_TEST`;
CREATE TEMPORARY TABLE `TMP_TG_TEST` (
	contents TEXT NULL,
	event_type VARCHAR(10) NULL,
	reg_date DATETIME NULL DEFAULT NOW()
)
COLLATE = 'utf8mb4_general_ci'
ENGINE=INNODB:


)

DELIMITER $$
CREATE OR REPLACE TRIGGER 
	`TG_MEMBER_TEMP_INSERT` AFTER INSERT ON TMP_memvber FOR EACH row
BEGIN
	DECLARE pContent TEXT;
	SET pContent = CONCAT(NEW.user_id, NEW.user_name, NEW.pwd);
	INSERT INTO TMp_TG_TEXT (contents, event_type)
	VALUES (pContent, 'INSERT')
END $$

DELIMITER;

INSERT INTO  tbl_member2(user_id, user_name, pwd) values ('user100', '홍길동', '1234');
SELECT * FROM TMP_TG_TEST;