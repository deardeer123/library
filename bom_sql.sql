-- 책 정보 insert 문법
LOAD DATA LOCAL INFILE 'D:/01-STUDY/insertData_2.csv'
INTO TABLE BOOK
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- 대출 테이블
CREATE TABLE BOOK_BORROW(
BR_CODE INT AUTO_INCREMENT PRIMARY KEY
    , BORROW_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, RETURN_YN VARCHAR(2) NOT NULL DEFAULT 'N'
	, EX_RETURN_DATE DATETIME
	, BORROW_USER_CODE INT REFERENCES USERS(USER_CODE)
	, BOOK_CODE VARCHAR(20) REFERENCES BOOK(BOOK_CODE));

-- 반납 예정일 INSERT 쿼리
SELECT DATE_ADD(NOW(), INTERVAL +14 DAY);

-- DROP TABLE BOOK_BORROW;

-- 반납 테이블
CREATE TABLE BOOK_RETURN(
RT_CODE INT AUTO_INCREMENT PRIMARY KEY
	, RETURN_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, RETURN_USER_CODE INT REFERENCES USERS(USER_CODE)
	, BOOK_CODE VARCHAR(20) REFERENCES BOOK(BOOK_CODE));

-- MEMBER_CARD (24.03.05 수정)
DROP TABLE MEMBER_CARD;

-- MEMBER_CARD의 일부 기능 USERS로 병합 (24.03.05 수정)
CREATE TABLE USERS(
	USER_CODE INT AUTO_INCREMENT PRIMARY KEY
	, USER_ID VARCHAR(20) NOT NULL
	, USER_PW VARCHAR(100) NOT NULL
	, USER_NAME VARCHAR(20) NOT NULL
	, USER_TEL VARCHAR(20) NOT NULL
	, POST_CODE INT NOT NULL
	, USER_ADDR VARCHAR(50) NOT NULL
	, ADDR_DETAIL VARCHAR(50) NOT NULL
	, GENDER VARCHAR(2) NOT NULL
	, EMAIL VARCHAR(50) NOT NULL
	, IS_ADMIN VARCHAR(2) DEFAULT 'N'
	, CARD_NUM INT
	, PUBLISH_DATE DATETIME
	, USER_INTRO VARCHAR(200)
	, CARD_STATUS VARCHAR(10) DEFAULT '사용중'
	); -- N,Y

ALTER TABLE USERS ADD COLUMN CARD_NUM INT;
ALTER TABLE USERS ADD COLUMN PUBLISH_DATE DATETIME;
ALTER TABLE USERS ADD COLUMN USER_INTRO VARCHAR(200);
ALTER TABLE USERS ADD COLUMN CARD_STATUS VARCHAR(10) DEFAULT '사용중';

-- 24.03.07 USERS 테이블 컬럼 변경
ALTER TABLE USERS CHANGE USER_PW USER_PW VARCHAR(100) NOT NULL;
ALTER TABLE USERS CHANGE CARD_NUM CARD_NUM INT;


-- 이용자 정보 insert 문

INSERT INTO users(
	USER_CODE
	, USER_ID
	, USER_PW
	, USER_NAME
	, USER_TEL
	, POST_CODE
	, USER_ADDR
	, ADDR_DETAIL
	, GENDER
	, EMAIL
	, IS_ADMIN
) VALUES (
	1
	, 'ver054'
	, '1234'
	, '김봄이'
	, '010-1111-2222'
	, 12345
	, '울산시 남구'
	, '그린아카데미'
	, '여자'
	, '1234@gmail.com'
	, 'Y'
);