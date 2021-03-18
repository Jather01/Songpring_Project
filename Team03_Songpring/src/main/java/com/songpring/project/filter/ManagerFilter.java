package com.songpring.project.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.songpring.project.users.dao.UsersDao;

@WebFilter(urlPatterns = {"/notice/manager/*", "/qna/manager/*", "/shop/manager/*", "/users/manager/*","/manager/*"})
public class ManagerFilter implements Filter{
	@Autowired
	private UsersDao dao;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//1. 관리자 계정인지 확인한다.
		//부모 type 을 자식 type 으로 casting!
		HttpServletRequest req=(HttpServletRequest)request;
		//자식 type 을 이용해서 HttpSession 객체의 참조값을 얻어낸다.
		HttpSession session=req.getSession();
		//로그인된 아이디가 있는지 읽어와 본다.
		String id=(String)session.getAttribute("id");
		//로그인된 아이디가 관리자의 아이디인지 확인한다.
		String userGrade=(String)session.getAttribute("userGrade");
		if(id == null || !userGrade.equals("manager")){
			// 로그인을 하지 않았거나 관리자 계정이 아니면 로그인 폼으로 이동할 수 있도록 리다일렉트 응답을 준다.
			String cPath=req.getContextPath();
			// ServletResponse type 을 HttpServletResponse type 으로 casting
			HttpServletResponse res=(HttpServletResponse)response;
			res.sendRedirect(cPath+"/error/manager_error.do");
		}else {
			chain.doFilter(request, response);
		}
	}
	@Override
	public void destroy() {
		
	}
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
}
