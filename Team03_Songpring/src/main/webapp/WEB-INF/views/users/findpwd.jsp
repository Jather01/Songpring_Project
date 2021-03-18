<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<p>
		비밀번호를 수정했습니다. 새로운 비밀번호로 다시 로그인 해주십시오.
		<a href="${pageContext.request.contextPath }/users/loginform.do">로그인</a>
	</p>
</div>
</body>
</html>