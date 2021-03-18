<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="collapse navbar-collapse">
			<div class="navbar-nav" style="width: 100%;">
				<table style="width: 100%;">
					<tr>
						<td style="width: 60%;"></td>
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
	<div class="row" style="margin-top: 20px; margin-bottom: 20px; border: 0px solid white; height: 50px">
		<div class="col-6 col-md-4"></div>
		<div class="col-6 col-md-4 navbar">
			<a href="${pageContext.request.contextPath }/">
				<img style="width: 50px; height: 50px;" src="${pageContext.request.contextPath }/resources/images/yellowbird.png" />
			</a>
			<form class="form-inline" method="get" action="${pageContext.request.contextPath }/shop/list1.do">
				<input class="form-control mr-sm-2" type="text" name="keyword" placeholder="검색할 책 제목 입력..." value="${keyword}" />
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
		<div class="col-6 col-md-4"></div>
	</div>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="navbar-nav" style="width: 100%;">
			<table style="width: 100%;">
				<tr>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=novel">소설</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=culture">교양</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=workbook">문제집</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=comicbook">만화</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=dictionary">사전</a></td>
				</tr>
			</table>
		</div>
	</nav>
</div>
</body>
</html>