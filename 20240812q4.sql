#JOIN : 하나의 select 쿼리문을 사용하여 두개 이상의 테이블을 사용하는 방법
#JOIN 종류 : INNER JOIN, OUTER JOIN, SELF JOIN, CROSS JOIN( ㅐ대체적으로  뒤로 갈수록  연산량이 많아져 속도가 느려진다)
#JOIN 기본형식 (DEFALTE INNERJOIN)

SELECT 컬럼1,,,,,,
FROM 테이블명 AS T1 
INNER JOIN 테이믈2 AS T2 ON 조인조건 
LEFT OUTER JOIN (=OUTER JOIN) 
RIGHT OUTER JOIN
CROSS JOIN
;


USE employees;


SELECT *
FROM dept_manager; 

DESC departments;


SELECT *
FROM employees
LIMIT 10
;

SELECT *
from departments;

SELECT *
FROM dept_emp
LIMIT 10;


#노동자 정보 <--> 매핑테이블 <--> 부서 정보

SELECT EM.emp_no, EM.first_name, EM.last_name, EM.hire_date 
		,DP.dept_no, DP.dept_name, 
FROM employees AS EM
INNER JOIN dept_emp AS DE ON EM.emp_no = DE.emp_no
INNER JOIN departments AS dp ON DE.dept_no = DP.dept_no
LIMIT 100
;

SELECT DP.dept_no, DP.dept_no, COUNT(EM.emp_no) AS emp_cnt
FROM employees AS EM
INNER JOIN dept_emp AS DE ON EM.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
GROUP BY DP.dept_no, DE.dept_no
;

SELECT dept_no, COUNT(emp_no) AS emp_cnt
FROM dept_emp
GROUP BY dept_no
;


DESC departments; #부서이름
desc employees; #직원 이름
DESC dept_emp; #emp_no +dept_no
#
finance, development, research 속해있는 직원 정보를( 이름, 성, 입사일,부서코드) 
부서명별 오름차순, 직원 입사일 내림차순 정렬 출력 

SELECT EM.last_name AS 이름,EM.first_name AS 성,EM.hire_date AS 입사일
		,DP.dept_name AS 부서명,DP.dept_no AS 부서코드
FROM employees AS EM
INNER JOIN dept_emp AS DE ON EM.emp_no = DE.emp_no
INNER JOIN departments AS DP ON DE.dept_no = DP.dept_no
WHERE DE.dept_no IN('d002','d005','d008')
ORDER BY DP.dept_name ASC, EM.hire_date desc
; 

#인덱스가 걸린 기본키를 사용했다...

SELECT *
FROM employees
LIMIT 10
;


SELECT *
FROM salaries
LIMIT 100
;


DESC salaries;


SELECT EM.emp_no  AS '직원번호', EM.last_name AS '이름', COUNT(SA.salary) AS cnt
FROM employees AS EM
INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
WHERE EM.emp_no>499500 
GROUP BY SA.emp_no 
HAVING cnt >=10
ORDER BY cnt asc
;


SELECT rownum() AS 'no',EM.*
FROM employees AS EM
CROSS JOIN salaries AS SA
WHERE EM.emp_no IN (499500)
;


SELECT *
FROM salaries 
WHERE emp_no IN(49950)
;

SELECT DISTINCT(from_date)
FROM salaries
ORDER BY from_date
;

SET @fdate = '2022-07-30';


SELECT EM.*, SA.salary, SA.from_date
FROM employees AS EM
INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
WHERE from_date = @fdate
ORDER BY SA.salary desc
LIMIT 1
;

SET @fdate = YEAR(2022),MONTH(07);
# 부서별  평균, 최저, 최고

DESC dept_emp; 
#emp_no + dept_no

SELECT *
FROM dept_emp
LIMIT 10
;

SELECT *
FROM employees
LIMIT 10
;


SELECT DP.dept_no, DP.dept_name
		,AVG(SA.salary) AS avg_sa
		,min(SA.salary) AS min_sa
		,max(SA.salary) AS max_sa
FROM employees AS EM
INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
INNER JOIN dept_emp AS DE ON DE.emp_no = EM.emp_no
INNER JOIN departments AS DP ON DP.dept_no= DE.dept_no
WHERE SA.from_date BETWEEN '2022-07-01' AND '2022-07-31'
GROUP BY DE.dept_no
;


#평균 구하기
SELECT AVG(total_salary) AS avg_sa
FROM (
    SELECT SUM(SA.salary) AS total_salary
    FROM employees AS EM
    INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
    GROUP BY EM.emp_no
) AS salary_totals
;

SELECT AVG(SA.salary) AS avg_sa
FROM employees AS EM
INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
INNER JOIN dept_emp AS DE ON DE.emp_no = EM.emp_no
INNER JOIN departments AS DP ON DP.dept_no= DE.dept_no
WHERE SA.from_date BETWEEN '2022-07-01' AND '2022-07-31'
GROUP BY DE.dept_no
;

SELECT min(SA.salary) AS min_sa
FROM employees AS EM
INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
INNER JOIN dept_emp AS DE ON DE.emp_no = EM.emp_no
INNER JOIN departments AS DP ON DP.dept_no= DE.dept_no
WHERE SA.from_date BETWEEN '2022-07-01' AND '2022-07-31'
GROUP BY DE.dept_no
;

SELECT max(SA.salary) AS max_sa
FROM employees AS EM
INNER JOIN salaries AS SA ON SA.emp_no = EM.emp_no
INNER JOIN dept_emp AS DE ON DE.emp_no = EM.emp_no
INNER JOIN departments AS DP ON DP.dept_no= DE.dept_no
WHERE SA.from_date BETWEEN '2022-07-01' AND '2022-07-31'
GROUP BY DE.dept_no
HAVING 
;


