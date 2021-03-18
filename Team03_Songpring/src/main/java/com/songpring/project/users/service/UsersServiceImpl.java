package com.songpring.project.users.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.users.dao.UsersDao;
import com.songpring.project.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService {
	@Autowired
	private UsersDao dao;
	
	@Override
	public void usersList(ModelAndView mView, HttpServletRequest request) {
		// 한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = 20;
		// 하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT = 5;

		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum = 1;
		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum = request.getParameter("pageNum");
		// 만일 페이지 번호가 파라미터로 넘어 온다면
		if (strPageNum != null) {
			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		/*
		 * [ 검색 키워드에 관련된 처리 ] -검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.
		 */
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");
		String grade = request.getParameter("grade");
		String order=request.getParameter("order");
		// 만일 키워드가 넘어오지 않는다면
		if (keyword == null) {
			// 키워드와 검색 조건에 빈 문자열을 넣어준다.
			// 클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서
			keyword = "";
			condition = "";
		}
		if(grade==null) grade="";
		if(order==null) order="";

		// 특수기호를 인코딩한 키워드를 미리 준비한다.
		String encodedK = URLEncoder.encode(keyword);

		// startRowNum 과 endRowNum 을 CafeDto 객체에 담고
		UsersDto dto = new UsersDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<UsersDto> list = null;
		// 전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow = 0;
		// 만일 검색 키워드가 넘어온다면
		if (!keyword.equals("")) {
			// 검색 조건이 무엇이냐에 따라 분기 하기
			if (condition.equals("name")) {
				dto.setName(keyword);
			} // 이름 검색인 경우
			else if (condition.equals("id")) {
				dto.setId(keyword);
			} // 아이디 검색인 경우
		}
		if (!grade.equals("")) dto.setGrade(grade);
		if (!order.equals("")) dto.setOrder(order);
		// 글목록 얻어오기
		list = dao.getList(dto);
		// 글의 갯수
		totalRow = dao.getCount(dto);

		// 하단 시작 페이지 번호
		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		// 하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;

		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		// 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount; // 보정해 준다.
		}

		// view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("condition", condition);
		mView.addObject("keyword", keyword);
		mView.addObject("order", order);
		mView.addObject("grade", grade);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);
	}

	@Override
	public void updateGrade(ModelAndView mView, HttpServletRequest request) {
		String pageNum = request.getParameter("pageNum");
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");
		String grade = request.getParameter("grade");
		String order=request.getParameter("order");
		UsersDto dto=new UsersDto();
		String id=request.getParameter("id");
		dto.setId(id);
		dto.setGrade(grade);
		int isSuccess=dao.updateGrade(dto);
		mView.addObject("isSuccess", isSuccess);
		mView.addObject("condition", condition);
		mView.addObject("keyword", keyword);
		mView.addObject("order", order);
		mView.addObject("grade", grade);
		mView.addObject("pageNum", pageNum);
	}
	
	@Override
	public void addUser(UsersDto dto) {
		//비밀번호를 암호화할 객체 생성
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
		//입력한 비밀번호를 암호화 한다.
		String encodedPwd=encoder.encode(dto.getPwd());
		//UsersDto 에 다시 넣어준다.
		dto.setPwd(encodedPwd);
		
		dao.insert(dto);

	}

	@Override
	public boolean isExistId(String inputId) {
		// id  존재 여부를 리턴해준다. 
		return dao.isExist(inputId);
	}

	@Override
	public void loginformLogic(HttpServletRequest request, 
				ModelAndView mView) {
		// GET 방식 파라미터 url 이라는 이름으로 전달되는 값이 있는지 읽어와보기
		String url=request.getParameter("url");
		//만일 넘어오는 값이 없다면 
		if(url==null){
			//로그인 후에  home.do 요청이 되도록 절대 경로를 구성한다.
			String cPath=request.getContextPath();
			url=cPath+"/home.do";
		}
		//쿠키에 저장된 아이디와 비밀번호를 담을 변수
		String savedId="";
		String savedPwd="";
		//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
		Cookie[] cooks=request.getCookies();
		if(cooks!=null){
			//반복문 돌면서 쿠키객체를 하나씩 참조해서 
			for(Cookie tmp: cooks){
				//저장된 키값을 읽어온다.
				String key=tmp.getName();
				//만일 키값이 savedId 라면 
				if(key.equals("savedId")){
					//쿠키 value 값을 savedId 라는 지역변수에 저장
					savedId=tmp.getValue();
				}
				if(key.equals("savedPwd")){
					savedPwd=tmp.getValue();
				}
				
			}
		}			
		//view page 에서 필요한 데이터를 담는다. 
		mView.addObject("url", url);
		mView.addObject("savedId", savedId);
		mView.addObject("savedPwd", savedPwd);
	}

	@Override
	public void loginLogic(HttpServletRequest request, HttpServletResponse response) {
		//로그인후 가야하는 목적지 정보
		String url=request.getParameter("url");
		//로그인 실패를 대비해서 목적지 정보를 인코딩한 결과도 준비 한다.
		String encodedUrl=URLEncoder.encode(url);
		//1. 폼전송되는 아이디와 비밀번호를 읽어온다.
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		//유효한 정보인지 여부를 담을 지역 변수를 만들고 초기값 false 지정
		boolean isValid=false;
		//2. 아이디를 이용해서 암호화된 비밀번호를 SELECT 한다.
		String savedPwd=dao.getPwd(id);
		//3. 비밀번호가 만약 null 이 아니면(존재하는 아이디)
		if(savedPwd !=null) {
			//4. 폼전송되는 비밀번호와 일치하는지 확인한다.
			isValid=BCrypt.checkpw(pwd, savedPwd);
		}
		//5. 유효한 정보이면 로그인 처리를 하고 응답 그렇지 않으면 아이디혹은 비밀번호가 틀렸다고 응답
		if(isValid) {
			//HttpSession 객체를 이용해서 로그인 처리를 한다. 
			request.getSession().setAttribute("id", id);
			// 유저의 권한을 세션에 저장한다.(권한 확인용)
			String userGrade=dao.getGrade(id);
			request.getSession().setAttribute("userGrade", userGrade);
		}
		//체크박스를 체크 하지 않았으면 null 이다. 
		String isSave=request.getParameter("isSave");
		
		if(isSave == null){//체크 박스를 체크 안했다면
			//저장된 쿠키 삭제 
			Cookie idCook=new Cookie("savedId", id);
			idCook.setMaxAge(0);//삭제하기 위해 0 으로 설정 
			response.addCookie(idCook);
			
			Cookie pwdCook=new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(0);
			response.addCookie(pwdCook);
		}else{//체크 박스를 체크 했다면 
			//아이디와 비밀번호를 쿠키에 저장
			Cookie idCook=new Cookie("savedId", id);
			idCook.setMaxAge(60*60*24);//하루동안 유지
			response.addCookie(idCook);
			
			Cookie pwdCook=new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(60*60*24);
			response.addCookie(pwdCook);
		}
		//view page 에서 필요한 데이터를 request 에 담고
		request.setAttribute("encodedUrl", encodedUrl);
		request.setAttribute("url", url);
		request.setAttribute("isValid", isValid);		
	}

	@Override
	public void getInfo(ModelAndView mView, HttpSession session) {
		//로그인된 아이디를 읽어와서
		String id=(String)session.getAttribute("id");
		//개인정보를 읽어온다.
		UsersDto dto=dao.getData(id);
		//읽어온 정보를 ModelAndView 객체에 담아준다.
		mView.addObject("dto", dto);
		
	}

	@Override
	public void deleteUser(HttpSession session) {
		//로그인된 아이디를 읽어온다.
		String id=(String)session.getAttribute("id");
		//DB에서 삭제
		dao.delete(id);
		//세션에 저장된 id 삭제 => 로그아웃 처리
		session.removeAttribute("id");
	}

	@Override
	public void updateUserPwd(ModelAndView mView, UsersDto dto, HttpSession session) {
		//로그인된 아이디를 읽어와서
		String id=(String)session.getAttribute("id");
		// 아이디를 이용해서 암호화된 비밀번호를 SELECT 한다.
		String savedPwd=dao.getPwd(id);
		
		// 폼전송되는 비밀번호와 일치하는지 확인한다.
		boolean isValid=BCrypt.checkpw(dto.getPwd(), savedPwd);
		//2. 만약 맞다면 
		if(isValid) {
			//3. 새 비밀번호를 암호화 해서
			String newPwd=new BCryptPasswordEncoder().encode(dto.getNewPwd());
			//4. dto에 아이디 수정 반영한다.
			dto.setId(id);
			dto.setNewPwd(newPwd);
			dao.updatePwd(dto);
			//로그아웃 처리를 한다.
			session.removeAttribute("id");
		}
		mView.addObject("isSuccess", isValid);
		
		
	}

	@Override
	public void saveProfileImage(MultipartFile image, HttpServletRequest request) {
		//원본 파일명
		String orgFilename=image.getOriginalFilename();
		//파일을 저장할 실제 경로 "/webapp/upload"
		String realPath=request.getServletContext().getRealPath("/upload");
		
		File f=new File(realPath);
		if(!f.exists()) {//만일 존재하지 않으면
			f.mkdir();//폴더를 만든다.
		}
		//저장할 파일명을 구성한다.
		String saveFileName=System.currentTimeMillis()+orgFilename;
		//저장할 파일의 전체 경로를 구성한다.
		String path=realPath+File.separator+saveFileName;
		try {
			//임시폴더에 업로드된 파일을 원하는 위치에 원하는 파일명으로 이동 시킨다.
			image.transferTo(new File(path));
		}catch(Exception e) {
			e.printStackTrace();
		}
		//DB 에 저장할 이미지의 경로
		String profile="/upload/"+saveFileName;
		//로그인된 아이디
		String id=(String)request.getSession().getAttribute("id");
		//수정할 정보를 dto 에 담기
		UsersDto dto=new UsersDto();
		dto.setId(id);
		dto.setProfile(profile);
		//dao 를 이용해서 수정 반영하기
		dao.updateProfile(dto);
	}

	@Override
	public void updateUser(UsersDto dto, HttpSession session) {
		//로그인된 아이디를 읽어온다.
		String id=(String)session.getAttribute("id");
		//dto 에 담는다.
		dto.setId(id);
		//dao 를 이용해서 DB에 수정반영한다.
		dao.update(dto);
	}

	@Override
	public void findid(HttpServletRequest request, ModelAndView mView) {
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		UsersDto dto2=new UsersDto();
		dto2.setName(name);
		dto2.setEmail(email);
		UsersDto dto=dao.findid(dto2);
		mView.addObject("dto", dto);
		
	}

	@Override
	public void findpwd(ModelAndView mView, UsersDto dto, HttpServletRequest request) {
		//로그인된 아이디를 읽어와서
		String id=request.getParameter("id");		

		// 새 비밀번호를 암호화 해서
		String newPwd=new BCryptPasswordEncoder().encode(dto.getNewPwd());
		//4. dto에 아이디 수정 반영한다.
		dto.setId(id);
		dto.setNewPwd(newPwd);
		dao.findpwd(dto);
		//로그아웃 처리를 한다.
		//session.removeAttribute("id");

		mView.addObject("dto",dto);
	}
}
