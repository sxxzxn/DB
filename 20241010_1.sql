fullstack7SELECT * FROM tbl_member;
SELECT * 
FROM tbl_bbs
ORDER BY idx DESC;

UPDATE tbl_member SET ROLE = 'admin' WHERE memberId = 'admin';

CREATE TABLE `tbl_comment` (
    `commentId` INT NOT NULL AUTO_INCREMENT COMMENT '댓글 ID',
    `writerId` VARCHAR(20) NOT NULL COMMENT '작성자 사용자 ID' COLLATE 'utf8mb4_general_ci',
    `regDate` DATETIME NOT NULL DEFAULT NOW() COMMENT '작성일',
    `bbsIdx` INT NOT NULL COMMENT '게시판 ID',tbl_bbs
    `contents` TEXT NOT NULL COMMENT '댓글 내용' COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`commentId`) USING BTREE,
    FOREIGN KEY (`bbsIdx`) REFERENCES `tbl_bbs`(`idx`) ON UPDATE CASCADE ON DELETE RESTRICT
) COMMENT='댓글 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB;


SELECT * FROM tbl_comment;

SELECT * FROM tbl_bbs;
desc tbl_bbs;

tbl_file
SELECT * FROM tbl_file;
DELETE FROM tbl_bbs WHERE fileCategory = '문서';

CREATE TABLE `tbl_file` (
	`fileIdx` INT NOT NULL AUTO_INCREMENT COMMENT '파일 번호' COLLATE 'utf8mb4_general_ci',
	`bbsIdx`  INT NULL default NULL COMMENT '파일이 저장된 게시글 번호' COLLATE 'utf8mb4_general_ci',
   `filePath` VARCHAR(200) NULL default NULL COMMENT '파일저장경로' COLLATE 'utf8mb4_general_ci',
	`fileOrgName` VARCHAR(200) NULL default NULL COMMENT '파일원본이름' COLLATE 'utf8mb4_general_ci',
	`fileNewName` VARCHAR(200) NULL default NULL COMMENT '서버에 저장된 파일명' COLLATE 'utf8mb4_general_ci',
	`fileExt` VARCHAR(10) NULL default NULL COMMENT '파일확장자' COLLATE 'utf8mb4_general_ci',
	`fileSize` INT  NULL DEFAULT  0 NULL COMMENT '파일사이즈' ,
	`fileCategory` VARCHAR(200) NULL default NULL COMMENT '파일 카테고리' COLLATE 'utf8mb4_general_ci',
	`regDate` date NULL default NULL COMMENT '파일업로드일' ,
    PRIMARY KEY (`fileIdx`) USING BTREE,
    FOREIGN KEY (`bbsIdx`) REFERENCES `tbl_bbs`(`idx`) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT='파일 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=INNODB;

tbl_comment