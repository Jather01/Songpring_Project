package com.songpring.project.notice.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.notice.dto.NoticeDto;

public interface NoticeService {
	//새글을 저장하는 메소드 
	public void saveNotice(NoticeDto dto);
	//글목록을 얻어오고 페이진 처리에 필요한 값들을 ModelAndView 객체에 담아주는 메소드 
	public void getList(ModelAndView mView, HttpServletRequest request);
	//글하나의 정보를 ModelAndView 객체에 담아주는 메소드
	public void getDetail(int num, ModelAndView mView);
	//글을 수정하는 메소드
	public void updateNotice(NoticeDto dto);
	//글을 삭제하는 메소드
	public void deleteNotice(int num);
}
