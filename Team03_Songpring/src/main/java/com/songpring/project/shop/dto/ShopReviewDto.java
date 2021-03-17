package com.songpring.project.shop.dto;

public class ShopReviewDto {
	private int num;// 글 번호
	private int bookNum;// 책 번호
	private String writer;// 작성자(고객)
	private String content;// 내용
	private String regdate;// 작성일
	private int startRowNum;
	private int endRowNum;
	public ShopReviewDto() {}
	public ShopReviewDto(int num, int bookNum, String writer, String content, String regdate,
			int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.bookNum = bookNum;
		this.writer = writer;
		this.content = content;
		this.regdate = regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getBookNum() {
		return bookNum;
	}
	public void setBookNum(int bookNum) {
		this.bookNum = bookNum;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
}
