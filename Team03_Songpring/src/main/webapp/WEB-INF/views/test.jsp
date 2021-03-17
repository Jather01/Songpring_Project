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
							<td align = "center"><small><a class="nav-link" href="">로그인</a></small></td>
							<td align = "center"><small><a class="nav-link" href="">회원가입</a></small></td>
							<td align = "center"><small><a class="nav-link" href="">마이페이지</a></small></td>
							<td align = "center"><small><a class="nav-link" href="">카트</a></small></td>
							<td align = "center"><small><a class="nav-link" href="">주문/배송</a></small></a></td>
							<td align = "center"><small><a class="nav-link" href="">고객센터</a></small></td>
						</tr>
					</table>
				</div>
			</div>
		</nav>
		<div class="row" style="margin-top: 20px; margin-bottom: 20px;">
			<div class="col-6 col-md-4"></div>
			<div class="col-6 col-md-4 navbar">
				<a href="${pageContext.request.contextPath }/">
					<img style="width: 50px; heigth: 50px;" src="${pageContext.request.contextPath }/resources/images/yellowbird.png" />
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
						<td align = "center"><a class="nav-link" href="">소설</a></td>
						<td align = "center"><a class="nav-link" href="">교양</a></td>
						<td align = "center"><a class="nav-link" href="">문제집</a></td>
						<td align = "center"><a class="nav-link" href="">만화</a></td>
						<td align = "center"><a class="nav-link" href="">사전</a></td>
					</tr>
				</table>
			</div>
		</nav>
	</div>
</body>
</html>