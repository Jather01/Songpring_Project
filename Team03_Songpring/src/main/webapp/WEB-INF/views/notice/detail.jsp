<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/notice/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<table class="table">
			<tr>
				<td>${dto.title}</td>
				<td>${dto.regdate}</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>${dto.content}</div>
				</td>
			</tr>
		</table>
	</div>
<jsp:include page="../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>