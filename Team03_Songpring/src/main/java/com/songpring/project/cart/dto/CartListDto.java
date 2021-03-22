package com.songpring.project.cart.dto;

import java.util.Date;

public class CartListDto {

	private int cartNum;
	private String userId;
	private int gdsNum;
	private int cartStock;
	private Date addDate;

	private int num;
	private String gdsName;
	private String genre;
	private int gdsPrice;
	private String gdsThumbImg;

	public CartListDto() {
	}

	public CartListDto(int cartNum, String userId, int gdsNum, int cartStock, Date addDate, int num, String gdsName,
			String genre, int gdsPrice, String gdsThumbImg) {
		super();
		this.cartNum = cartNum;
		this.userId = userId;
		this.gdsNum = gdsNum;
		this.cartStock = cartStock;
		this.addDate = addDate;
		this.num = num;
		this.gdsName = gdsName;
		this.genre = genre;
		this.gdsPrice = gdsPrice;
		this.gdsThumbImg = gdsThumbImg;
	}

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getGdsNum() {
		return gdsNum;
	}

	public void setGdsNum(int gdsNum) {
		this.gdsNum = gdsNum;
	}

	public int getCartStock() {
		return cartStock;
	}

	public void setCartStock(int cartStock) {
		this.cartStock = cartStock;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getGdsName() {
		return gdsName;
	}

	public void setGdsName(String gdsName) {
		this.gdsName = gdsName;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public int getGdsPrice() {
		return gdsPrice;
	}

	public void setGdsPrice(int gdsPrice) {
		this.gdsPrice = gdsPrice;
	}

	public String getGdsThumbImg() {
		return gdsThumbImg;
	}

	public void setGdsThumbImg(String gdsThumbImg) {
		this.gdsThumbImg = gdsThumbImg;
	}

}
