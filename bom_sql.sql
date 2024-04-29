-- 책 정보 insert 문법
LOAD DATA LOCAL INFILE 'D:/01-STUDY/insertData_2.csv'
INTO TABLE BOOK
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

-- 대출 테이블 (통계 용이성을 위해 드랍 24.03.12)
DROP TABLE BOOK_BORROW;

-- 반납 예정일 INSERT 쿼리
SELECT DATE_ADD(NOW(), INTERVAL +14 DAY);

-- 반납 테이블 (통계 용이성을 위해 드랍 24.03.12)
DROP TABLE BOOK_RETURN;

-- 대출 반납 테이블 (24.03.12 생성)
CREATE TABLE BOOK_BNR(
	BORROW_CODE INT PRIMARY KEY AUTO_INCREMENT
	, BORROW_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, RETURN_YN VARCHAR(2) DEFAULT 'N'
	, EX_RETURN_DATE DATETIME
	, RETURN_DATE DATETIME
	, USER_CODE INT REFERENCES users(USER_CODE)
	, BOOK_CODE VARCHAR(20) REFERENCES BOOK(BOOK_CODE)
);

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
	, CARD_STATUS VARCHAR(10) DEFAULT '대기중'
	); -- N,Y

ALTER TABLE USERS ADD COLUMN CARD_NUM INT;
ALTER TABLE USERS ADD COLUMN PUBLISH_DATE DATETIME;
ALTER TABLE USERS ADD COLUMN USER_INTRO VARCHAR(200);
ALTER TABLE USERS ADD COLUMN CARD_STATUS VARCHAR(10) DEFAULT '사용중';

-- 24.03.07 USERS 테이블 컬럼 변경
ALTER TABLE USERS CHANGE USER_PW USER_PW VARCHAR(100) NOT NULL;
ALTER TABLE USERS CHANGE CARD_NUM CARD_NUM INT;
-- 24.03.28 USERS 수정
ALTER TABLE USERS CHANGE CARD_STATUS CARD_STATUS VARCHAR(10) DEFAULT '대기중';

-- 24.03.27 예약 테이블 추가
CREATE TABLE BOOK_RESERVATION(
	RESERVE_CODE INT AUTO_INCREMENT PRIMARY KEY
	, USER_CODE INT REFERENCES users(USER_CODE)
	, BOOK_CODE VARCHAR(15) REFERENCES book(BOOK_CODE)
	, RESERVE_DATE DATETIME DEFAULT CURRENT_TIMESTAMP()
	, RESERVE_CANCEL DATETIME
	, RESERVE_STATUS VARCHAR(10) DEFAULT '대기중'
	, RESERVE_CNT INT DEFAULT 0);

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

-- 24.04.22 cardNum integer로 자로형 변환
-- 24.04.22 CARD_NUM 수정 UNIQUE 부여
ALTER TABLE USERS CHANGE CARD_NUM CARD_NUM INT UNIQUE;

-- 24.04.28 BOOK_RESERVATION에서 RESERVE_CNT 삭제
ALTER TABLE BOOK_RESERVATION DROP COLUMN RESERVE_CNT;
-- 24.04.28 BOOK_RESERVATION에서 RESERVE_DATE의 DEFAULT CURRENT_TIMESTAMP 삭제
ALTER TABLE BOOK_RESERVATION CHANGE RESERVE_DATE RESERVE_DATE DATETIME;
