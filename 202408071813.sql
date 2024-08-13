
USE books;
SHOW TABLES;

#컴퓨터 이름(ip).`데이터베이스`.소유자.테이블

SELECT * 
FROM tbl_member;

#예약어
#DML
#DDL
#DCL
#TCL
# 식별자 작성 규칙(변수명, 테이블명, 칼럼명)
/*

-0~9,a~z,A~Z,$,_ 문자사용 가능 ( 
 $, _ ~ => 시스템에서 사용하는 함수 , 프로시저
 시작 문자  영문자, __(언더바 두개!)

-식별자으 ㅣ인용문자 : 백틱(`),backtick
-예약어 사용 불가, Reserved Word
-이름(변수)의 최대 길이 64글자
-알기 쉬운 단어 사용, 단어 약자는 누구나 알 정도로 명쾌할 경우에만
- 복합 단어: 단어와 단어 사이에 _ 를 사용, 카멜표기법

*/

/*
INSERT : 데이블을 등록하는 기능
INSERT INTO {데이터베이스명`} 테이블명(컬럼명1,컬럼명2,,,,)VALUES(값1,값2,,,);




*/

desc tbl_member;

INSERT INTO tbl_member( user_id,user_name,pwd) VALUES ('user1','홍길동','1234');


/*
데이터 조회 기분 문법
SELECT 컬럼1, 컬럼2,,,,
FROM {`데이터베이스명`}.테이블명
*/



SELECT  *
FROM tbl_member;



tbl_member