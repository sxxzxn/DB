# INTERSECT
# INTERSECT 절 앞의 select 쿼리문의 결과 <-->
# INTERSECT 절 뒤의 select 쿼리문의 결과 셋에서 같은행(중복되는 행) 만 
# 결과셋 에 출력 --> 교집합


# 기본구문
# 컬럼의 갯수, 순서, 데이터 타입 동일해야함
# 현업에서는 셀렉트 뒤 쿼리문이 길어져 한줄 띄어준다
# A의 결과 = B의 결과 --> UNION DISTINCT와 동일

/*
UNION 의 기본설정이 UNION DISTINCT인 이유!
속도 향상이 목적
그래서 다 보고 싶으면 UNION ALL 기재
INTERSECT도 다 보고 싶으면 ALL 붙여주기
ALL이 없는 기본으로 사용시 자동으로 DISRINCT 설정

단
INTERSECT의 결과가 innerjoin와 동일하다면
innerjoin을 사용한다...
union, INTERSECT 은 인덱스틀 타지않아 속도가 느려짐
*/


SELECT 컬럼의 갯수, 순서, 데이터 타입 동일

INTERSECT

SELECT 컬럼의 갯수, 순서, 데이터 타입 동일
;

DESC tbl_member;

SELECT user_id, user_name,job_code, reg_date
FROM tbl_member

INTERSECT 

SELECT user_id, user_name,job_code, reg_date
FROM tbl_member2
;



# 주문 상세 테이블에서 주문내역이 없는 회원정보를 출력하는
# 쿼리를 INTERSECT와 서브쿼리를 이용해 작성해보세요


SELECT * FROM tbl_order_info;
SELECT * FROM tbl_member;


SELECT user_id
FROM tbl_member

WHERE user_id not IN(

	SELECT user_id FROM tbl_order_info
	
	INTERSECT 
	
	SELECT user_id FROM tbl_member
)

# 2. join문을 이용해 작성

SELECT MB.*
FROM tbl_order_info AS OI
right outer JOIN tbl_member AS MB ON OI.user_id = MB.user_id
WHERE OI.user_id IS NULL
;

# 3. exists 서브쿼리를 이용해 주문정보를 가져온 후 intersect를 이용하는 쿼리 작성

EXPLAIN
SELECT user_id
FROM tbl_member MB
WHERE NOT EXISTS (
    SELECT *
    FROM (
        SELECT user_id 
        FROM tbl_order_info 
        
        INTERSECT 
        
        SELECT user_id 
        FROM tbl_member
    ) as ITS
    WHERE ITS.user_id = MB.user_id
);

SELECT *
FROM tbl_member MB
WHERE NOT EXISTS (
SELECT *
FROM(
SELECT user_id from tbl_order_info 

INTERSECT

SELECT user_id FROM tbl_member)
AS sub
WHERE sub.user_id = MB.user_id
) 


# EXCEPT
# EXCEPT 절 앞의 select 결과셋에서
# EXCEPT 절 뒤의 select 결과셋을 제외한 결과 셋만 리턴
# 앞에꺼에서 뒤에꺼 빼주는거 
SELECT * FROM tbl_member

EXCEPT

SELECT * FROM tbl_member2 WHERE addr1 LIKE '%서울%'
;


# 집계함수
# SUM : 합계
# MIN : 최소값
# MAX : 최대값
# AVG : 평균값
# COUNT : 갯수

SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;
desc tbl_order_info;

#주문일자별 주문 갯수의 종합을 출력하는 쿼리 작성

SELECT SUM(order_amount) AS sumor, order_date
FROM tbl_order_info
GROUP BY order_date
;

# user1이 8월에 주문한 전체 금액의 합계 금액
# user1이 주문한 금액중 최소금액, 최대 금액, 평균금액
# user1이 주문한 주문 횟수를 구하는 쿼리

# 등급추가..!

SELECT OI.user_id
		,SUM(OD.order_amount)AS top
		,MAX(OD.order_amount) AS maxp
		,MIN(OD.order_amount) AS minp
		,COUNT(OI.order_no) AS 8cnt
		,AVG(OD.order_amount) AS tavg
		,case
		 	  WHEN AVG(OD.order_amount) < 1000  THEN 'A'
           WHEN AVG(OD.order_amount) >= 1000 AND AVG(OD.order_amount)<2000 THEN 'B'
           WHEN AVG(OD.order_amount) >= 2000 AND AVG(OD.order_amount)<3000 THEN 'C'
           WHEN AVG(OD.order_amount) >= 3000 AND AVG(OD.order_amount)<4000 THEN 'D'
           ELSE 'E'
       END AS user_grade
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
WHERE SUBSTR(OI.order_date,5,2) = '08' 
GROUP BY OI.user_id
;

# GROUP BY와 동일하게 결과 가져올수있음
SELECT DISTINCT OI.user_id, SUM(OI.order_amount) OVER (partition BY OI.user_id) AS tot 
FROM tbl_order_info AS OI
;

# 사용자 별 -> 날짜별(일별) 변경

SELECT SUBSTR(OI.order_date,7,2) AS da
		,SUM(OD.order_amount)AS top
		,MAX(OD.order_amount) AS maxp
		,MIN(OD.order_amount) AS minp
		,COUNT(OI.order_no) AS 8cnt
		,AVG(OD.order_amount) AS tavg
		,case
		 	  WHEN AVG(OD.order_amount) < 1000  THEN 'A'
           WHEN AVG(OD.order_amount) >= 1000 AND AVG(OD.order_amount)<2000 THEN 'B'
           WHEN AVG(OD.order_amount) >= 2000 AND AVG(OD.order_amount)<3000 THEN 'C'
           WHEN AVG(OD.order_amount) >= 3000 AND AVG(OD.order_amount)<4000 THEN 'D'
           ELSE 'E'
       END AS order_date_grade
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
WHERE DATE_FORMAT (OI.order_date, '%m') = '08' 
GROUP BY SUBSTR(OI.order_date,7,2)
;

WHERE DATE_FORMAT (OI.order_date, '%m')

SELECT OI.order_date
		,SUM(OD.order_amount)AS top
		,MAX(OD.order_amount) AS maxp
		,MIN(OD.order_amount) AS minp
		,COUNT(OI.order_no) AS 8cnt
		,AVG(OD.order_amount) AS tavg
		,case
		 	  WHEN AVG(OD.order_amount) < 1000  THEN 'A'
           WHEN AVG(OD.order_amount) >= 1000 AND AVG(OD.order_amount)<2000 THEN 'B'
           WHEN AVG(OD.order_amount) >= 2000 AND AVG(OD.order_amount)<3000 THEN 'C'
           WHEN AVG(OD.order_amount) >= 3000 AND AVG(OD.order_amount)<4000 THEN 'D'
           ELSE 'E'
       END AS user_grade
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
WHERE SUBSTR(OI.order_date,5,2) = '08' 
GROUP BY OI.order_date
;

# day -> 는 주에서 요일 순서를 가져오는거
# date 가 날짜를 가져오는거 

SELECT * FROM tbl_order_info

SELECT OI.order_no, OI.order_amount, SUM(OD.order_cnt) AS ad_sum
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
GROUP BY OI.order_no
;


SELECT * 
INTO OUTFILE 'D:\\java7\\mariadb\\tbl_order_info_20240821.dat'
FIELDS TERMINATED BY '||' ENCLOSED BY '"'
FROM tbl_order_info
;

# 모든 order_amount 1로 변경
UPDATE tbl_order_info SET order_amount = 1;


START TRANSACTION;
UPDATE tbl_order_info AS OI 
		SET OI.order_amount =IFNULL( (
		select sum(OD.order_cnt) FROM tbl_order_detail_info AS OD
		WHERE OI.order_no = OD.order_no 
	),0)
;

SELECT * FROM tbl_order_info;

COMMIT;

SELECT * FROM tbl_order_info;
#tbl_order_info에 컬럼추가 order_tot_amount int not null comment 전체 주문 금액

# order_tot_amount 컬럼의 값을 서브쿼리를 이용해
# tbl_order_detail_info 주문 금액 합으로 수정하는 쿼리


START TRANSACTION;
SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;


UPDATE tbl_order_info AS OI 
SET OI.order_tot_amount = IFNULL( (
		SELECT SUM(OD.order_amount) FROM tbl_order_detail_info AS OD
		WHERE OI.order_no = OD.order_no
		),0)
;

SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;

COMMIT;
ROLLBACK;


SELECT * FROM tbl_order_detail_info
WHERE order_no = 202408040003;

#
# 날짜별 주문된 상품 수 

SELECT GI.goods_code, GI.goods_name
		 ,SUM(case DAYOFMONTH(OI.order_date) when 1 then OD.order_cnt ELSE 0 END) AS '1일'
		 ,SUM(case DAYOFMONTH(OI.order_date) when 2 then OD.order_cnt ELSE 0 END) AS '2일'
		 ,SUM(case DAYOFMONTH(OI.order_date) when 3 then OD.order_cnt ELSE 0 END) AS '3일'
		 ,SUM(case DAYOFMONTH(OI.order_date) when 4 then OD.order_cnt ELSE 0 END) AS '4일'
		 ,SUM(case DAYOFMONTH(OI.order_date) when 5 then OD.order_cnt ELSE 0 END) AS '5일'
		 ,SUM(case DAYOFMONTH(OI.order_date) when 6 then OD.order_cnt ELSE 0 END) AS '6일'
		 ,SUM(case DAYOFMONTH(OI.order_date) when 7 then OD.order_cnt ELSE 0 END) AS '7일'
FROM tbl_order_info AS OI
INNER JOIN tbl_order_detail_info AS OD ON OI.order_no = OD.order_no
INNER JOIN tbl_goods_info AS GI ON OD.goods_code = GI.goods_code
GROUP BY GI.goods_code
ORDER BY GI.goods_code
;

SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;


# WITH ROLLUP
# group by 절과 함께 사용 => 특정 컬럼 기준으로 집계 => 다시 집계

USE books;
SELECT goods_code, SUM(order_cnt) AS tot_cnt
FROM tbl_order_detail_info
GROUP BY goods_code WITH ROLLUP;

SELECT order_no, goods_code, SUM(order_cnt) AS tot_cnt
FROM tbl_order_detail_info
GROUP BY goods_code, order_no WITH ROLLUP;

#위와 아래가 동일      
SELECT A.title, A.order_no, A.goods_code, A.tot_cnt

FROM(

	SELECT '1' AS title, order_no, goods_code, SUM(order_cnt) AS tot_cnt
	FROM tbl_order_detail_info
	GROUP BY order_no, goods_code 
	
	union
	
	SELECT '2' AS title, 'NULL' as order_no, goods_code, SUM(order_cnt) AS tot_cnt
	FROM tbl_order_detail_info
	GROUP BY goods_code 
	ORDER BY goods_code, title, order_no
	
) AS A

	union
	
	SELECT '3' AS title, 'NULL' as order_no, 'NULL' as goods_code, SUM(order_cnt) AS tot_cnt
	FROM tbl_order_detail_info
ORDER BY goods_code,  title,  order_no
;

USE employees;
SHOW TABLES;

SELECT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM salaries;

# 2022년 월별 부서별 매출금액의 합을
# 1. with rollup절을 이용해 작성
# 2. union 변환

SELECT MONTH(SA.from_date) AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
GROUP BY EM.dept_no, mon WITH ROLLUP
;


# 이건 운이 좋았던 케이스...
SELECT MONTH(SA.from_date) AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
GROUP BY EM.dept_no, mon

UNION all

SELECT 'NULL' AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
GROUP BY EM.dept_no

UNION all

SELECT 'null' AS mon, 'null' as dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
ORDER BY dept_no, mon
;

# 이렇게 해야함 
SELECT b.*
FROM (

SELECT '1' title, MONTH(SA.from_date) AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE DATE_FORMAT (SA.from_date,'%Y') = 2022 
GROUP BY EM.dept_no, mon

UNION 

SELECT '2' title, NULL AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
GROUP BY EM.dept_no

) AS b

UNION 

SELECT '3' title,null AS mon, null as dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
ORDER BY dept_no, title, mon


# 임시 테이블
# Common Table Espression(CTE) --> 메모리 상에서만 존재
# --> 나한테만 보인다. 세션이 끊어지거나, 타임아웃 발생 시 사라진다 ( 1회성)

# WITH'테이믈명' AS(
# 임시테이블에 담을 리절트 셋
# select ~~~
# )
# select * from 임시테이블명

/*
WITH'임시테이블명' AS(
임시테이블에 담을 리절트 셋
select ~~~
)
select t.*, d.* 
from 임시테이블명 as t
inner join 테이블 as d on t.'' = d.''
*/

WITH TEMP_SALARY AS(
	SELECT MONTH(SA.from_date) AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
	FROM dept_emp AS EM
	INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
	WHERE SUBSTR(SA.from_date,1,4) = 2022 
	GROUP BY EM.dept_no, mon WITH ROLLUP
)

SELECT TS.*, DP.dept_name FROM TEMP_SALARY AS TS
INNER JOIN departments AS DP ON TS.dept_no = DP.dept_no 
ORDER BY TS.dept_no, TS.mon




# 월별 부서별 매출 억 이상
SELECT MONTH(SA.from_date) AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2021 
GROUP BY EM.dept_no, mon
HAVING SUM(SA.salary) >= 100000000

# 상관관계 쿼리로 바꾸기 



# 순위함수
# ROW_NUMBER()

/*

ROW_NUMBER() OVER (
	PARTITION BY(기준이 되는 컬럼)
	ORDER BY 컬럼 정렬값
) AS rank

*/
#페이징 할때...
USE books;

SET @paging = DIV(1/10) +10;


SELECT A.*
from
	( 
		SELECT MONTH(reg_date) AS MONTH
					, order_amount
					, ROW_NUMBER() OVER(
					PARTITION BY month(reg_date)
					ORDER BY order_amount desc
					) AS rankk
		FROM tbl_order_detail_info
		ORDER BY MONTH(reg_date), rankk
	) AS A
WHERE A.rankk>10
;


# RANK()
/*
RANK() OVER(
	PARTITION BY(기준이 되는 컬럼)
	ORDER BY 컬럼 정렬값
)
*/
# 겹쳐진 순위 이후에는 이어지지 않음
SELECT MONTH(REG_DATE) AS MON
				, ORDER_AMOUNT
				, RANK() OVER(
				PARTITION BY MONTH(REG_DATE)
				ORDER BY ORDER_AMOUNT DESC
				) AS RANKK
FROM TBL_ORDER_DETAIL_INFO
ORDER BY MON, RANKK
;


# DENSE_RANK()
/*
DENSE_RANK() OVER(
	PARTITION BY(기준이 되는 컬럼)
	ORDER BY 컬럼 정렬값
)
*/
# 겹쳐진 순위 이후에는 순위가 이어서 출력 
SELECT MONTH(REG_DATE) AS MON
				, ORDER_AMOUNT
				,DENSE_RANK() OVER(
				PARTITION BY MONTH(REG_DATE)
				ORDER BY ORDER_AMOUNT DESC
				) AS RANKK
FROM TBL_ORDER_DETAIL_INFO
ORDER BY MON, RANKK
;

#NTILE ()
/*
NTILE(표현식) OVER(
	ORDER BY 컬럼 정렬값
)
-> 표현식 갯수 만큼 순위 그룹으로 묶어서 출력
*/
# 선착순으로 자를때 사용 (리포트용으로 사용, 거의 사용 안함..) 
SELECT order_no, MONTH(REG_DATE) AS MON
				, ORDER_AMOUNT
				, NTILE(6) OVER(ORDER BY order_no) AS RANKK
FROM TBL_ORDER_DETAIL_INFO
ORDER BY order_no, RANKK
;


#PERCENT_RANK ()
/*
PERCENT_RANK() OVER(
	PARTITION BY 기준이 되는 컬럼
	ORDER BY 컬럼 정렬값
)
-> 순위를 백분율로 출력
*/

SELECT order_no
		, MONTH(REG_DATE) AS MON
		, order_amount
		, RANK() OVER (order by order_amount) AS rRANK
		, DENSE_RANK() OVER (order by order_amount) AS dRANK
		, PERCENT_RANK() OVER(	order by order_amount) AS pRANK
FROM TBL_ORDER_DETAIL_INFO
ORDER BY  rRANK
;

# VIEW 사용 -->
# 사용 이유 
/*
테이블 <-> 테이블 <-> 리절트셋 <-> ~~~ 복잡해짐
복잡한 쿼리를 조회한 결과를 가상의 테이블에 담아서 
일반 테이블처럼 사용 가능 
*/
USE employees;
CREATE VIEW VW_SALARY_2022 AS 
SELECT b.*
FROM (

SELECT '1' title, MONTH(SA.from_date) AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
GROUP BY EM.dept_no, mon

UNION 

SELECT '2' title, NULL AS mon, EM.dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
GROUP BY EM.dept_no

) AS b

UNION 

SELECT '3' title,null AS mon, null as dept_no, SUM(SA.salary) AS dept_sum
FROM dept_emp AS EM
INNER JOIN salaries AS SA ON EM.emp_no = SA.emp_no
WHERE SUBSTR(SA.from_date,1,4) = 2022 
ORDER BY dept_no, title, mon


SELECT * from VW_SALARY_2022