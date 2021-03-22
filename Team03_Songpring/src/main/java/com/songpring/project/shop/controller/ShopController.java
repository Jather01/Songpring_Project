package com.songpring.project.shop.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.cart.dto.CartDto;
import com.songpring.project.cart.dto.CartListDto;
import com.songpring.project.order.dto.OrderDetailDto;
import com.songpring.project.order.dto.OrderDto;
import com.songpring.project.shop.dto.ShopDto;
import com.songpring.project.shop.dto.ShopReviewDto;
import com.songpring.project.shop.service.ShopService;
import com.songpring.project.users.dto.UsersDto;

@Controller
public class ShopController {
	// 의존객체 DI
	@Autowired
	private ShopService service;
	
	// 책 판매 종료
	@RequestMapping("/shop/manager/delete")
	public String delete(@RequestParam int num) {
		service.deleteAllReivews(num);
		service.deleteBook(num);
		return "shop/manager/delete";
	}
	// 책 정보 수정 폼
	@RequestMapping("/shop/manager/updateform")
	public ModelAndView updateform(@RequestParam int num, HttpServletRequest request, ModelAndView mView) {
		service.getDetail(num, request, mView);
		mView.setViewName("shop/manager/updateform");
		return mView;
	}
	// 책 정보 수정
	@RequestMapping(value = "/shop/manager/update", method = RequestMethod.POST)
	public String update(@ModelAttribute("dto") ShopDto dto, HttpServletRequest request) {
		request.setAttribute("num", dto.getNum());
		service.updateBook(dto);
		return "shop/manager/update";
	}
	// 책 상세 페이지
	@RequestMapping("/shop/detail")
	public ModelAndView detail(@RequestParam int num, HttpServletRequest request, ModelAndView mView) {
		//자세히 보여줄 글번호가 파라미터로 넘어온다.
		service.getDetail(num, request, mView);
		//view page 로 forward 이동해서 응답
		mView.setViewName("shop/detail");
		return mView;
	}
	// 책 목록
	@RequestMapping("/shop/list1")
	public ModelAndView list1(ModelAndView mView, HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("shop/list1");
		return mView;
	}
	// 책 판매 업로드
	@RequestMapping(value = "/shop/manager/upload", method = RequestMethod.POST)
	public String upload(ShopDto dto, HttpSession session) {
		//서비스를 통해서 새글을 DB 에저장
		service.saveBook(dto);
		return "shop/manager/upload";
	}
	// 책 판매 업로드폼
	@RequestMapping("/shop/manager/uploadform")
	public String uploadform() {
		return "shop/manager/uploadform";
	}
	// 사진 미리보기
	@RequestMapping(value = "/shop/manager/ajax_upload", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxUpload(MultipartFile image, HttpServletRequest request){
		//업로드된 이미지를 upload 폴더에 저장하고 경로를 리턴 받는다.
		String imagePath=service.ajaxImage(image, request);
		//저장된 경로를 JSON 문자열로 응답하기 위해 Map 에 담는다.
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("imagePath", imagePath);
		return map;
	}
	// 리뷰 등록
	@RequestMapping(value = "/shop/private/review_insert", method = RequestMethod.POST)
	public String reviewInsert(HttpServletRequest request, @RequestParam int bookNum) {
		//새 리뷰를 저장하고
		service.insertReview(request);
		//글 자세히 보기로 다시 리다일렉트 이동 시킨다.
		return "redirect:/shop/detail.do?num="+bookNum;
	}
	// 리뷰 수정
	@RequestMapping(value = "/shop/private/review_update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reviewUpdate(ShopReviewDto dto){
		//댓글을 수정 반영하고 
		service.updateReview(dto);
		//JSON 문자열을 클라이언트에게 응답한다.
		Map<String, Object> map=new HashMap<>();
		map.put("num", dto.getNum());
		map.put("content", dto.getContent());
		return map;
	}
	// 리뷰 삭제
	@RequestMapping("/shop/private/review_delete")
	public ModelAndView commentDelete(HttpServletRequest request, ModelAndView mView, @RequestParam int bookNum) {
		service.deleteReview(request);
		mView.setViewName("redirect:/shop/detail.do?num="+bookNum);
		return mView;
	}

	// 카트 담기
	@ResponseBody
	@RequestMapping(value = "/shop/private/addCart", method = RequestMethod.POST)
	public int addCart(CartDto cart, HttpSession session) {

		int result = 0;

		String id = (String) session.getAttribute("id");

		if (id != null) {
			cart.setUserId(id);
			service.addCart(cart);
			result = 1;
		}

		return result;
	}

	// 카트목록
	@RequestMapping("/shop/private/cartList")
	public ModelAndView getCartList(HttpSession session, ModelAndView mView) {
		String userId=(String)session.getAttribute("id");

		List<CartListDto> cartList = service.cartList(userId);
		mView.addObject("cartList", cartList);
		mView.setViewName("shop/private/cartList");
		return mView;
	}

	// 카트 삭제
	@ResponseBody
	@RequestMapping(value = "/shop/private/deleteCart", method = RequestMethod.POST)
	public int deleteCart(HttpSession session, @RequestParam(value = "chbox[]") List<String> chArr, CartDto cart){
		String userId = (String)session.getAttribute("id");

		int result = 0;
		int cartNum = 0;

		if (userId != null) {
			cart.setUserId(userId);
			for (String i : chArr) {
				cartNum = Integer.parseInt(i);
				cart.setCartNum(cartNum);
				service.deleteCart(cart);
			}
			result = 1;
		}
		return result;
	}
	//카트 상품 주문
	@RequestMapping(value = "/shop/private/cartList", method = RequestMethod.POST)
	public String order(HttpSession session, OrderDto order, OrderDetailDto orderDetail){

	UsersDto users = (UsersDto) session.getAttribute("users");
	String userId = users.getId();

	Calendar cal = Calendar.getInstance();
	 int year = cal.get(Calendar.YEAR);
	 String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
	 String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
	 String subNum = "";

	 for(int i = 1; i <= 6; i ++) {
	  subNum += (int)(Math.random() * 10);
	 }

	 String orderId = ymd + "_" + subNum;

	 order.setOrderId(orderId);
	 order.setUserId(userId);


	 service.orderInfo(order); 

	 orderDetail.setOrderId(orderId);   
	 service.orderInfo_Details(orderDetail); 

	 service.cartAllDelete(userId);

	 return "redirect:/shop/private/orderList";  
	}

}