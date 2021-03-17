package com.songpring.project.shop.dto;

public class ShopDto {
	// 필드
	private int num; // 책번호
	private String title; // 책 제목
	private String imagePath; // 책 표지
	private String genre; // 장르(소설, 교양, 문제집, 만화, 사전)
	private String writer; // 책 저자
	private String publisher; // 출판사
	private int price; // 책 가격(원)
	private String regdate; // 출판 날짜
	private String content; // 책 설명
	private int sellCount; // 판매횟수
	private int page; // 책 쪽수
	private String bookSize; // 책 크기(가로*세로*높이)
	// 정렬
	private String order; // 정렬 기준 (최고가 highPrice, 최저가 lowPrice, 판매수 sellCount, 신상품 date)
	// 페이징 처리
	private int startRowNum;
	private int endRowNum;
	// 생성자
	public ShopDto() {}
	public ShopDto(int num, String title, String imagePath, String genre, String writer, String publisher, int price,
			String regdate, String content, int sellCount, int page, String bookSize, String order, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.title = title;
		this.imagePath = imagePath;
		this.genre = genre;
		this.writer = writer;
		this.publisher = publisher;
		this.price = price;
		this.regdate = regdate;
		this.content = content;
		this.sellCount = sellCount;
		this.page = page;
		this.bookSize = bookSize;
		this.order=order;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getSellCount() {
		return sellCount;
	}
	public void setSellCount(int sellCount) {
		this.sellCount = sellCount;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getBookSize() {
		return bookSize;
	}
	public void setBookSize(String bookSize) {
		this.bookSize = bookSize;
	}
	public int getStartRowNum() {
		return startRowNum;
	}
	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}
	public int getEndRowNum() {
		return endRowNum;
	}
	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
}
