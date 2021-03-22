package com.songpring.project.shop.service;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.Exception.DBFailException;
import com.songpring.project.cart.dto.CartDto;
import com.songpring.project.cart.dto.CartListDto;
import com.songpring.project.order.dto.OrderDetailDto;
import com.songpring.project.order.dto.OrderDto;
import com.songpring.project.shop.dao.ShopDao;
import com.songpring.project.shop.dao.ShopReviewDao;
import com.songpring.project.shop.dto.ShopDto;
import com.songpring.project.shop.dto.ShopReviewDto;
import com.songpring.project.users.dao.UsersDao;

@Service
public class ShopServiceImpl implements ShopService {
	//의존객체 DI 
	@Autowired
	private ShopDao shopDao;
	@Autowired
	private ShopReviewDao reviewDao;
	@Autowired
	private UsersDao usersDao;

	@Override
	public void saveBook(ShopDto dto) {
		shopDao.insert(dto);
	}
	@Override
	public void getList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=10;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
		
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		/*
			[ 검색 키워드에 관련된 처리 ]
			-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
		*/
		String condition=request.getParameter("condition");
		String keyword=request.getParameter("keyword");
		String genre=request.getParameter("genre");
		String order=request.getParameter("order");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null) {
			keyword="";
			condition=""; 
		}
		if(genre==null) genre="";
		if(order==null) order="";
		
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//startRowNum 과 endRowNum  을 CafeDto 객체에 담고
		ShopDto dto=new ShopDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<ShopDto> list=null;
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")) {
			if(condition.equals("all")) {
				dto.setGenre("all");
				dto.setTitle(keyword);
			} else {
				dto.setGenre(condition);
				dto.setTitle(keyword);
			}
		}
		if(!genre.equals("")) dto.setGenre(genre);
		if(!order.equals("")) dto.setOrder(order);
		
		//글목록 얻어오기
		list=shopDao.getList(dto);
		//글의 갯수
		totalRow=shopDao.getCount(dto);
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("genre", genre);
		mView.addObject("condition", condition);
		mView.addObject("order", order);
		mView.addObject("keyword", keyword);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);
	}
	@Override
	public void getDetail(int num, HttpServletRequest request, ModelAndView mView) {
		//글번호를 이용해서 글정보를 얻어오고 
		ShopDto shopDto=shopDao.getData(num);
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=20;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
		
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//startRowNum 과 endRowNum을 CafeDto 객체에 담고
		ShopReviewDto dto=new ShopReviewDto();
		dto.setBookNum(num);
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<ShopReviewDto> reviewList=reviewDao.getList(dto);
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=reviewDao.getCount(num);
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		String id=(String) request.getSession().getAttribute("id");
		if(id!=null) {
			dto.setWriter(id);
			int checkReviewCount=reviewDao.checkReviewCount(dto);
			mView.addObject("checkReviewCount", checkReviewCount);
		}
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("reviewList", reviewList);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("totalRow", totalRow);
		mView.addObject("shopDto", shopDto);
	}
	@Override
	public void getDataRandom(ModelAndView mView) {
		List<ShopDto> list=shopDao.getDataRandom();
		mView.addObject("list",list);
	}
	@Override
	public void updateBook(ShopDto dto) {
		shopDao.update(dto);
	}
	@Override
	public void deleteBook(int num) {
		shopDao.delete(num);
	}
	@Override
	public void addSellCount(int num) {
		shopDao.addSellCount(num);
	}
	@Override
	public String ajaxImage(MultipartFile image, HttpServletRequest request) {
		// 원본 파일명
		String orgFileName=image.getOriginalFilename();
		// webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로)
		String realPath=request.getServletContext().getRealPath("/upload");
		//저장할 파일의 상세 경로
		String filePath=realPath+File.separator;
		//해당 경로를 access 할수 있는 파일 객체 생성
		File f=new File(filePath);
		if(!f.exists()){ //만일  폴더가 존재 하지 않으면
			f.mkdir(); //upload 폴더 만들기 
		}
		//저장할 파일 명을 구성한다.
		String saveFileName=System.currentTimeMillis()+orgFileName;
		try {
			//upload 폴더에 파일을 저장한다.
			image.transferTo(new File(filePath+saveFileName));
			System.out.println(filePath+saveFileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//업로드 경로를 리턴한다.
		return "/upload/"+saveFileName;
	}
	@Override
	public void insertReview(HttpServletRequest request) {
		// 리뷰 작성자
		String writer=(String)request.getSession().getAttribute("id");
		// 책 번호
		int bookNum=Integer.parseInt(request.getParameter("bookNum"));
		String content=request.getParameter("content");
		
		ShopReviewDto dto=new ShopReviewDto();
		dto.setWriter(writer);
		dto.setBookNum(bookNum);
		dto.setContent(content);
		reviewDao.insert(dto);
	}
	@Override
	public void deleteReview(HttpServletRequest request) {
		// 리뷰 번호
		int num=Integer.parseInt(request.getParameter("num"));
		// 현재 접속 중인 아이디
		String id=(String)request.getSession().getAttribute("id");
		String writer=reviewDao.getData(num).getWriter();
		if(writer.equals(id)) {
			reviewDao.delete(num);
		} else {
			throw new DBFailException("타인의 리뷰를 삭제할 수 없습니다.");
		}
	}
	@Override
	public void deleteAllReivews(int bookNum) {
		reviewDao.deleteAllReviews(bookNum);
	}
	@Override
	public void updateReview(ShopReviewDto dto) {
		reviewDao.update(dto);
	}
	@Override
	public void addCart(CartDto cart) {
		shopDao.addCart(cart);
	}
	@Override
	public List<CartListDto> cartList(String userId) {
		return shopDao.cartList(userId);
	}
	@Override
	public void deleteCart(CartDto cart) {
		shopDao.deleteCart(cart);
	}
	@Override
	public void orderInfo(OrderDto order) {
		shopDao.orderInfo(order);	
	}
	@Override
	public void orderInfo_Details(OrderDetailDto orderDetail) {
		shopDao.orderInfo_Details(orderDetail);		
	}
	// 카트 비우기 
	@Override
	public void cartAllDelete(String userId) {
		shopDao.cartAllDelete(userId);
	}
}
