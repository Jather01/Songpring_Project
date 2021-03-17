package com.songpring.project.qna.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.songpring.project.qna.dto.QnADto;

@Repository
public class QnADaoImpl implements QnADao{
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(QnADto dto) {
		session.insert("qna.insert",dto);
	}

	@Override
	public void update(QnADto dto) {
		session.update("qna.update",dto);
	}

	@Override
	public void delete(int num) {
		session.delete("qna.delete",num);
	}

	@Override
	public QnADto getData(int num) {
		QnADto dto=session.selectOne("qna.getData",num);
		return dto;
	}

	@Override
	public List<QnADto> getList(QnADto dto) {
		List<QnADto> list=session.selectList("qna.getList", dto);
		return list;
	}

	@Override
	public int getCount(QnADto dto) {
		int count=session.selectOne("qna.getCount", dto);
		return count;
	}

	@Override
	public void commentUpdate(QnADto dto) {
		session.update("qna.commentUpdate", dto);
	}

	@Override
	public void commentDelete(int num) {
		session.update("qna.commentDelete", num);
	}

}
