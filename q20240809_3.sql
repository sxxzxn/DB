INSERT INTO tbl_member (`user_id`, `user_name`, `pwd`, `ssn`, `birth_date`, `addr1`,	`addr2`, `zip_code`,
 `job_code`, `mileage`, `status`, `reg_date`, `leave_date`, `auto_login`)
VALUES ( 'user4', '홍길동4', '1234', '123456-1234567', '20240807', '인천 동구 먼동', '37번길(레미안)', '12345', '02', 0, 'P', NOW(), null, 'Y')
, ( 'user5', '홍길동5', '1234', '123456-1234567', '20240807', '인천 연수구 연수동', '27번길(자이)', '12345', '03', 5000, 'P', NOW(), null, 'Y')
, ( 'user6', '홍길동6', '1234', '123456-1234567', '20240807', '부산 사하구', '27번길(자이)', '12345', '04', 1500, 'P', NOW(), null, 'Y')
, ( 'user7', '홍길동7', '1234', '123456-1234567', '20240807', '경기 안양시 만안구', '27번길(자이)', '12345', '05', 2000, 'P', NOW(), null, 'Y')
, ( 'user8', '홍길동8', '1234', '123456-1234567', '20240807', '주소1', '27번길(자이)', '12345', '04', 500, 'P', NOW(), null, 'Y')
, ( 'user9', '홍길동9', '1234', '123456-1234567', '20240807', '주소1', '27번길(자이)', '12345', '053', 0, 'P', NOW(), null, 'Y')
, ( 'user10', '홍길동10', '1234', '123456-1234567', '20240807', '경기 부천시 ', '27번길(자이)', '12345', '01', 5000, 'P', NOW(), null, 'Y')
;


SELECT *
FROM tbl_member;

SELECT user_id, user_name, addr1,
	case job_code
		when '01' then '학생'
		when '02' then '회사원'
		when '03' then '공무원'
		when '04' then '교사'
		ELSE '기타'
	END AS job
FROM tbl_member;

SELECT *
FROM tbl_goods_info
ORDER BY ;

SELECT * ,
	case unit_code
		when '01' then '지우개'
		when '02' then '수정액'
	END AS goods
FROM tbl_goods_info;

SELECT * FROM tbl_member;
SELECT * FROM tbl_order_info;
SELECT * FROM tbl_order_detail_info;
SELECT * FROM tbl_goods_info;

#
INNER JOIN
#교집합

CROSS JOIN
#곱집합

OUTER JOIN
LEFT OUTER JOIN 
#왼쪽에 있으면 가져오고.. 아니면 가져오지마..?
#왼쪽 기준으로 데이터를 묶는데 왼쪽은 필수 오른쪽은 없어도 됨
RIGHT OUTER JOIN


SELECT OI.order_no
, OI.user_id
, MB.user_name
, OI.order_date
, OI.order_amount
, OI.reg_date
FROM tbl_order_info AS OI
INNER JOIN tbl_member AS MB ON OI.user_id = MB.user_id
;

SELECT GI.*, OD.*
FROM tbl_goods_info AS GI
JOIN tbl_order_detail_info AS OD ON GI.unit_code = OD.unit_code;

# 이 두개가 같은거임..ㅎ 
SELECT user_id, user_name, addr1,
	case job_code
		when '01' then '학생'
		when '02' then '회사원'
		when '03' then '공무원'
		when '04' then '교사'
		ELSE '기타'
	END AS job
FROM tbl_member;

SELECT user_id, user_name, job_code
DECODE_ORACLE(job_code, '01','학생',
								'02','회사원',
								'03','공무원',
								'04','교사','기타') AS job_name
FROM tbl_member;

SELECT if(1<2,'Y','N') AS yn;

SELECT if (STATUS IS not NULL, 'Y', 'N') AS STATUS 
FROM tbl_member;

SELECT order_no, user_id, order_date, cancelYN,
    IF(cancelYN = 'Y', '주문취소', '정상주문') AS c1,
    CASE WHEN cancelYN = 'N' THEN '정상주문' ELSE '주문취소' END AS AS2,
    DECODE_ORACLE(cancelYN, 'Y', '주문취소', '정상주문')  AS c3 
FROM tbl_order_info;

SELECT * FROM tbl_member;

SELECT user_id, user_name, ssn
		,addr1
		,IFNULL(addr2, "빈주소2") AS addr2
		, NVL(addr2, "빈주소3") AS addr3
		,NULLIF(addr1, addr2) AS addr13
		,NULLIF(addr1, null) AS addr22
		, NVL2(addr1,addr2, '주소2') AS addr23
FROM tbl_member
ORDER BY user_id;

SELECT 
		idx
		, rownum() AS rowNum
		,goods_code, goods_name
FROM tbl_goods_info
ORDER BY idx;

SELECT * 
FROM tbl_member
;

INSERT INTO tbl_member(user_id, pwd, user_name, ssn, birth_date, job_code, STATUS, reg_date, auto_login)
VALUES('user11','1234','김복동','234567-8901234','20200101','05','Y',now(),'Y');
SELECT ROW_COUNT();

SET@app_cnt = 0;
SELECT @app_cnt = ROW_COUNT();

SELECT *
FROM tbl_member;
SELECT ROW_COUNT();

UPDATE tbl_member SET user_id = 'user11', pwd= '1234', user_name = '김복동', ssn='234567-8901234'
							,birth_date ='20200101', job_code='05', `status`='Y', auto_login = 'Y'
WHERE user_id = 'user11';

DELETE 
FROM tbl_member
WHERE user_id = 'user11';
#
SELECT DEFAULT(mileage),DEFAULT(`status`), DEFAULT(leave_date), DEFAULT(reg_date)
FROM tbl_member
