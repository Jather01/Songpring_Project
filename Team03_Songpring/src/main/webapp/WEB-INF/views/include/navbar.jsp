<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
	<ul class="nav justify-content-end" style="background: black;">
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.request.contextPath }/home.do">
				<img style="width: 244px; height: 65px;" src="${pageContext.request.contextPath }/resources/images/logo.png" />
			</a>
		</li>
		<li class="nav-item">
			<c:choose>
				<c:when test="${empty sessionScope.id }"><a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/users/loginform.do">로그인</a></c:when>
				<c:otherwise><a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a></c:otherwise>
			</c:choose>
		</li>
		<li class="nav-item">
			<c:choose>
				<c:when test="${sessionScope.userGrade eq 'manager' }"><a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/manager/managerPage.do">관리자페이지</a></c:when>
				<c:when test="${sessionScope.userGrade eq 'user' }"><a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/users/private/info.do">마이페이지</a></c:when>
				<c:otherwise><a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/users/signup_form.do">회원가입</a></c:otherwise>
			</c:choose>
		</li>
		<li class="nav-item">
		<a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/shop/private/cartList.do">카트</a>
		</li>
		<li class="nav-item">
		<a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/shop/private/orderList.do">주문/배송</a>
		</li>
		<li class="nav-item">
		<a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/qna/list.do">Q&A</a>
		</li>
		<c:if test="${empty sessionScope.id }">
			<li class="nav-item">
			<a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/users/findid_form.do">ID찾기</a>
			</li>
			<li class="nav-item">
			<a class="nav-link" style="color: #cecece; height: 65px; line-height: 65px;" href="${pageContext.request.contextPath }/users/findpwdform.do">PWD찾기</a>
			</li>
		</c:if>
	</ul>
	<div style="height: 20px"></div>
</div>