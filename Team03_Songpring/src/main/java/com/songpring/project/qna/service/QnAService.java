package com.songpring.project.qna.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.songpring.project.qna.dto.QnADto;

public interface QnAService {
	// 문의 삭제
	public void deleteQnA(int num);
	// 문의 등록
	public void saveQnA(QnADto dto);
	// 문의 수정
	public void updateQnA(QnADto dto);
	// 문의 자세히 보기
	public void getDetail(int num, ModelAndView mView);
	// 문의 목록
	public void getList(ModelAndView mView, HttpServletRequest request);
	// 답변 추가&수정
	public void commentUpdate(QnADto dto);
	// 답변 삭제
	public void commentDelete(int num);
}
