-- --------------------------------------------------------
-- 호스트:                          localhost
-- 서버 버전:                        10.11.8-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- books 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `books` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `books`;

-- 테이블 books.tbl_goods_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_goods_info` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `goods_code` char(6) NOT NULL DEFAULT '' COMMENT '상품코드',
  `goods_name` varchar(20) DEFAULT '' COMMENT '상품명',
  `unit_code` char(2) NOT NULL COMMENT '단위코드',
  `unit_price` int(11) NOT NULL DEFAULT 0 COMMENT '단위가격',
  `goods_status` char(1) NOT NULL DEFAULT 'N' COMMENT '제품판매(Y:판매중,N:판매중지, P:일시중지)',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT '등록일',
  `modify_date` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`goods_code`),
  KEY `idx` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='상품정보테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 books.tbl_member 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_member` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `user_id` varchar(20) NOT NULL COMMENT '아이디',
  `user_name` varchar(20) NOT NULL COMMENT '이름',
  `pwd` varchar(20) NOT NULL COMMENT '비밀번호',
  `ssn` varchar(14) DEFAULT NULL COMMENT '주민번호(123456-1234567)',
  `birth_date` char(10) DEFAULT NULL COMMENT '생년월일(YYYY-MM-DD)',
  `addr1` varchar(100) DEFAULT NULL COMMENT '주소1',
  `addr2` varchar(100) DEFAULT NULL COMMENT '주소2',
  `zip_code` varchar(7) DEFAULT NULL COMMENT '우편번호',
  `job_code` char(2) DEFAULT NULL COMMENT '직업코드',
  `mileage` int(11) DEFAULT 0 COMMENT '마일리지',
  `status` char(1) DEFAULT NULL COMMENT '회원선택(사용중,N탈퇴,P중지)',
  `reg_date` datetime DEFAULT current_timestamp() COMMENT '등록일',
  `leave_date` datetime DEFAULT NULL COMMENT '탈퇴일',
  `auto_login` char(1) DEFAULT 'N' COMMENT '자동로그인여부(Y:자동로그인,N:자동로그인안함)',
  PRIMARY KEY (`user_id`),
  KEY `인덱스 1` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='회원테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 books.tbl_member2 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_member2` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `user_id` varchar(20) NOT NULL COMMENT '아이디',
  `user_name` varchar(20) NOT NULL COMMENT '이름',
  `pwd` varchar(20) NOT NULL COMMENT '비밀번호',
  `ssn` varchar(14) DEFAULT NULL COMMENT '주민번호(123456-1234567)',
  `birth_date` char(10) DEFAULT NULL COMMENT '생년월일(YYYY-MM-DD)',
  `addr1` varchar(100) DEFAULT NULL COMMENT '주소1',
  `addr2` varchar(100) DEFAULT NULL COMMENT '주소2',
  `zip_code` varchar(7) DEFAULT NULL COMMENT '우편번호',
  `job_code` char(2) DEFAULT NULL COMMENT '직업코드',
  `mileage` int(11) DEFAULT 0 COMMENT '마일리지',
  `status` char(1) DEFAULT NULL COMMENT '회원선택(사용중,N탈퇴,P중지)',
  `reg_date` datetime DEFAULT current_timestamp() COMMENT '등록일',
  `leave_date` datetime DEFAULT NULL COMMENT '탈퇴일',
  `auto_login` char(1) DEFAULT 'N' COMMENT '자동로그인여부(Y:자동로그인,N:자동로그인안함)',
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `인덱스 1` (`idx`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='회원테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 books.tbl_order_detail_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_order_detail_info` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `order_no` char(12) NOT NULL COMMENT '주문번호',
  `goods_code` char(6) NOT NULL COMMENT '상품코드',
  `unit_code` char(2) NOT NULL COMMENT '단위코드',
  `unit_price` int(11) NOT NULL DEFAULT 0 COMMENT '단위가격(기본값0)',
  `order_cnt` smallint(6) NOT NULL DEFAULT 0 COMMENT '주문갯수(기본0)',
  `order_amount` int(11) NOT NULL DEFAULT 0 COMMENT '주문금액(기본:0)',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT '주문일',
  `modify_date` datetime DEFAULT NULL COMMENT '수정일',
  KEY `idx` (`idx`),
  KEY `FK_tbl_order_detail_info_tbl_order_info` (`order_no`),
  CONSTRAINT `FK_tbl_order_detail_info_tbl_order_info` FOREIGN KEY (`order_no`) REFERENCES `tbl_order_info` (`order_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='주문 상세 정보 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 books.tbl_order_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_order_info` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `order_no` char(12) NOT NULL COMMENT '주문번호(YYYYMMDD0001)',
  `user_id` varchar(20) NOT NULL COMMENT '사용자아이디',
  `order_date` char(8) DEFAULT NULL COMMENT '주문일(YYYYMMDD)',
  `order_amount` int(11) NOT NULL DEFAULT 0 COMMENT '주문금액',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT '주문일자',
  `cancelYN` char(1) NOT NULL DEFAULT 'N' COMMENT '주문 취소 여부 (Y취소 ,N정상)',
  PRIMARY KEY (`order_no`),
  KEY `idx` (`idx`),
  KEY `FK_tbl_order_info_tbl_member` (`user_id`),
  CONSTRAINT `FK_tbl_order_info_tbl_member` FOREIGN KEY (`user_id`) REFERENCES `tbl_member` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='주문정보 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 books.tbl_test 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_test` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `title_no` varchar(10) NOT NULL COMMENT '글번호',
  `title` varchar(100) DEFAULT NULL COMMENT '글제목',
  PRIMARY KEY (`title_no`) USING BTREE,
  KEY `idx` (`idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='테스트테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.


-- employees 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `employees` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `employees`;

-- 함수 employees.convert3857To4326 구조 내보내기
DELIMITER //
CREATE FUNCTION `convert3857To4326`(p_3857 POINT) RETURNS point
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE lon DOUBLE;
    DECLARE lat DOUBLE;
    DECLARE x DOUBLE;
    DECLARE y DOUBLE;

    
    IF ST_SRID(p_3857)=4326 THEN
      RETURN p_3857;
    ELSEIF ST_SRID(p_3857)<>3857 THEN
      SIGNAL SQLSTATE 'HY000' SET MYSQL_ERRNO=1108, MESSAGE_TEXT='Incorrect parameters (SRID must be 3857)';
    END IF;

    SET x = ST_X(p_3857);
    SET y = ST_Y(p_3857);

    
    SET lon = x *  180 / 20037508.34 ;
    SET lat = ATAN(EXP(y * PI() / 20037508.34)) * 360 / PI() - 90; 

    RETURN ST_PointFromText(CONCAT('POINT(', lat,' ', lon,')'), 4326);
END//
DELIMITER ;

-- 함수 employees.convert4326To3857 구조 내보내기
DELIMITER //
CREATE FUNCTION `convert4326To3857`(p_4326 POINT) RETURNS point
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE lon DOUBLE;
    DECLARE lat DOUBLE;
    DECLARE x DOUBLE;
    DECLARE y DOUBLE;

    
    IF ST_SRID(p_4326)=3857 THEN
      RETURN p_4326;
    ELSEIF ST_SRID(p_4326)<>4326 THEN
      SIGNAL SQLSTATE 'HY000' SET MYSQL_ERRNO=1108, MESSAGE_TEXT='Incorrect parameters (SRID must be 4326)';
    END IF;

    SET lon = ST_Longitude(p_4326);
    SET lat = ST_Latitude(p_4326);

    
    
    SET x = lon * 20037508.34 / 180;
    SET y = LOG(TAN((90 + lat) * PI() / 360)) / (PI() / 180);
    SET y = y * 20037508.34 / 180;

    RETURN ST_PointFromText(CONCAT('POINT(', x,' ', y,')'), 3857);
END//
DELIMITER ;

-- 테이블 employees.departments 구조 내보내기
CREATE TABLE IF NOT EXISTS `departments` (
  `dept_no` char(4) NOT NULL,
  `dept_name` varchar(40) NOT NULL,
  `emp_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`dept_no`),
  KEY `ux_deptname` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 employees.dept_emp 구조 내보내기
CREATE TABLE IF NOT EXISTS `dept_emp` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`dept_no`,`emp_no`),
  KEY `ix_fromdate` (`from_date`),
  KEY `ix_empno_fromdate` (`emp_no`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 employees.dept_manager 구조 내보내기
CREATE TABLE IF NOT EXISTS `dept_manager` (
  `dept_no` char(4) NOT NULL,
  `emp_no` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`dept_no`,`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 함수 employees.distanceInSphere 구조 내보내기
DELIMITER //
CREATE FUNCTION `distanceInSphere`(p1_3857 POINT, p2_3857 POINT) RETURNS double
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE p1_4326 POINT;
    DECLARE p2_4326 POINT;

    SET p1_4326 = convert3857To4326(p1_3857);
    SET p2_4326 = convert3857To4326(p2_3857);

    
    RETURN ST_Distance_Sphere(p1_4326, p2_4326, 6370986);
END//
DELIMITER ;

-- 테이블 employees.employees 구조 내보내기
CREATE TABLE IF NOT EXISTS `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`),
  KEY `ix_hiredate` (`hire_date`),
  KEY `ix_gender_birthdate` (`gender`,`birth_date`),
  KEY `ix_firstname` (`first_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci STATS_PERSISTENT=0;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 employees.employees_comp4k 구조 내보내기
CREATE TABLE IF NOT EXISTS `employees_comp4k` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`),
  KEY `ix_firstname` (`first_name`),
  KEY `ix_hiredate` (`hire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 employees.employees_comp8k 구조 내보내기
CREATE TABLE IF NOT EXISTS `employees_comp8k` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`),
  KEY `ix_firstname` (`first_name`),
  KEY `ix_hiredate` (`hire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 함수 employees.getDistanceMBR 구조 내보내기
DELIMITER //
CREATE FUNCTION `getDistanceMBR`(p_origin POINT, p_distanceKm DOUBLE) RETURNS polygon
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_originLat DOUBLE DEFAULT 0.0;
    DECLARE v_originLon DOUBLE DEFAULT 0.0;
    
    DECLARE v_deltaLon DOUBLE DEFAULT 0.0;
    DECLARE v_Lat1 DOUBLE DEFAULT 0.0;
    DECLARE v_Lon1 DOUBLE DEFAULT 0.0;
    DECLARE v_Lat2 DOUBLE DEFAULT 0.0;
    DECLARE v_Lon2 DOUBLE DEFAULT 0.0;

    SET v_originLat = ST_X(p_origin); 
    SET v_originLon = ST_Y(p_origin); 

    SET v_deltaLon = p_distanceKm / ABS(COS(RADIANS(v_originLat))*111.32);
    SET v_Lon1 = v_originLon - v_deltaLon;
    SET v_Lon2 = v_originLon + v_deltaLon;
    SET v_Lat1 = v_originLat - (p_distanceKm / 111.32); 
    SET v_Lat2 = v_originLat + (p_distanceKm / 111.32);

    SET @mbr = ST_AsText(ST_Envelope(ST_GeomFromText(CONCAT("LINESTRING(", v_Lat1, " ", v_Lon1,", ", v_Lat2, " ", v_Lon2,")"))));
    RETURN ST_PolygonFromText(@mbr, ST_SRID(p_origin));
END//
DELIMITER ;

-- 테이블 employees.salaries 구조 내보내기
CREATE TABLE IF NOT EXISTS `salaries` (
  `emp_no` int(11) NOT NULL,
  `salary` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`from_date`),
  KEY `ix_salary` (`salary`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 함수 employees.sf_divide 구조 내보내기
DELIMITER //
CREATE FUNCTION `sf_divide`(p_dividend INT, p_divisor INT) RETURNS int(11)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
         DECLARE null_divisor CONDITION FOR SQLSTATE '45000';
         
         IF p_divisor IS NULL THEN
           SIGNAL null_divisor 
               SET MESSAGE_TEXT='Divisor can not be null', MYSQL_ERRNO=9999;
         ELSEIF p_divisor=0 THEN
           SIGNAL SQLSTATE '45000' 
               SET MESSAGE_TEXT='Divisor can not be 0', MYSQL_ERRNO=9998;
         ELSEIF p_dividend IS NULL THEN
           SIGNAL SQLSTATE '01000' 
               SET MESSAGE_TEXT='Dividend is null, so regarding dividend as 0', MYSQL_ERRNO=9997; 
           RETURN 0;
         END IF;
         
         RETURN FLOOR(p_dividend / p_divisor); 
       END//
DELIMITER ;

-- 함수 employees.sf_emp_count 구조 내보내기
DELIMITER //
CREATE FUNCTION `sf_emp_count`(p_dept_no VARCHAR(10)) RETURNS bigint(20)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
         
         DECLARE v_total_count INT DEFAULT 0;
          
         DECLARE v_no_more_data TINYINT DEFAULT 0;
         
         DECLARE v_emp_no INTEGER;
          
         DECLARE v_from_date DATE;
          
         DECLARE v_emp_list CURSOR FOR

         SELECT emp_no, from_date FROM dept_emp WHERE dept_no=p_dept_no;
          
         DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_no_more_data = 1;

          
         OPEN v_emp_list;
         REPEAT
            
           FETCH v_emp_list INTO v_emp_no, v_from_date;
           IF v_emp_no > 20000 THEN
             SET v_total_count = v_total_count + 1; 
           END IF;
         UNTIL v_no_more_data END REPEAT;

          
         CLOSE v_emp_list;

         RETURN v_total_count; 
       END//
DELIMITER ;

-- 프로시저 employees.sp_remove_user 구조 내보내기
DELIMITER //
CREATE PROCEDURE `sp_remove_user`(IN p_userid INT)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
         DECLARE v_affectedrowcount INT DEFAULT 0;
         DECLARE EXIT HANDLER FOR SQLEXCEPTION
           BEGIN
             SIGNAL SQLSTATE '45000'
               SET MESSAGE_TEXT='Can not remove user information', MYSQL_ERRNO=9999;
           END;

         
         DELETE FROM tb_user WHERE user_id=p_userid;
         
         SELECT ROW_COUNT() INTO v_affectedrowcount;
         
         IF v_affectedrowcount<>1 THEN
           SIGNAL SQLSTATE '45000'; 
         END IF;
       END//
DELIMITER ;

-- 프로시저 employees.sp_updateemployeehiredate 구조 내보내기
DELIMITER //
CREATE PROCEDURE `sp_updateemployeehiredate`()
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
         
         DECLARE v_dept_no CHAR(4);
         
         DECLARE v_emp_no INT;
         
         DECLARE v_no_more_rows BOOLEAN DEFAULT FALSE;
         
         DECLARE v_dept_list CURSOR FOR SELECT dept_no FROM departments;

         
         DECLARE v_emp_list CURSOR FOR SELECT emp_no 
                                       FROM dept_emp 
                                       WHERE dept_no=v_dept_no LIMIT 1;

         
         DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_no_more_rows := TRUE;

         OPEN v_dept_list;
         LOOP_OUTER: LOOP 
           
           FETCH v_dept_list INTO v_dept_no;
           IF v_no_more_rows THEN 
             CLOSE v_dept_list; 
             LEAVE loop_outer;
           END IF;

           OPEN v_emp_list;
           LOOP_INNER: LOOP
             FETCH v_emp_list INTO v_emp_no;
             
             IF v_no_more_rows THEN
               
               
               SET v_no_more_rows := FALSE;
               CLOSE v_emp_list;
               LEAVE loop_inner;
             END IF;
           END LOOP loop_inner;
         END LOOP loop_outer; 
       END//
DELIMITER ;

-- 프로시저 employees.sp_updateemployeehiredate1 구조 내보내기
DELIMITER //
CREATE PROCEDURE `sp_updateemployeehiredate1`()
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
         
         DECLARE v_dept_no CHAR(4);
         
         DECLARE v_no_more_depts BOOLEAN DEFAULT FALSE;
         
         DECLARE v_dept_list CURSOR FOR SELECT dept_no FROM departments;
         
         DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_no_more_depts := TRUE;
       
         OPEN v_dept_list;
         LOOP_OUTER: LOOP                    
           FETCH v_dept_list INTO v_dept_no;
           IF v_no_more_depts THEN 
              
             CLOSE v_dept_list;
             LEAVE loop_outer; 
           END IF;
       
           BLOCK_INNER: BEGIN 
             
             
             DECLARE v_emp_no INT;
             
             DECLARE v_no_more_employees BOOLEAN DEFAULT FALSE;
             
             DECLARE v_emp_list CURSOR FOR SELECT emp_no 
                                           FROM dept_emp 
                                           WHERE dept_no=v_dept_no LIMIT 1;
             
             DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_no_more_employees := TRUE;

             OPEN v_emp_list;
             LOOP_INNER: LOOP              
               FETCH v_emp_list INTO v_emp_no;
               
               IF v_no_more_employees THEN
                 CLOSE v_emp_list;
                 LEAVE loop_inner; 
               END IF;
             END LOOP loop_inner;          
           
           END block_inner;                
         END LOOP loop_outer;              
       END//
DELIMITER ;

-- 테이블 employees.tb_dual 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_dual` (
  `fd1` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 employees.titles 구조 내보내기
CREATE TABLE IF NOT EXISTS `titles` (
  `emp_no` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`emp_no`,`from_date`,`title`),
  KEY `ix_todate` (`to_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 트리거 employees.on_delete 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `on_delete` BEFORE DELETE ON `employees` FOR EACH ROW BEGIN
         DELETE FROM salaries WHERE emp_no=OLD.emp_no; 
       END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
