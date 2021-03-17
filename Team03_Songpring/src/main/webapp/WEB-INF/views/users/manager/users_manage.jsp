<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/manager/users_manage.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<c:choose>
	<c:when test="${isSuccess >0 }">
		<script>
			alert("권한 부여에 성공하였습니다.");
			location.href="${pageContext.request.contextPath }/users/manager/users_list.do?pageNum=${pageNum}&condition=${condition }&keyword=${encodedK}&order=${order}";
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("권한 부여에 실패했습니다.");
			location.href="${pageContext.request.contextPath }/users/manager/users_list.do?pageNum=${pageNum}&condition=${condition }&keyword=${encodedK}&order=${order}";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>