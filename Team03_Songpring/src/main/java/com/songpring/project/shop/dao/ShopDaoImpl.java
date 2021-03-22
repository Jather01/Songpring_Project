package com.songpring.project.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.songpring.project.cart.dto.CartDto;
import com.songpring.project.cart.dto.CartListDto;
import com.songpring.project.order.dto.OrderDto;
import com.songpring.project.order.dto.OrderListDto;
import com.songpring.project.shop.dto.ShopDto;

@Repository
public class ShopDaoImpl implements ShopDao{
	//핵심 의존객체 DI
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(ShopDto dto) {
		session.insert("shop.insert", dto);
	}

	@Override
	public void update(ShopDto dto) {
		session.update("shop.update", dto);
	}

	@Override
	public void delete(int num) {
		session.delete("shop.delete", num);
	}

	@Override
	public ShopDto getData(int num) {
		ShopDto dto=session.selectOne("shop.getData", num);
		return dto;
	}

	@Override
	public List<ShopDto> getDataRandom() {
		List<ShopDto> list=session.selectList("shop.getDataRandom");
		return list;
	}

	@Override
	public List<ShopDto> getList(ShopDto dto) {
		List<ShopDto> list=session.selectList("shop.getList", dto);
		return list;
	}

	@Override
	public int getCount(ShopDto dto) {
		int count=session.selectOne("shop.getCount", dto);
		return count;
	}

	@Override
	public void addSellCount(int num) {
		session.update("shop.addSellCount", num);
	}

	@Override
	public void addCart(CartDto cart) {
		session.insert("shop.addCart", cart);
	}

	@Override
	public List<CartListDto> cartList(String userId) {
		return session.selectList("shop.cartList", userId);
	}

	@Override
	public void deleteCart(CartDto cart) {
		session.delete("shop.deleteCart",cart);
	}

	@Override
	public List<OrderDto> orderList(String userId) {
		List<OrderDto> list=session.selectList("shop.orderList", userId);
		return list;
	}

	@Override
	public void orderInfo(OrderDto order) {
		session.insert("shop.orderInfo", order);
	}

	@Override
	public void orderInfo_Details(OrderDto order) {
		session.insert("shop.orderInfo_Details", order);
	}

	@Override
	public List<OrderListDto> orderView(OrderDto order) {
		List<OrderListDto> list=session.selectList("shop.orderView", order);
		return list;
	}
	
	// 카트 비우기
	@Override
	public void cartAllDelete(String userId){
		session.delete("shop.cartAllDelete", userId);
	}

}