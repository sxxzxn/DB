# 데이터 베이스 생성
CREATE DATABASE tspoon;

# 사용하기
USE tspoon;
tbl_member
# member테이블 생성
CREATE TABLE `tbl_member`(
	`memberId` VARCHAR(20) NOT NULL COMMENT '회원ID' COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(20) NULL DEFAULT NULL COMMENT '회원이름' COLLATE 'utf8mb4_general_ci',
	`pwd` VARCHAR(300) NOT NULL COMMENT '비밀번호'  COLLATE 'utf8mb4_general_ci',
	`birthday` DATE  NULL COMMENT '생년월일(YYYY-MM-DD)'  COLLATE 'utf8mb4_general_ci',
	`gender` CHAR(1)  NULL DEFAULT 'F' COMMENT 'F여 M남' COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(20)  NULL COMMENT'핸드폰번호'  COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(50)  NULL COMMENT'이메일'  COLLATE 'utf8mb4_general_ci',
	`interstField` VARCHAR(20)  NULL COMMENT'관심분야'  COLLATE 'utf8mb4_general_ci',
	`grade` VARCHAR(50)  NULL COMMENT'학년'  COLLATE 'utf8mb4_general_ci',
	`locationInfoYN` CHAR(1)  NULL DEFAULT 'N' COMMENT'위치정보 동의 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`promtionYN` CHAR(1)  NULL DEFAULT 'N' COMMENT'프로모션안내수신 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`personalInfoYN` CHAR(1)  NULL DEFAULT 'N' COMMENT'제2자 제공동의 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`cjEduYN` CHAR(1)  NULL DEFAULT 'N' COMMENT'천재교육이용약관동의 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`typeCode` CHAR(1)  NULL DEFAULT 'P' COMMENT '타입코드 P부모 T선생님 S 학생'  COLLATE 'utf8mb4_general_ci',
	`memberStateYN` CHAR(1) NULL DEFAULT 'Y' COMMENT '회원상태 Y활동 N 탈퇴'  COLLATE 'utf8mb4_general_ci',
	`regDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`leaveDate` DATETIME NULL DEFAULT NULL COMMENT '탈퇴일일',
	`pwdChangeDate` DATETIME NULL DEFAULT NULL COMMENT '비밀번호 변경일',
	PRIMARY KEY(`memberId`) USING BTREE,
	INDEX `IDX_tbl_member_name` (`name`) USING btree
)
COMMENT ='회원테이블'
COLLATE 'utf8mb4_general_ci'
ENGINE=INNODB;


# message 테이블 생성
CREATE TABLE `tbl_message`(
	`msgIdx` INT NOT NULL AUTO_INCREMENT COMMENT '인덱스',
	`sendId` VARCHAR(20) NOT NULL COMMENT '보낸사람아이디' COLLATE 'utf8mb4_general_ci',
	`receiveId` VARCHAR(20) NOT NULL COMMENT '받은사람아이디' COLLATE 'utf8mb4_general_ci',
	`msgTitle` VARCHAR(200) NOT NULL COMMENT '글제목' COLLATE 'utf8mb4_general_ci',
	`msgContent` TEXT NOT NULL COMMENT '글 내용' COLLATE 'utf8mb4_general_ci',
	`msgRegDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`msgreadCnt` INT  NULL DEFAULT 0 COMMENT '조회수',
	`sendStateYN` CHAR(1) NULL DEFAULT 'N' COMMENT '보낸쪽지함 삭제 여부 Y 삭제  N 유지 '  COLLATE 'utf8mb4_general_ci',
	`receiveStateYN` CHAR(1) NULL DEFAULT 'N' COMMENT '받은쪽지함 삭제 여부 Y 삭제  N유지'  COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`msgIdx`) USING BTREE,
	INDEX `FK_BBS_tbl_member_send` (`sendId`) USING BTREE,
	INDEX `FK_BBS_tbl_member_receive` (`receiveId`) USING BTREE,
	CONSTRAINT `FK_message_tbl_member_send` FOREIGN KEY (`sendId`) REFERENCES `tbl_member` (`memberId`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_message_tbl_member_receive` FOREIGN KEY (`receiveId`) REFERENCES `tbl_member` (`memberId`) ON UPDATE CASCADE ON DELETE CASCADE
)COMMENT ='쪽지테이블'
COLLATE 'utf8mb4_general_ci'
ENGINE=INNODB;


# qna 테이블 생성
CREATE TABLE `tbl_qna`(
	`qnaIdx` INT NOT NULL AUTO_INCREMENT COMMENT '인덱스',
	`qnaCategory` VARCHAR(20) NOT NULL COMMENT '타입' COLLATE 'utf8mb4_general_ci',
	`qnaWriterId` VARCHAR(20) NOT NULL COMMENT '작성자아이디' COLLATE 'utf8mb4_general_ci',
	`qnaTitle` VARCHAR(200) NOT NULL COMMENT '글제목' COLLATE 'utf8mb4_general_ci',
	`qnaContent` TEXT NOT NULL COMMENT '글 내용' COLLATE 'utf8mb4_general_ci',
	`qnaRegDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`qnaModifyDate`DATETIME NULL DEFAULT NOW() COMMENT  '수정일',
	`qnaReadCnt` INT  NULL DEFAULT 0 COMMENT '조회수',
	PRIMARY KEY (`qnaIdx`) USING BTREE,
	FOREIGN KEY (`qnaWriterId`) REFERENCES `tbl_member` (`memberId`) ON UPDATE CASCADE ON DELETE CASCADE
)COMMENT ='게시판테이블'
COLLATE 'utf8mb4_general_ci'
ENGINE=INNODB;
tspoontbl_qna

# file 테이블 생성
CREATE TABLE `tbl_file` (
	`fileIdx` INT NOT NULL AUTO_INCREMENT COMMENT '파일 번호' COLLATE 'utf8mb4_general_ci',
	`joinTable` VARCHAR(100) NULL default NULL COMMENT '파일이 있는 테이블 ' COLLATE 'utf8mb4_general_ci',
	`joinTableIdx` INT NOT NULL COMMENT '파일이 저장된 게시글 번호' COLLATE 'utf8mb4_general_ci',
 	`filePath` VARCHAR(200) NULL default NULL COMMENT '파일저장경로' COLLATE 'utf8mb4_general_ci',
	`fileName` VARCHAR(100) NULL default NULL COMMENT '파일명' COLLATE 'utf8mb4_general_ci',
	`fileExt` VARCHAR(10) NULL default NULL COMMENT '파일확장자' COLLATE 'utf8mb4_general_ci',
	`fileSize` INT  NULL DEFAULT  0 NULL COMMENT '파일사이즈' ,
    PRIMARY KEY (`fileIdx`) USING BTREE
) COMMENT='파일 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB;


# comment 테이블 생성
CREATE TABLE `tbl_comment` (
    `commentIdx` INT NOT NULL AUTO_INCREMENT COMMENT '댓글 ID',
    `comWriterId` VARCHAR(20) NOT NULL COMMENT '작성자아이디' COLLATE 'utf8mb4_general_ci',
    `comRegDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '작성일',
    `comTableIdx` INT NOT NULL COMMENT '게시판 ID',
    `comContent` TEXT NOT NULL COMMENT '댓글 내용' COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`commentIdx`) USING BTREE,
    FOREIGN KEY (`ComTableIdx`) REFERENCES `tbl_qna`(`qnaIdx`) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT='댓글 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB;

 
 #tbl_delete_member 탈퇴회원 테이블
 CREATE TABLE `tbl_delete_member`(
	`memberId` VARCHAR(20) NOT NULL COMMENT '회원ID' COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(20) NULL DEFAULT NULL COMMENT '회원이름' COLLATE 'utf8mb4_general_ci',
	`pwd` VARCHAR(300) NOT NULL COMMENT '비밀번호'  COLLATE 'utf8mb4_general_ci',
	`birthday` DATE NOT NULL COMMENT '생년월일(YYYY-MM-DD)'  COLLATE 'utf8mb4_general_ci',
	`gender` CHAR(1) NOT NULL DEFAULT 'F' COMMENT 'F여 M남' COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(20) NOT NULL COMMENT'핸드폰번호'  COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(50) NOT NULL COMMENT'이메일'  COLLATE 'utf8mb4_general_ci',
	`interstField` VARCHAR(20) NOT NULL COMMENT'관심분야'  COLLATE 'utf8mb4_general_ci',
	`grade` VARCHAR(50) NOT NULL COMMENT'학년'  COLLATE 'utf8mb4_general_ci',
	`locationInfoYN` CHAR(1) NOT NULL DEFAULT 'N' COMMENT'위치정보 동의 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`promtionYN` CHAR(1) NOT NULL DEFAULT 'N' COMMENT'프로모션안내수신 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`pernalInfoYN` CHAR(1) NOT NULL DEFAULT 'N' COMMENT'제2자 제공동의 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`cjEduYN` CHAR(1) NOT NULL DEFAULT 'N' COMMENT'천재교육이용약관동의 Y 동의 N 거부'  COLLATE 'utf8mb4_general_ci',
	`typeCode` CHAR(1) NOT NULL DEFAULT 'P' COMMENT '타입코드 P부모 T선생님 S 학생'  COLLATE 'utf8mb4_general_ci',
	`memberStateYN` CHAR(1) NULL DEFAULT 'N' COMMENT '회원상태 Y활동 N 탈퇴'  COLLATE 'utf8mb4_general_ci',
	`regDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`leaveDate` DATETIME NULL DEFAULT NULL COMMENT '탈퇴일일',
	`pwdChangeDate` DATETIME NULL DEFAULT NULL COMMENT '비밀번호 변경일',
	PRIMARY KEY(`memberId`) USING BTREE
)
COMMENT ='탈퇴회원테이블'
COLLATE 'utf8mb4_general_ci'
ENGINE=INNODB;

# 회원추가 

SELECT * FROM tbl_member WHERE typeCode = ?;
INSERT INTO tbl_member (
    memberId, name, pwd, typeCode
) 
VALUES
    ('admin1', '관리선생님 1', '1234', 'T'),
    ('admin2', '관리선생님 2', '1234', 'T'),
    ('admin3', '관리선생님 3', '1234', 'T'),
    ('admin4', '관리선생님 4', '1234', 'T'),
    ('admin5', '관리선생님 5', '1234', 'T'),
    ('admin6', '관리선생님 6', '1234', 'T'),
    ('admin7', '관리선생님 7', '1234', 'T'),
    ('admin8', '관리선생님 8', '1234', 'T'),
    ('admin9', '관리선생님 9', '1234', 'T'),
    ('admin10', '관리선생님 10', '1234', 'T')
;
    
UPDATE tbl_member
SET pwd = '1234'
WHERE typeCode = 'T';

COMMIT;


s