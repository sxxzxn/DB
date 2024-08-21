# 서브쿼리
# SELECT, INSERT, UPDATE, DELETE 등의 쿼리안에 
# 쿼리문이 중첩되는 SELECT 쿼리문
# 단일 행 서브 쿼리 

USE books;

SELECT * 
FROM tbl_member;


SELECT * 
FROM tbl_member
WHERE user_id in (SELECT user_id FROM tbl_order_info LIMIT 5)
;

SELECT version();

# 데이터의 타입이 다르다
# user_id sms VARCHAR(20) : 'ABCD' <== [USER1,USER2,]
# 서로 비교하는 데이터의 구조가 다름
# = 이 아니라 in을 사용하면 된다


# EXISTS
# 리턴된 결과값이 있다 없다로 판단가능
# OI와 MB의 사이 연관관계 확인
# 단.. 이런거 하면 데이터가 잘못설계된거다
# 그래서 확인용이고 실제 쿼리는 아님

SELECT *
FROM tbl_member
WHERE (user_id)  ==> TRUE/FALSE 


SELECT *
FROM tbl_order_info AS OI
WHERE NOT EXISTS(
		SELECT * FROM tbl_member AS MB WHERE OI.user_id = MB.user_id
)

SELECT *
FROM tbl_order_info AS OI
WHERE EXISTS(
		SELECT * FROM tbl_member AS MB WHERE OI.user_id = MB.user_id
)



# 주문 안한회원 
# 쿠폰 증정
SELECT *
FROM tbl_member AS MB
WHERE NOT EXISTS(
		SELECT * FROM tbl_order_info AS OI WHERE OI.user_id = MB.user_id
)


SELECT * FROM tbl_order_info
SELECT * FROM tbl_order_detail_info;

INSERT INTO tbl_order_info ( order_no, user_id, order_date, order_amount, reg_date, cancelYN)
VALUES
( '202408110001', 'user00', '20240811', 3, '2024-08-11 12:00:00', 'N')
,( '202408120001', 'user01', '20240812', 3, '2024-08-12 12:00:00', 'N')
,( '202408130001', 'user02', '20240813', 3, '2024-08-13 12:00:00', 'N')
,( '202408150001', 'user0', '20240814', 3, '2024-08-15 12:00:00', 'N')
,( '202408190001', 'user0', '20240819', 3, '2024-08-19 12:00:00', 'N')
;

# 주문정보 테이블에는 존재하고, 회원테이블에는 존재하지않는
# 회원의 주문 정보를 출력하는 쿼리( 서브쿼리 사용)

SELECT *
FROM tbl_order_info AS OI
WHERE NOT EXISTS (
SELECT * FROM tbl_member AS MB WHERE OI.user_id = MB.user_id)


SELECT *
FROM tbl_order_info AS OI
LEFT OUTER JOIN tbl_member AS MB on OI.user_id = MB.user_id
WHERE MB.user_id IS NULL


# 상품정보는 존재하지만 판매된적이 없는 상품정보를 출력하는 쿼리

SELECT * FROM tbl_goods_info;
SELECT * FROM tbl_order_detail_info;
SELECT * FROM tbl_order_info;
SELECT * FROM tbl_unitcode_info;

SELECT *
FROM tbl_goods_info AS GI
WHERE NOT EXISTS(
SELECT * FROM tbl_order_detail_info AS OD where GI.goods_code = OD.goods_code)

SELECT *
FROM tbl_goods_info AS GI
LEFT OUTER JOIN tbl_order_detail_info AS OD on GI.goods_code = OD.goods_code
WHERE GI.goods_code IS NULL


# 판매된적이 있는 상품 정보만 출력하는 쿼리

SELECT *
FROM tbl_goods_info AS GI
WHERE EXISTS (
SELECT * FROM tbl_order_detail_info AS OD WHERE GI.goods_code=OD.goods_code
)

#DISTINCT 사용 가능
SELECT DISTINCT GI.*
FROM tbl_goods_info AS GI
INNER JOIN tbl_order_detail_info AS OD on GI.goods_code = OD.goods_code

# 회원 정보 테이블에서 주소 정보가 서울에 살고 있는 회원의 
# 직업 코드보다 (가장 작은) 크거나 같은
# 직업 코드보다 크거나 같은 회원 정보를 가져오는 쿼리
# 


SELECT * FROM tbl_member;

SELECT
FROM (SELECT * FROM tbl_member WHERE addr1 LIKE '%서울%') AS s
WHERE ;

SELECT *
FROM tbl_member
WHERE job_code >= any (SELECT job_code FROM tbl_member WHERE addr1 LIKE '%서울%')
;
SELECT *
INTO OUTFILE 'D:\\java7\\mariadb\\tbl_order_info_20240820.dat'
FIELDS TERMINATED BY '||' ENCLOSED BY '"'
FROM tbl_order_info
;
SELECT *
INTO OUTFILE 'D:\\java7\\mariadb\\tbl_goods_info_20240820.dat'
FIELDS TERMINATED BY '||' ENCLOSED BY '"'
FROM tbl_goods_info
;

# delete 구문에서 서브쿼리 사용
# 주문 정보에는 존재하고, 회원 테이블에는 존재하지 않는 회원의 아이디를 
# 가져오는 쿼리 작성

SELECT OI.user_id
FROM tbl_order_info AS OI
WHERE not EXISTS (
SELECT MB.user_id FROM tbl_member AS MB WHERE MB.user_id = OI.user_id)

START TRANSACTION
DELETE FROM tbl_order_info 
WHERE user_id IN  (
	SELECT OI.user_id
	FROM tbl_order_info AS OI
	WHERE NOT EXISTS (
		SELECT MB.user_id FROM tbl_member AS MB WHERE MB.user_id = OI.user_id
		)
)
;



ROLLBACK;
SELECT *
FROM tbl_order_info ;


# ANY, ALL, EXISTS
# IN, NOT IN

# INSERT절에서 서브쿼리 사용
# 데이터 타입이 같으면 사용 가능
# 스키마 복제 x
INSERT INTO 대상테이블(컬럼1,,,)
SELECT 컬럼1,컬럼2,,,FROM 원본테이블

DROP TABLE tbl_member2;


CREATE TABLE tbl_member2(
SELECT * FROM tbl_member);

SELECT * FROM tbl_member2

#전제조건 : 컬럼의 갯수 동일해야함, 매칭되는 컬럼은 데이터 타입이 동일해야함

# UNION 
# 합집합
# select 1
# union
# select 2
# INTERSECT 
# 교집합
# EXCEPT 
# 차집합

# 첫번째꺼 기준으로 별칭이 들어감
SELECT user_id, user_name FROM tbl_member
UNION all
SELECT user_id, user_name FROM tbl_member2
ORDER BY ;
