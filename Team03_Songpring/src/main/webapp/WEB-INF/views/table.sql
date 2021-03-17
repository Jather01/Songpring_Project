--상품 데이터 베이스
CREATE TABLE songpring_shop(
	num NUMBER PRIMARY KEY,
	title VARCHAR2(100),
	imagePath VARCHAR2(100),
	genre VARCHAR2(100), -- novel, culture, workbook, comicbook, dictionary
	writer VARCHAR2(100),
	publisher VARCHAR2(100),
	regdate DATE,
	price NUMBER,
	content CLOB,
	sellCount NUMBER,
	page NUMBER,
	bookSize VARCHAR2(100)
);
-- 책 번호 시퀀스
CREATE SEQUENCE songpring_shop_seq;
-- 공지사항
CREATE TABLE songpring_notice(
	num NUMBER PRIMARY KEY,
	title VARCHAR2(100),
	content CLOB,
	regdate DATE
);
-- 공지사항 번호 시퀀스
CREATE SEQUENCE songpring_notice_seq;
-- Q&A
CREATE TABLE songpring_QnA(
	num NUMBER PRIMARY KEY, -- 글 번호
	title VARCHAR2(100),
	writer VARCHAR2(100), -- 작성자(고객)
	content CLOB, -- 내용
	regdate DATE, -- 작성일
	secret VARCHAR2(100), -- 비밀글
	managerComment CLOB -- 답변(관리자 작성)
);
-- Q&A 시퀀스
CREATE SEQUENCE songpring_QnA_seq;
-- 리뷰
CREATE TABLE songpring_review(
	num NUMBER PRIMARY KEY, -- 글 번호
	bookNum NUMBER REFERENCES songpring_shop(num), -- 책 번호
	writer VARCHAR2(100), -- 작성자(고객)
	content CLOB, -- 내용
	regdate DATE -- 작성일
);
-- 리뷰 시퀀스
CREATE SEQUENCE songpring_review_seq;