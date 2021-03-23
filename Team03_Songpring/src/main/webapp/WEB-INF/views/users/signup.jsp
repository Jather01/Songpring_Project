<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup.jsp</title>
</head>
<body>
<div class="container">
	<h1>알림</h1>
	<script>
		alert("${requestScope.dto.id } 님 회원 가입 되었습니다. ");
		location.href="${pageContext.request.contextPath }/users/loginform.do";
	</script>
</div>
</body>
</html>




