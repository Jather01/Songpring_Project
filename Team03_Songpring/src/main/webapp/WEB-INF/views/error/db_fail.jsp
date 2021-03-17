<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/error/db_fail.jsp</title>
</head>
<body>
<h1>Oops!</h1>
<p>${exception.message }</p>
<a href="${pageContext.request.contextPath }/home.do">홈으로 돌아가기</a>
</body>
</html>