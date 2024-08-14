USE books;

SELECT *
FROM tbl_common_code;

SELECT MB.user_id, MB.user_name, MB.ssn, MB.job_code
		,CC.common_name
FROM tbl_member AS MB
LEFT OUTER JOIN tbl_common_code AS CC
					ON MB.job_code = CC.common_code AND  CC.group_code = '100'
;

#상품단위코드가 02 _> 공통코드테이블 02 매치되는
#주문 정보, 상품정보, 코드정보, 회원정보
#조회하는 쿼리


SELECT *
FROM tbl_common_code;

SELECT *
FROM tbl_member;books

SELECT *
FROM tbl_order_detail_info;

SELECT *
FROM tbl_order_info;


SELECT  MB.*, OI.* 
FROM tbl_member AS MB
INNER JOIN tbl_order_info AS OI ON MB.user_id = OI.user_id
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
INNER JOIN tbl_common_code AS CC ON OD.unit_code = CC.common_code AND CC.group_code='200'
;


SELECT OI.order_no, OI.order_date, OI.cancelYN
, GI.goods_code, GI.goods_name, GI.unit_code, CC2.common_name AS goods_unit_code_name
, MB.user_id, MB.user_name, MB.job_code, CC.common_name AS job_name
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
LEFT OUTER JOIN tbl_goods_info AS GI ON OD.goods_code = GI.goods_code
LEFT OUTER JOIN tbl_member AS MB ON MB.user_id = OI.user_id
LEFT OUTER JOIN tbl_common_code AS CC ON MB.job_code = CC.common_code 
					AND CC.group_code='100'
LEFT OUTER JOIN tbl_common_code AS CC2 ON GI.unit_code = CC2.common_code 
					AND CC2.group_code='200'
;					


#서브쿼리(Sub Query) = 중첩쿼리
#쿼리1=(쿼리2)
# SELECT, INSERT, UPDATE, DELETE 등 쿼리 구문안에 쿼리가 포함, 
#중첩되는 SELECT쿼리문
#단 그룹, 정렬은 불가

SELECT *
 FROM (
	SELECT * FROM tbl_member WHERE user_id LIKE '%ser%'
) AS a;

SELECT *
FROM tbl_member
WHERE user_id IN( SELECT user_id FROM tbl_member WHERE user_id LIKE '%r1%');


SELECT *
FROM tbl_member
WHERE user_id IN(SELECT user_id FROM tbl_member)
;

SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;
/*
SELECT
FROM tbl_order_info AS OI
LEFT OUTER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
WHERE OI.order_no(
*/

# 1. 주문 정보 테이블에는 존재하고, 주문 상세정보가 없는 주문 정로를 
# 가져오는 쿼리 서브쿼리를 이욯해  작성하세요.

SELECT *
FROM tbl_order_info
WHERE order_no NOT IN (SELECT order_no FROM tbl_order_detail_info)
;

SELECT *
FROM tbl_order_info AS OI
WHERE order_no NOT IN 
(SELECT order_no FROM tbl_order_detail_info AS OD
WHERE OD.order_no = OI.order_no
)
;

SELECT OI.order_no, OD.order_no
FROM tbl_order_info AS OI
LEFT OUTER JOIN tbl_order_detail_info AS OD ON OI.order_no=OD.order_no 
WHERE OD.order_no IS NULL

SET profiling = 1;
SHOW PROFILES l;

EXPLAIN

#주문 정보 테이블에서 회원 테이블에 존재하는 회원의 아이디를 출력
#exists 사용

SELECT DISTINCT user_id
FROM tbl_order_info 
WHERE EXISTS ( SELECT user_id FROM tbl_member );


SELECT DISTINCT OI.user_id 
FROM tbl_order_info AS OI
INNER JOIN tbl_member AS MB ON OI.user_id = MB.user_id;

#주문 정보에는 존재하고 주문 상세 테이블에는 없는 정보를 출력하는 쿼리 
#exists 사용

SELECT *
FROM tbl_order_info AS OI
WHERE NOT EXISTS (SELECT order_no FROM tbl_order_detail_info AS OD
WHERE OD.order_no = OI.order_no);

SELECT OI.order_no, OD.order_no
FROM tbl_order_info AS OI
LEFT OUTER JOIN tbl_order_detail_info AS OD ON OI.order_no=OD.order_no 
WHERE OD.order_no IS NULL;

USE employees;

#salaries 테이블에서 salary가 158000  초과하는 직원번호를 조회하고
#해당직원을 제외한 매출정보를 출력하는 쿼리
#exists 사용


SELECT *
from salaries
WHERE salary>158000;


SELECT *
FROM salaries AS S1
WHERE EXISTS ( SELECT * FROM salaries AS S2 
WHERE S1.salary=S2.salary AND S2.salary>158000);


SELECT SUM(salary)
FROM salaries
WHERE emp_no NOT IN(43624);

USE books;
# 컬럼 오류 확인하기!!
SET @jobCODE ='';
SELECT @jobCODE := MIN(job_code);

SELECT *
FROM tbl_member
WHERE job_code >= ANY (
SELECT job_code FROM tbl_member WHERE addr1 LIKE '%인천%'
)
;

SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;


#
START TRANSACTION;

SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;

DELETE 
FROM tbl_order_info
WHERE order_no = '202408070001';


SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;


tbl_order_info

DELETE 
FROM tbl_order_info
WHERE order_no = '202408070001';


COMMIT;

ROLLBACK;

#
START TRANSACTION;
SELECT * FROM tbl_member;

UPDATE tbl_order_info SET user_id = 'user100'
				 WHERE order_no = '202408070001';
				 
ALTER TABLE `tbl_order_


START TRANSACTION;
SELECT * FROM tbl_order_info;

DELETE FROM tbl_order_info
WHERE user_id IN(
	SELECT user_id FROM tbl_order_info AS IOI
	WHERE NOT EXISTS (
		SELECT user_id FROM tbl_member AS IMB 
		WHERE IOI.user_id = IMB.user_id
	)
);

SELECT * FROM tbl_order_info;
SELECT *FROM tbl_member


COMMIT
ROLLBACK
#


START TRANSACTION;
DELETE 
FROM tbl_order_info
WHERE order_no = '202408070001';


DELETE FROM tbl_order_detail_info
WHERE order_no IN(
	SELECT order_no FROM tbl_order_detail_info AS IOD
	WHERE NOT EXISTS (
		SELECT order_no FROM tbl_order_info AS IOI
		WHERE IOD.order_no = IOI.order_no
	)
);
SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;


COMMIT;
ROLLBACK;

TRUNCATE TABLE tbl_member2;
DESC tbl_member2;

SELECT * FROM tbl_member2;

INSERT INTO tbl_member2(
user_id, user_name,pwd,job_code
)
VALUES(
'test1','tesT1','1234', '02'
)
;

SELECT *FROM tbl_member;
SELECT *FROM tbl_member;

#UNION : 합집합
#A랑 B의 컬럼을 합쳐라
#단 컬럼수, 순서 타입이 동일해야함
SELECT A
UNION 
SELECT B
;

SELECT '1' AS separate, user_id 
FROM tbl_member
UNION ALL
SELECT '2' AS separate, user_id 
FROM tbl_member2;

#execept
SELECT *FROM tbl_member
execept
SELECT *FROM tbl_member2
ORDER BY user_name
;

#intersect
SELECT *FROM tbl_member
intersect
SELECT *FROM tbl_member2
ORDER BY user_name
;


# 1. member에만 있는 회원 정보를 조회하는 쿼리 작성
# 서브쿼리 사용
# 2. member2에만 있는 회원정보를 조회하는 쿼리 작성
# 서브쿼리 사용
# 두 데이터를 합쳐서 보여주는 쿼리 작성
# 중복데이터 노출
# 중복데이터 제거

SELECT DISTINCT A.*
FROM(
	SELECT *
	FROM tbl_member 
	WHERE user_id NOT IN ( SELECT user_id FROM tbl_member2)
	UNION 
	SELECT *
	FROM tbl_member2
	WHERE user_id NOT IN ( SELECT user_id FROM tbl_member)
) AS A


#tbl_member2에 있고 tbl_member에는 없는 회원정보를 가져오는 쿼리
# 1. innerjoin
# 2. outerjoin

SELECT * FROM tbl_member2 WHERE user_id NOT IN(
SELECT MB2.user_id
FROM tbl_member2 AS MB2
INNER JOIN  tbl_member AS MB ON MB2.user_id = MB.user_id 
)

# 집계 함수
# 합계 : SUM
# 평군 : AVG
# 갯수 : COUNT

USE employees;

SELECT * FROM employees LIMIT 100;
SELECT * FROM departments LIMIT 100;
SELECT * FROM dept_emp LIMIT 100;
SELECT * FROM dept_manager LIMIT 100;
SELECT * FROM salaries ORDER BY from_date desc LIMIT 100;

#22년도 8월 매출금액 합계
SELECT SUM(salary) AS sum_sal
FROM salaries
WHERE from_date BETWEEN '2022-08-01' AND '2022-08-31';


# 22년도 월별 매출 금액 합계를 구하는 쿼리

SELECT MONTH(from_date) AS mon, SUM(salary) AS sum_sal
FROM salaries
WHERE from_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY mon
;

#21년도 분기별 매출 금액 부서별로 출력
SELECT DP.dept_no, DP.dept_name , quarter(SA.from_date) AS qtr, SUM(SA.salary) AS at_sal
FROM salaries AS SA
INNER JOIN dept_emp AS DE ON SA.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
WHERE SA.from_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY DP.dept_no, qtr
;


# 2021 부서별 매니저 연평균 매출 금액을 출력하는 쿼리
SELECT DM.emp_no AS '매니저번호', DP.dept_name AS '부서이름', AVG(SA.salary) AS '년평균'
from salaries AS SA
INNER JOIN dept_emp AS DE ON SA.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
INNER JOIN dept_manager AS DM ON DP.dept_no = DM.dept_no
WHERE SA.from_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY DM.emp_no, DP.dept_name
;

SELECT DM.dept_no, DM.emp_no, AVG(SL.salary) AS avg_sal
FROM salaries AS SL
INNER JOIN dept_manager AS DM ON SL.emp_no = DM.emp_no
WHERE SL.from_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY DM.dept_no, DM.emp_no
;


SELECT DM.emp_no AS '매니저번호', AVG(SA.salary) AS '매니저별 년평균'
FROM salaries AS SA
INNER JOIN dept_emp AS DE ON SA.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
INNER JOIN dept_manager AS DM ON DP.dept_no = DM.dept_no
WHERE SA.from_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY DM.emp_no
;

#2021년, 부서별로 부서 내에서 최대 매출을 올린 직원, 최저 매출직원

SELECT DP.dept_name, EM.last_name, SUM(SA.salary) AS sum_sal, MIN(SA.salary), MAX(SA.salary)
FROM salaries AS SA
INNER JOIN dept_emp AS DE ON SA.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
INNER JOIN employees AS EM ON DE.emp_no = EM.emp_no
WHERE SA.from_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY DP.dept_name
;

SELECT DP.dept_name, EM.last_name, MIN(sum_sal), MAX(sum_sal)
FROM salaries AS SA
(
SELECT SUM(salary) AS sum_sal FROM salaries 
)
INNER JOIN dept_emp AS DE ON SA.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
INNER JOIN employees AS EM ON DE.emp_no = EM.emp_no
WHERE SA.from_date BETWEEN '2021-01-01' AND '2021-12-31'


SELECT 
A.dept_no, A.emp_no, A.sum_sal
FROM(
SELECT DP.dept_no, DP.dept_name,EM.emp_no, SUM(salary) AS sum_sal
FROM salaries as SL
INNER JOIN dept_emp AS DE ON SL.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
INNER JOIN employees AS EM ON DE.emp_no = EM.emp_no
WHERE SL.from_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY DP.dept_no,EM.emp_no
ORDER BY DP.dept_name,sum_sal DESC
) AS A
ORDER BY A.dept_no, A.sum_sal desc
LIMIT 1
;
