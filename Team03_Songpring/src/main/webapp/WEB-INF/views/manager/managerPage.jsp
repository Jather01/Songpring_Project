<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/manager/managerPage.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<ul>
			<li><a href="${pageContext.request.contextPath }/shop/manager/uploadform.do">책 판매 업로드</a></li>
			<li><a href="${pageContext.request.contextPath }/users/manager/users_list.do">유저 관리</a></li>
			<li><a href="${pageContext.request.contextPath }/notice/manager/insertform.do">공지 업로드</a></li>
			<li><a href="${pageContext.request.contextPath }/notice/list.do">공지 목록</a></li>
			<li><a href="${pageContext.request.contextPath }/qna/list.do">QnA 목록</a></li>
			<li><a href="${pageContext.request.contextPath }/qna/private/insertform.do">QnA 등록</a></li>
			<li><a href="#">배송관리</a></li>
		</ul>
	</div>
<jsp:include page="../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>