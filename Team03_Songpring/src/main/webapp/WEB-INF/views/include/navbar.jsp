<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="collapse navbar-collapse">
			<div class="navbar-nav" style="width: 100%;">
				<table style="width: 100%;">
					<tr>
						<td style="width: 37%;"></td>
						<td align = "center" style="width: 20%;">
							<a href="${pageContext.request.contextPath }/home.do">
								<img style="width: 244px; height: 65px;" src="${pageContext.request.contextPath }/resources/images/logo.png" />
							</a>
						</td>
						<td style="width: 3%;"></td>
						<td align = "center"><small>
							<c:choose>
								<c:when test="${empty sessionScope.id }"><a class="nav-link" href="${pageContext.request.contextPath }/users/loginform.do">로그인</a></c:when>
								<c:otherwise><a class="nav-link" href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a></c:otherwise>
							</c:choose>
						</small></td>
						<td align = "center"><small>
							<c:choose>
								<c:when test="${sessionScope.userGrade eq 'manager' }"><a class="nav-link" href="${pageContext.request.contextPath }/manager/managerPage.do">관리자페이지</a></c:when>
							<c:otherwise><a class="nav-link" href="${pageContext.request.contextPath }/users/signup_form.do">회원가입</a></c:otherwise>
							</c:choose>
						</small></td>
						<td align = "center"><small><a class="nav-link" href="${pageContext.request.contextPath }/users/private/info.do">마이페이지</a></small></td>
						<td align = "center"><small><a class="nav-link" href="${pageContext.request.contextPath }/shop/private/cartList.do">카트</a></small></td>
						<td align = "center"><small><a class="nav-link" href="${pageContext.request.contextPath }/shop/private/orderList.do">주문/배송</a></small></a></td>
						<td align = "center"><small><a class="nav-link" href="${pageContext.request.contextPath }/qna/list.do">Q&A</a></small></td>
					</tr>
				</table>
			</div>
		</div>
	</nav>
	<div style="height: 50px"></div>
</div>