<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qna/private/delete.jsp</title>
</head>
<body>
	<script>
		alert("문의가 삭제 되었습니다.");
		location.href="${pageContext.request.contextPath }/qna/list.do";
	</script>
</body>
</html>