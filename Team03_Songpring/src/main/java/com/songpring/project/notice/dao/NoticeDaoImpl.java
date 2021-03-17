package com.songpring.project.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.songpring.project.notice.dto.NoticeDto;

@Repository
public class NoticeDaoImpl implements NoticeDao{
	//핵심 의존객체 DI
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(NoticeDto dto) {
		session.insert("notice.insert", dto);
	}

	@Override
	public void update(NoticeDto dto) {
		session.update("notice.update", dto);
	}

	@Override
	public void delete(int num) {
		int count=session.delete("notice.delete", num);
	}

	@Override
	public NoticeDto getData(int num) {
		NoticeDto dto=session.selectOne("notice.getData", num);
		return dto;
	}

	@Override
	public List<NoticeDto> getList(NoticeDto dto) {
		List<NoticeDto> list=session.selectList("notice.getList", dto);
		return list;
	}

	@Override
	public int getCount(NoticeDto dto) {
		int count=session.selectOne("notice.getCount", dto);
		return count;
	}
}
