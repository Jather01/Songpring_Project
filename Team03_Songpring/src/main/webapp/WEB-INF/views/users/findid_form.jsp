
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
<div class="container">
	<h1>아이디 찾기 폼 입니다.</h1>
	<form action="${pageContext.request.contextPath }/users/findid.do" method="post" id="myForm" novalidate>
		<div class="form-group">
			<label for="id">이름</label>
			<input class="form-control" type="text" name="name" id="name" placeholder="가입한 이름을 입력하세요."/>
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="email" name="email" id="email" placeholder="E-mail@gmail.com"/>
		</div>
		<button class="btn btn-outline-primary" type="submit">확인</button>
	</form>
</div>

</body>
</html>