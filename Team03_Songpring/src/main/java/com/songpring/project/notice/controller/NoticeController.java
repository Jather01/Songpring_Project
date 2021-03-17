package com.songpring.project.notice.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.notice.dto.NoticeDto;
import com.songpring.project.notice.service.NoticeService;

@Controller
public class NoticeController {
	//의존객체 DI
	@Autowired
	private NoticeService service;
	
	@RequestMapping("/notice/manager/delete")
	public String delete(int num) {
		service.deleteNotice(num);
		return "notice/manager/delete";
	}
	
	@RequestMapping("/notice/manager/insert")
	public String insert(NoticeDto dto) {
		service.saveNotice(dto);
		return "notice/manager/insert";
	}
	
	@RequestMapping("/notice/manager/insertform")
	public String insertform() {
		return "notice/manager/insertform";
	}
	
	@RequestMapping("/notice/manager/update")
	public String update(NoticeDto dto, HttpServletRequest request) {
		request.setAttribute("num", dto.getNum());
		service.updateNotice(dto);
		return "notice/manager/update";
	}
	
	@RequestMapping("/notice/manager/updateform")
	public ModelAndView updateform(int num, ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("notice/manager/updateform");
		return mView;
	}
	
	@RequestMapping("/notice/list")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("notice/list");
		return mView;
	}
	
	@RequestMapping("/notice/detail")
	public ModelAndView detail(int num, ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("notice/detail");
		return mView;
	}
}
