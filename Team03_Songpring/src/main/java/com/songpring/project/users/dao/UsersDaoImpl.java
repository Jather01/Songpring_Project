package com.songpring.project.users.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.songpring.project.users.dto.UsersDto;

@Repository
public class UsersDaoImpl implements UsersDao{
	// 핵심 의존 객체 DI
	@Autowired
	private SqlSession session;
	
	@Override
	public int updateGrade(UsersDto dto) {
		int isSuccess=session.update("users.updateGrade",dto);
		return isSuccess;
	}
	@Override
	public List<UsersDto> getList(UsersDto dto) {
		List<UsersDto> list=session.selectList("users.getList", dto);
		return list;
	}
	@Override
	public int getCount(UsersDto dto) {
		int count=session.selectOne("users.getCount", dto);
		return count;
	}
	@Override
	public String getGrade(String id) {
		String grade=session.selectOne("users.getGrade",id);
		return grade;
	}
	public void updateProfile(UsersDto dto) {
		session.update("users.updateProfile", dto);
	}

	@Override
	public boolean isExist(String id) {
		UsersDto dto=session.selectOne("users.isExist", id);
		if(dto==null) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public boolean updatePwd(UsersDto dto) {
		int count=session.update("users.updatePwd", dto);
		if(count==0)
			return false;
		else
			return true;
	}

	@Override
	public void update(UsersDto dto) {
		session.update("users.update", dto);
	}

	@Override
	public void delete(String id) {
		session.delete("users.delete", id);
	}

	@Override
	public UsersDto getData(String id) {
		UsersDto dto=session.selectOne("users.getData", id);
		return dto;
	}

	@Override
	public void insert(UsersDto dto) {
		session.insert("users.insert", dto);
	}

	@Override
	public String getPwd(String id) {
		String pwd=session.selectOne("users.getPwd", id);
		return pwd;
	}

	@Override
	public UsersDto findid(String email) {
		UsersDto dto=session.selectOne("users.findid", email);
		return dto;
	}

	@Override
	public UsersDto findpwd(String id) {
		UsersDto dto=session.selectOne("users.findpwd", id);
		return dto;
	}
}