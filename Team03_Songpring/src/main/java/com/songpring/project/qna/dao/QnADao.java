package com.songpring.project.qna.dao;

import java.util.List;

import com.songpring.project.qna.dto.QnADto;

public interface QnADao {
	//문의 추가
	public void insert(QnADto dto);
	//문의 수정
	public void update(QnADto dto);
	//문의 삭제
	public void delete(int num);
	//문의 하나의 정보 얻어오기
	public QnADto getData(int num);
	//문의 목록 얻어오기 (페이징 처리와 검색 키워드를 고려한 목록)
	public List<QnADto> getList(QnADto dto);
	//문의의 갯수 얻어오기(검색 키워드에 해당하는 갯수)
	public int getCount(QnADto dto);
	//답변 추가&수정
	public void commentUpdate(QnADto dto);
	//답변 삭제
	public void commentDelete(int num);
}
