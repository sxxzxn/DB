# 데이터 베이스 목록 조회
SHOW DATABASES;

#데이터 베이스 선택
USE books;

#현재 사용중인 데이터 베이스 테이블 조회
SHOW TABLES;

#특정 테이블의 books스키마 조회
DESC tbl_member;

# 테이블 조회 기본 구문
SELECT 컬럼1, 컬럼2
FROM 테이블명
WHERE 조건절
GROUP BY 집계함수 
HAVING GROUP BY 조건절
ORDER BY 정렬순서 
LIMIT 갯수

#데이터 등록 
INSERT INTO 테이블명 (컬럼1, 컬럼2,.,,,)
VALUES (값1,값2,,)

#데이터 수정
UPDATE 테이블명 SET 컬럼1='값1', 컬럼2=2 ( 숫자는 바로 입력 가능 단, 텍스트는 ''로 감싸준다) 
WHERE 조건절( 다른 SQL 들어갈수도)

#데이터 삭제
DELETE 
FROM 테이블명
WHERE 조건절

#테이블 생성
CREATE TABLE 테이블명(
`컬럼명` 데이터타입 NULL허용여부 기본값 COMMENT'설명' COLLATE'utf8mb_general_ci'
primary KEY (`컬럼1`,`컬럼2`) USING BTREE,
INDEX `인덱스이름`(`컬럼1`,`컬럼2`) USING BTREE
)
COMMENT='테이블설명글'
COLLATE='utf8mb_general_ci'
ENGINE=INNODB
;


#ida, int , 자동증가 pk
#ref_idx, int, nn(낫널), defalut 0
#ref_level, tinyint, nn, defalut 0
#ref_order, tinyint, nn, defalut 0
#title, varchar(200) nn
#content, text nn
#reg_date datetime, nn, 기본값 현재시간
#modify_date datetime null
#read_cnt smallint 조회수, 기본값0
#writer, varchar(20), 글쓴사람 아이디
#writer_name varchar(50) 글쓴사람 이름
#writer_emaill, varchar(20), 글쓴사람 이메일
#display_date char(10) null 노출등록일
#user_id varchar(20) 글쓴사람 아이디


SELECT *
FROM tbl_bbs
;

DROP TABLE tbl_bbs;
DESC tbl_bbs;


CREATE TABLE `tbl_bbs`(
 `idx` INT NOT NULL AUTO_INCREMENT COMMENT'인덱스' 
 ,`ref_idx` INT NULL DEFAULT '0' COMMENT'참조글인덱스'
 ,`ref_level` TINYINT NULL DEFAULT '0' COMMENT'글레벨'
 ,`ref_order` TINYINT NULL DEFAULT '1' COMMENT'댓글정렬순서'
 ,`user_id` varchar(20) NOT null COMMENT ' 아이디'
 ,`title` VARCHAR(200) NOT NULL COMMENT'제목'
 ,`content` TEXT NOT NULL COMMENT'내용'
 ,`reg_date` DATETIME NOT NULL COMMENT'등록일' DEFAULT CURRENT_TIMESTAMP()
 ,`display_date` char(10) NULL DEFAULT NULL COMMENT '노출등록일'
 ,`modify_date` DATETIME NULL DEFAULT null  COMMENT'수정일'
 ,`read_cnt` SMALLINT null DEFAULT '0' COMMENT'조회수'
 ,`writer` varchar(20) NOT null COMMENT' 글쓴이 아이디'
 ,`writer_name` VARCHAR(200) NOT null  COMMENT '글쓴이 이름'
 ,`writer_email` VARCHAR(50) NOT null COMMENT  '글쓴사람 이메일'
 ,primary KEY (`idx`) USING BTREE
 )
COMMENT='게시판 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB
;


#댓글관련


#처음 부모레벨 글일때 입력
START TRANSACTION
INSERT INTO `tbl_bbs`(user_id, title, content, read_cnt, writer, writer_name, writer_email, display_date, reg_date)
VALUES ('user3','게시글 테스트제목1', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 

SET @LAST_IDX = LAST_INSERT_ID();

UPDATE tbl_bbs SET ref_idx = @LAST_IDX, ref_level=0, ref_order=0 WHERE idx = @LAST_IDX;


#댓글 등록할 때
# 부모글의 ref_idx = idx, ref_level= 부모글의 ref_level+1, ref_order=부모글의 ref_order+1
START TRANSACTION
UPDATE tbl_bbs SET ref_idx = 부모의 ref_level+1 WHERE ref_idx = 1 AND ref_order>2;

INSERT INTO `tbl_bbs`(ref_idx, ref_level, user_id, title, content, read_cnt, writer, writer_name, writer_email, display_date, reg_date)
VALUES (부모글ref_idx, 부모ref_leverl+1, 'user3','게시글 테스트제목1', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 


#댓글관련
SET @LAST_IDX = LAST_INSERT_ID();

#데이터 9개 더 넣기
START TRANSACTION
INSERT INTO `tbl_bbs` (user_id, title, content, read_cnt, writer, writer_name, writer_email, display_date, reg_date)
VALUES               
('user12','게시글 테스트제목2', '게시글 테스트 내용',0,'user2','홍길순2','hong2@daum.net','2024-08-19',NOW()) 
,('user1','게시글 테스트제목1', '게시글 테스트 내용',0,'user4','홍길순4','hong4@daum.net','2024-08-19',NOW()) 
,('user2','게시글 테스트제목2', '게시글 테스트 내용',0,'user5','홍길순5','hong5@daum.net','2024-08-19',NOW()) 
,('user3','게시글 테스트제목3', '게시글 테스트 내용',0,'user6','홍길순6','hong6@daum.net','2024-08-19',NOW()) 
,('user4','게시글 테스트제목4', '게시글 테스트 내용',0,'user7','홍길순7','hong7@daum.net','2024-08-19',NOW()) 
,('user5','게시글 테스트제목5', '게시글 테스트 내용',0,'user8','홍길순8','hong8@daum.net','2024-08-19',NOW()) 
,('user6','게시글 테스트제목6', '게시글 테스트 내용',0,'user9','홍길순9','hong9@daum.net','2024-08-19',NOW()) 
,('user7','게시글 테스트제목7', '게시글 테스트 내용',0,'user1','홍길순1','hong1@daum.net','2024-08-19',NOW()) 
,('user8','게시글 테스트제목10', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 
,('user9','게시글 테스트제목12', '게시글 테스트 내용',0,'user2','홍길순2','hong2@daum.net','2024-08-19',NOW()) 
,('user10','게시글 테스트제목13', '게시글 테스트 내용',0,'user4','홍길순4','hong4@daum.net','2024-08-19',NOW()) 
,('user11','게시글 테스트제목14', '게시글 테스트 내용',0,'user5','홍길순5','hong5@daum.net','2024-08-19',NOW()) 
,('user12','게시글 테스트제목15', '게시글 테스트 내용',0,'user6','홍길순6','hong6@daum.net','2024-08-19',NOW()) 
,('user13','게시글 테스트제목16', '게시글 테스트 내용',0,'user7','홍길순7','hong7@daum.net','2024-08-19',NOW()) 
,('user14','게시글 테스트제목17', '게시글 테스트 내용',0,'user8','홍길순8','hong8@daum.net','2024-08-19',NOW()) 
,('user15','게시글 테스트제목18', '게시글 테스트 내용',0,'user9','홍길순9','hong9@daum.net','2024-08-19',NOW()) 
,('user16','게시글 테스트제목19', '게시글 테스트 내용',0,'user1','홍길순1','hong1@daum.net','2024-08-19',NOW()) 
,('user17','게시글 테스트제목11', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 
,('user18','게시글 테스트제목22', '게시글 테스트 내용',0,'user2','홍길순2','hong2@daum.net','2024-08-19',NOW()) 
,('user19','게시글 테스트제목23', '게시글 테스트 내용',0,'user4','홍길순4','hong4@daum.net','2024-08-19',NOW()) 
,('user20','게시글 테스트제목24', '게시글 테스트 내용',0,'user5','홍길순5','hong5@daum.net','2024-08-19',NOW()) 
,('user21','게시글 테스트제목25', '게시글 테스트 내용',0,'user6','홍길순6','hong6@daum.net','2024-08-19',NOW()) 
,('user22','게시글 테스트제목26', '게시글 테스트 내용',0,'user7','홍길순7','hong7@daum.net','2024-08-19',NOW()) 
,('user23','게시글 테스트제목27', '게시글 테스트 내용',0,'user8','홍길순8','hong8@daum.net','2024-08-19',NOW()) 
,('user24','게시글 테스트제목28', '게시글 테스트 내용',0,'user9','홍길순9','hong9@daum.net','2024-08-19',NOW()) 
,('user25','게시글 테스트제목29', '게시글 테스트 내용',0,'user1','홍길순1','hong1@daum.net','2024-08-19',NOW()) 
,('user26','게시글 테스트제목21', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 
,('user27','게시글 테스트제목21', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 
,('user28','게시글 테스트제목21', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 
,('user29','게시글 테스트제목21', '게시글 테스트 내용',0,'user3','홍길순','hong@daum.net','2024-08-19',NOW()) 

TRUNCATE TABLE tbl_bbs;

UPDATE tbl_bbs SET ref_idx = idx;


SET @LAST_IDX = LAST_INSERT_ID();
UPDATE tbl_bbs SET ref_idx = @LAST_IDX, ref_level=0, ref_order=0 WHERE idx = @LAST_IDX;

COMMIT;

ROLLBACK;

SELECT *
FROM tbl_bbs
;

#1페이지
SELECT *
FROM tbl_bbs
ORDER BY reg_date DESC, idx desc
LIMIT 0, 5
;

#2페이지
SELECT *
FROM tbl_bbs
ORDER BY reg_date DESC, idx desc
LIMIT 5, 5
;

#3페이지
SELECT *
FROM tbl_bbs
ORDER BY reg_date DESC, idx desc
LIMIT 10, 5
;

#테이블 스키마 초기화
TRUNCATE TABLE tbl_bbs;

#테이블 데이터 삭제
DELETE from tbl_bbs;

#테이블 삭제
DROP TABLE tbl_bbs;

SHOW TABLES;
SELECT * FROM tbl_bbs;

#사용자가 등록한 게시글으 ㅣ갯수를 사용자 아이디 기준으로졍렬하는 쿼리
SELECT COUNT(content), user_id
FROM tbl_bbs
GROUP BY user_id
ORDER BY COUNT(content) desc


#2 사용자가 등록한 게시글 제일 많은사람
SELECT COUNT(content), user_id
FROM tbl_bbs
GROUP BY user_id
ORDER BY COUNT(content) desc
LIMIT 1

# 2번에서 나온 결과와 동일한 결과가 나오도록 서브쿼리
SELECT user_id, COUNT(idx) AS cnt
FROM tbl_bbs
GROUP BY user_id
HAVING cnt >= (
	SELECT MAX(A.cnt)
	FROM (
			SELECT COUNT(idx) AS cnt
			FROM tbl_bbs
			GROUP BY user_id
	) AS A
)

 
(@PAGE_no-1)*@pagesize
 
 SELECT *
 FROM tbL_bbs
 ORDER BY idx desc
 LIMIT 페이지넘버*페이징사이즈, 페이징사이즈;

# LOWER, LCASE 대문자 변환
# UPPER, UCASE 소문자 변환
# LTRIM, RTRIM, RITM 공백 제거 
# CHAR_LENGTH(), LEGNTH(), LENGTHB() 글자 길이값 가져오기
# CONCAT, CONCAT_WS 문자열 연결
# CAST, CONVERT 문자열로 변환

SELECT CAST(reg_date AS CHAR(10)) AS rdate1, CONVERT(reg_date, CHAR(10)) AS rdate2
FROM tbl_bbs
;

#검색어 입력받기
SET @search_word = "제목";
SELECT *
FROM tbl_bbs
WHERE title LIKE CONCAT("'%", trim(@search_word), "%'")
;

SET @search_word = "제목";
SELECT *
FROM tbl_bbs
WHERE title = CONCAT("'", trim(@search_word), "'")
;

SELECT *
FROM tbl_bbs
WHERE title LIKE '%제목%'
;


#INSERT()
SELECT INSERT('내장함수 INSERT 입니ㅊㅇ당', 6, 4,'maria');

#REPEAT(), REPLACE()
SELECT repeat('*',10);
SELECT REPLACE('내장함수', '내장','외장');


#TO_CHAR(데이터, '문자열포맷')
SELECT to_char('2024-08-19 16:30:00', 'HH MI SS');

#날짜값, 증감값
#ADDDATE(), DATE_ADD()
#날짜 비교, 예약일, 결제일, 오픈일, 응모날짜
#현재 날짜 기준으로 31일 더해줘
SELECT ADDDATE(NOW(), 31), DATE_ADD(NOW(),interval 31 DAY);


#CURDATE(), CURREMT_DATE() :현재날짜
SELECT CURDATE(), CURRENT_DATE(), DATE(NOW()), NOW();
SELECT CURtime(), CURRENT_time(), time(NOW());
SELECT YEAR(NOW()), MONTH(NOW()), day(NOW());
#여기서 아래 세개가 동일함
SELECT CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(6); 
#                                    초단위
SELECT LOCALTIME(), LOCALTIMESTAMP(6);
SELECT SYSDATE(), SYSDATE(3);
#앞에서 뒤에 뺀값 출력
SELECT DATEDIFF(NOW(),'2022-03-01'),TIMEDIFF(NOW(),'2022-03-01 23:59:59');
#이거를 문자열로 바꿔주는 함수 많이 사용
SELECT DATE_FORMAT(DATE(NOW()),'%Y-%c-%e');


#테이블/ db내용을 파일로 백업
#이스케이프 문자라 \\두개
SELECT *
INTO OUTFILE 'D:\\datebase\\Data\\tbl_member_20240819.dat'
#					'/home/내계정/~~~/tbl_member_20240819.dat' -->리눅스
FIELDS TERMINATED BY '||' ENCLOSED BY '"'
FROM tbl_member;

#외부파일에서 -> 테이블로 복원
LOAD DATA LOCAL INFILE 'D:\\datebase\\Data\\tbl_member_20240819.dat'
INTO tbl_member
FIELDS TERMINATED BY '||' ENCLOSED BY '"';



#IFNULL(), NVL() 앞에가 널이면 뒤에걸로 대체해줘
#NULLIF(값1, 값2), NVL2() -> 값1=값2 -> true =>case when 값1=값2 then null else end
SELECT IFNULL(job_code, '기타') AS IFNULL1,
		 NULLIF(job_code, '기타') AS nullif1
FROM tbl_member
ORDER BY user_id;

SELECT *
FROM tbl_member;

# 레코드 ROW 카운트 함수
# ROWNUM() --> 데이터베이스에서 가져온 줄의 번호(테이블에서는 보이지 않음)
# ROW_COUNT() -->데이터/ 들록/수정 삭제시에 영향받는 ROW수
SELECT rownum(),M.*
FROM tbl_member AS M
;

INSERT INTO `tbl_bbs` (user_id, title, content, read_cnt, writer, writer_name, writer_email, display_date, reg_date)
VALUES               
('user12','게시글 테스트제목2', '게시글 테스트 내용',0,'user2','홍길순2','hong2@daum.net','2024-08-19',NOW()) 
INSERT INTO `tbl_bbs` (user_id, title, content, read_cnt, writer, writer_name, writer_email, display_date, reg_date)
VALUES               
('user12','게시글 테스트제목2', '게시글 테스트 내용',0,'user2','홍길순2','hong2@daum.net','2024-08-19',NOW()) 

SELECT ROW_COUNT(), LAST_INSERT_ID();

#JSON_OBJECT() 함수 --> 테이블의 내용 -> json 객체 형식으로 리턴
SELECT josn_object(
	"컬럼명"-->키값
	, 컬럼값 --> value
) AS js
FROM tbl_member
ORDER BY idx DESC
;


SELECT JSON_OBJECT(
	`user_id`,user_id
	,`user_name`,user_name
	,`pwd`, pwd
	,`reg_date`,reg_date
) AS js
FROM tbl_member
ORDER BY idx DESC
;