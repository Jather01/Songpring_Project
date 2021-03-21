package com.songpring.project.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.songpring.project.shop.dto.ShopReviewDto;

@Repository
public class ShopReviewDaoImpl implements ShopReviewDao{
	@Autowired
	private SqlSession session;
	
	@Override
	public List<ShopReviewDto> getList(ShopReviewDto dto) {
		List<ShopReviewDto> list=session.selectList("review.getList", dto);
		return list;
	}

	@Override
	public void insert(ShopReviewDto dto) {
		session.insert("review.insert", dto);
	}

	@Override
	public void update(ShopReviewDto dto) {
		session.update("review.update", dto);
	}

	@Override
	public void delete(int num) {
		session.delete("review.delete", num);
	}

	@Override
	public void deleteAllReviews(int bookNum) {
		session.delete("review.deleteAllReviews",bookNum);
	}
	
	@Override
	public ShopReviewDto getData(int num) {
		ShopReviewDto dto=session.selectOne("review.getData",num);
		return dto;
	}

	@Override
	public int getCount(int bookNum) {
		return session.selectOne("review.getCount",bookNum);
	}

	@Override
	public int checkReviewCount(ShopReviewDto dto) {
		int count=session.selectOne("review.checkReviewCount", dto);
		return count;
	}

}
