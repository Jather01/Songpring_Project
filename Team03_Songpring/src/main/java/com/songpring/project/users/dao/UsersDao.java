package com.songpring.project.users.dao;

import java.util.List;

import com.songpring.project.users.dto.UsersDto;

public interface UsersDao {
	// 권한 부여
	public int updateGrade(UsersDto dto);
	// 유저 목록
	public List<UsersDto> getList(UsersDto dto);
	// 회원 수
	public int getCount(UsersDto dto);
	// 권한 확인
	public String getGrade(String id);
	//프로필 이미지 경로 수정
	public void updateProfile(UsersDto dto);
	//아이디 존재여부 리턴 
	public boolean isExist(String id);
	//비밀번호 수정하고 성공여부 리턴
	public boolean updatePwd(UsersDto dto);
	//회원가입 정보 수정 반영
	public void update(UsersDto dto);
	//회원가입 정보 삭제
	public void delete(String id);
	//가입정보 리턴
	public UsersDto getData(String id);
	//회원정보를 저장
	public void insert(UsersDto dto);
	//인자로 전달된 아이디에 해당하는 비밀번호를 리턴하는 메소드
	public String getPwd(String id);
	//아이디 찾기
	public UsersDto findid(UsersDto dto);
	//비밀번호 수정하고 성공여부 리턴
	public int findpwd(UsersDto dto);
}
