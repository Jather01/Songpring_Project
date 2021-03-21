package com.songpring.project.shop.dao;

import java.util.List;

import com.songpring.project.cart.dto.CartDto;
import com.songpring.project.cart.dto.CartListDto;
import com.songpring.project.order.dto.OrderDetailDto;
import com.songpring.project.order.dto.OrderDto;
import com.songpring.project.shop.dto.ShopDto;

public interface ShopDao {
	//책 추가
	public void insert(ShopDto dto);
	//책 수정
	public void update(ShopDto dto);
	//책 삭제
	public void delete(int num);
	//책 하나의 정보 얻어오기
	public ShopDto getData(int num);
	// 책 4개의 정보를 랜덤으로 얻어오기
	public List<ShopDto> getDataRandom();
	//책 목록 얻어오기 (페이징 처리와 검색 키워드를 고려한 목록)
	public List<ShopDto> getList(ShopDto dto);
	//책의 갯수 얻어오기(검색 키워드에 해당하는 갯수)
	public int getCount(ShopDto dto);
	//책 판매량 올리기
	public void addSellCount(int num);
	//카트 담기
	public void addCart(CartDto cart);
	//카트 리스트
	public List<CartListDto> cartList(String userId);
	//카트 삭제
	public void deleteCart(CartDto cart);
	// 주문 정보
	public void orderInfo(OrderDto order);	
	// 주문 상세 정보
	public void orderInfo_Details(OrderDetailDto orderDetail);
	// 카트 비우기
	public void cartAllDelete(String userId);
}
