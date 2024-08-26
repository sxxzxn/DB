# 20240826

# 시그널

/*

	-특징
		-진단영역(diagnostics area)을 비우고 사용자 정의 오류를 생성할 떄 사용
		- 주로 핸들러, 트리거, 프로시저 등에서 사용
		
*/

SHOW TRIGGERS FROM books;
SHOW CREATE TRIGGER;

# 저장 함수 (Stored Function)
/*
	-기본 형식
	CREATE [OR REPLACE]
	FUNCTION 항수명(매개변수1,,,)
	RETURNS 리턴타입
		실행구문 1;
		실행구문 2,....
		;
	RETURN 리턴할 내용(FUNC_BODY)
	
	
	-요약형식
	CREATE [OR REPLACE] FUNCTION 항수명(매개변수1,,,)
	RETURNS 반환 데이터 타입
	BEGIN
	 실행구문1;
	 실행구문2,,,;
	 RETURN{반환값|표현식}
	END$$

	-특징 
		1. 매개변수에 IN,OUT 키워드 사용하지 않은
		2. 내장 함수 호출과 동일하게 함수명으로만 호출
		 <--> 프로시저는 호출시에 CALL 사용
		3. 함수 내에서 SELECT 사용시 단일행의 결과만 리턴 가능
		4. 결과 셋을 반환할 수 없음.(=여러줄 리턴 불가)
		5. 재귀적으로 사용 할 수 없음
		6. 함수 내에서 COMMIT, ROLLBACK 할 수 없음 --> 트랜잭션 사용 불가
		7. PREPARE, EXECUTE, DEALLOCATE PREPARE문을 사용할 수 없다
		
	단 반환할 값이 많은땐 프로시저, 하나면 함수 (=단순 결과값 리턴, 동적 쿼리 프로그래밍 안됌)
	
	-권한 확인
	SHOW VARIABLES WHERE variable_name LIKE '%log_bin%' ; 
		
*/
#프로시저 확인
# where절에 디비명 명시하고, 타입에 프로시저를 기록해 디비 부하를 줄여줌
#
SHOW VARIABLES WHERE variable_name LIKE '%log_bin%' ; 
SELECT * FROM mysql.proc WHERE db = 'books' AND TYPE ='PROCEDURE';
SELECT * FROM mysql.proc WHERE db = 'books' AND TYPE ='FUNCTION';


SHOW create PROCEDURE USP_test;


DELIMITER $$
CREATE FUNCTION FN_SUM( v1 INT, v2 INT)
	RETURNs int
BEGIN
	RETURN v1+v2;
END $$
DELIMITER ;


SELECT FN_SUM(10,20) AS INT_SUM;

# 색인
/*
	장단점
	 1. 검색 속도의 향상 장점
	 2. 쿼리의 대한 부하 감소로 시스템 성능을 향상시키 수 있음 단점
	 3. 색인에 대한 별도의 저장소의 사용량이 증가할 수 있음
	 4. 데이터 양이 증가할 수록 색인 생성에 시간이 많이 소요 될 수 있음
	 5. 데이터의 변경(입출입,삭제,변경)이 많을 경우 성능 저하를 일으킬 수 있음
	 ( 색인은 최대 256개까지 설정 가능하나, 10개정도만 지정)
	 
	종류
	- 클러스터형 색인(Clustered Index) : 기본키 PRIMARY KEY
	- 비클러스터드 색인 (Non Clustered Index) : 오프라인 책의 색인과 같은 의미
	
	- Unique Index : 색인의 값이 중복 허용 안함
	- Non Unique Index : 색인의 값이 중복을 허용함

종류는 크게 클러스트 프라이머리키  넌클러스터드 포링키/ 유니크 인덱스(pk) 넌 유니크인덱스(일반 인덱스+포링키)
*/

SHOW INDEX FROM tbl_member;

SHOW TABLE STATUS LIKE '%member%';

#색인 생성 기본 구문
/*
	- 기본구문
	 CREATE [OR REPLACE] [unique|fulltext|spatial] INDEX 인덱스 이름
	 ON 적용할 테이블명 (적용할 컬럼1)

	- 인덱스를 고려해야할 컬럼
	 1. where 조건절에 빈번히 나오는 컬럼
	 2. select 절에서 연산이 빈번히 일어나는 컬럼
	 
	 
	- 인덱스 수정(인덱스 삭제 후 재 작성)
	ALTER TABLE 테이블명 DROP INDEX 인덱스명;
	
	- 인덱스 삭제
	DROP INDEX 인덱스명 ON 테이블명;
	
	- 인덱스 변경 후 정보 업데이트
	 ANALYZE TABLE 테이블명; 
	 ( 속도에 민감한 데이터 다룰 떄 기본적으로 색인으ㅜㄹ 추가한다)
*/
CREATE INDEX `idx`( 