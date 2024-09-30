tbl_membertbl_memberUSE fullstack7;
CREATE TABLE tbl_member(
	`memberId` VARCHAR(20) NOT NULL COMMENT '회원ID' COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(20) NULL DEFAULT NULL COMMENT '회원이름' COLLATE 'utf8mb4_general_ci',
	`pwd` VARCHAR(300) NOT NULL COMMENT '비밀번호'  COLLATE 'utf8mb4_general_ci',
	`jumin` VARCHAR(300) NOT NULL COMMENT '주민번호'  COLLATE 'utf8mb4_general_ci',
	`addr1` VARCHAR(100) NOT NULL COMMENT '주소'  COLLATE 'utf8mb4_general_ci',
	`addr2` VARCHAR(100) NOT NULL COMMENT '상세주소'  COLLATE 'utf8mb4_general_ci',
	`birthday` VARCHAR(10) NOT NULL COMMENT '생년월일(YYYY-MM-DD)'  COLLATE 'utf8mb4_general_ci',
	`jobCode` CHAR(2) NOT NULL COMMENT '직업코드'  COLLATE 'utf8mb4_general_ci',
	`mileage` INT  NULL DEFAULT 0 COMMENT '마일리지',
	`memberState` CHAR(1) NULL DEFAULT 'N' COMMENT '회원상태'  COLLATE 'utf8mb4_general_ci',
	`regDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`leaveDate` DATETIME NULL DEFAULT NULL COMMENT '등록일',
	`pwdChangeDate` DATETIME NULL DEFAULT NULL COMMENT '비밀번호 변경일',
	PRIMARY KEY(`memberId`) USING BTREE,
	INDEX `IDX_tbl_member_name` (`name`) USING btree
)
COMMENT ='회원테이블'
COLLATE 'utf8mb4_general_ci'
ENGINE=INNODB;

CREATE TABLE `tbl_bbs`(
	`idx` INT NOT NULL AUTO_INCREMENT COMMENT '인덱스',
	`refIdx` INT NULL DEFAULT 0 COMMENT '참조글 인덱스',
	`levelIdx` INT  NULL DEFAULT 0 COMMENT '글레벨',
	`sortOrder` INT  NULL DEFAULT 1 COMMENT '댓글 정렬 순서',
	`memberId` VARCHAR(20) NOT NULL COMMENT '아이디' COLLATE 'utf8mb4_general_ci',
	`title` VARCHAR(200) NOT NULL COMMENT '글제목' COLLATE 'utf8mb4_general_ci',
	`content` TEXT NOT NULL COMMENT '글 내용' COLLATE 'utf8mb4_general_ci',
	`displayDate` CHAR(10) NULL default null COMMENT '글노출일자(YYY-MM-DD)' COLLATE 'utf8mb4_general_ci',
	`regDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`modifyDate`DATETIME NULL DEFAULT NOW() COMMENT  '수정일',
	`readCnt` INT  NULL DEFAULT 0 COMMENT '조회수',
	`filePath` VARCHAR(200) NULL default NULL COMMENT '파일저장경로' COLLATE 'utf8mb4_general_ci',
	`fileName` VARCHAR(100) NULL default NULL COMMENT '파일명' COLLATE 'utf8mb4_general_ci',
	`fileExt` VARCHAR(10) NULL default NULL COMMENT '파일확장자' COLLATE 'utf8mb4_general_ci',
	`fileSize` INT  NULL DEFAULT  0 NULL COMMENT '파일사이즈' ,
	PRIMARY KEY (`idx`) USING BTREE,
	INDEX `FK_BBS_tbl_member` (`memberId`) USING BTREE,
	CONSTRAINT `FK_BBS_tbl_member` FOREIGN KEY (`memberId`) REFERENCES `tbl_member` (`memberId`) ON UPDATE CASCADE ON DELETE CASCADE
)COMMENT ='게시판테이블'
COLLATE 'utf8mb4_general_ci'
ENGINE=INNODB;

INSERT INTO tbl_member(memberId, `name`, pwd)
VALUES('user1','홍길동','1234')
		,('user2','홍길순','1234')
		,('user3','하니','1234')
		,('user4','해인','1234')
		,('user5','블핑','1234')
		,('user6','홍길동1','1234')
		,('user7','홍길남','1234')
		,('user8','홍길녁','1234')
		,('user9','최사랑','1234')
		,('user10','조수진','1234')
;

SELECT * from tbl_member;

SELECT * from tbl_bbs;

SELECT memberId, `name`, pwd FROM tbl_member;
SELECT * from tbl_member WHERE memberId='user10' AND pwd='1234';

INSERT INTO tbl_member(memberId, `name`, pwd)
VALUES('11','홍길동','1234');

INSERT INTO tbl_bbs(title, memberId, content)
VALUES('테스트확인','user10','내용1');

DELETE FROM tbl_bbs WHERE idx=10;