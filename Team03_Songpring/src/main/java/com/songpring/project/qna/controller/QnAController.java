package com.songpring.project.qna.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.qna.dto.QnADto;
import com.songpring.project.qna.service.QnAService;

@Controller
public class QnAController {
	@Autowired
	private QnAService service;
	
	@RequestMapping("/qna/private/delete")
	public String delete(int num) {
		service.deleteQnA(num);
		return "qna/private/delete";
	}
	
	@RequestMapping("/qna/private/insert")
	public String insert(QnADto dto) {
		service.saveQnA(dto);
		return "qna/private/insert";
	}
	
	@RequestMapping("/qna/private/insertform")
	public String insertform() {
		return "qna/private/insertform";
	}
	
	@RequestMapping("/qna/private/update")
	public String update(QnADto dto, HttpServletRequest request) {
		service.updateQnA(dto);
		request.setAttribute("num", dto.getNum());
		return "qna/private/update";
	}
	
	@RequestMapping("/qna/private/updateform")
	public ModelAndView updateform(int num, ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("qna/private/updateform");
		return mView;
	}
	
	@RequestMapping("/qna/list")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("qna/list");
		return mView;
	}
	
	@RequestMapping("/qna/detail")
	public ModelAndView detail(int num, ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("qna/detail");
		return mView;
	}

	@RequestMapping("/qna/manager/comment_update")
	public String commentUpdate(QnADto dto, int num) {
		service.commentUpdate(dto);
		return "redirect:/qna/detail.do?num="+num;
	}

	@RequestMapping("/qna/manager/comment_delete")
	public String commentDelete(int num) {
		service.commentDelete(num);
		return "redirect:/qna/detail.do?num="+num;
	}
}
