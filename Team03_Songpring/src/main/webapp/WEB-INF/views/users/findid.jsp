<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/findid.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<h1>알림</h1>
	<p> 
		${requestScope.dto.name }님의 아이디는 <strong>${requestScope.dto.id }</strong>입니다.
		<a href="${pageContext.request.contextPath }/users/loginform.do">로그인 하러 가기</a>
		<a href="${pageContext.request.contextPath }/users/findpwd_form.do">비밀번호 찾기</a>
	</p>
</div>

<jsp:include page="../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>