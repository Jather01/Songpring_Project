<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>비밀번호 찾기 폼 입니다.</h1>
	<form action="${pageContext.request.contextPath }/users/findpwdform2.do" method="post" id="myForm" novalidate>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id" placeholder="가입한 아이디를 입력하세요."/>
		</div>
		<button class="btn btn-outline-primary" type="submit">확인</button>
	</form>
</div>

</body>
</html>