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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='회원테이블';

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

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
