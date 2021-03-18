package com.songpring.project.users.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.users.dto.UsersDto;

public interface UsersService {
	// 회원 정보 목록
	public void usersList(ModelAndView mView, HttpServletRequest request);
	// 권한 부여
	public void updateGrade(ModelAndView mView, HttpServletRequest request);
	//회원 가입 처리를 하는 메소드 
	public void addUser(UsersDto dto);
	//아이디가 존재하는지 여부를 리턴하는 메소드
	public boolean isExistId(String inputId);
	//로그인폼에 관련된 처리를 하는 메소드
	public void loginformLogic(HttpServletRequest request, ModelAndView mView);
	//로그인 관련 처리를 하는 메소드
	public void loginLogic(HttpServletRequest request, HttpServletResponse response);
	//개인정보를 ModelAndView 객체에 담아주는 메소드
	public void getInfo(ModelAndView mView, HttpSession session);
	//개인정보를 삭제처리 하는 메소드
	public void deleteUser(HttpSession session);
	//비밀번호 수정 처리를 하고 성공여부를 ModelAndView 객체에다 담아주는 메소드
	public void updateUserPwd(ModelAndView mView, UsersDto dto, HttpSession session);
	//프로필 이미지를 upload 폴더에 저장하고 저장된 파일명을 DB 에 저장하는 메소드
	public void saveProfileImage(MultipartFile image, HttpServletRequest request);
	//개인정보를 수정하는 메소드(여기에서는 이메일주소만)
	public void updateUser(UsersDto dto, HttpSession session);
	//아이디를 이름과 이메일로 찾는 메소드
	public void findid(HttpServletRequest request, ModelAndView mView);
	//비밀번호 수정 처리를 하고 성공여부를 ModelAndView 객체에다 담아주는 메소드
	public void findpwd(ModelAndView mView, UsersDto dto, HttpServletRequest request);
}
