package com.songpring.project.shop.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.cart.dto.CartDto;
import com.songpring.project.cart.dto.CartListDto;
import com.songpring.project.order.dto.OrderDetailDto;
import com.songpring.project.order.dto.OrderDto;
import com.songpring.project.shop.dto.ShopDto;
import com.songpring.project.shop.dto.ShopReviewDto;

public interface ShopService {
	// 새 책 판매
	public void saveBook(ShopDto dto);
	// 책 목록&페이징 처리에 필요한 정보 
	public void getList(ModelAndView mView, HttpServletRequest request);
	// 책 하나의 정보
	public void getDetail(int num, HttpServletRequest request, ModelAndView mView);
	// 랜덤한 책 하나의 정보
	public void getDataRandom(ModelAndView mView);
	// 책 정보 수정
	public void updateBook(ShopDto dto);
	// 책 판매 종료
	public void deleteBook(int num);
	// 판매량 업데이트
	public void addSellCount(int num);
	// ajax 이미지 불러오기
	public String ajaxImage(MultipartFile image, HttpServletRequest request);
	// 리뷰 등록
	public void insertReview(HttpServletRequest request);
	// 리뷰 삭제
	public void deleteReview(HttpServletRequest request);
	// 책 판매 글 삭제할 때 리뷰 전부 삭제
	public void deleteAllReivews(int bookNum);
	// 리뷰 수정
	public void updateReview(ShopReviewDto dto);
	//카트 담기
	public void addCart(CartDto cart);
	//카트 목록
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
