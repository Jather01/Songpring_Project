<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/manager/users_list.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<div class="pagination justify-content-center">
		<form action="users_list.do" method="post">
			<select name="condition" id="condition">
				<option value="name" ${condition eq 'name'? 'selected':'' }>이름</option>
				<option value="id" ${condition eq 'id'? 'selected':'' }>아이디</option>
			</select>
			<input type="text" name="keyword" value="${keyword}"/>
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</div>
	<ul>
		<li><a href="users_list.do?order=name&condition=${condition }&keyword=${encodedK}">이름순 정렬</a></li>
		<li><a href="users_list.do?order=id&condition=${condition }&keyword=${encodedK}">ID순 정렬</a></li>
		<li><a href="users_list.do?order=regdate&condition=${condition }&keyword=${encodedK}">가입일순 정렬</a></li>
		<li><a href="users_list.do?order=grade&condition=${condition }&keyword=${encodedK}">권한순 정렬</a></li>
	</ul>
	<table class="table table-striped">
		<thead class="thead-dark">
			<tr>
				<th>이름</th>
				<th>아이디</th>
				<th>이메일</th>
				<th>주소</th>
				<th>등록일</th>
				<th>권한</th>
				<th>권한 부여</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="tmp" items="${list }">
			<tr>
				<td>${tmp.name }</td>
				<td>${tmp.id }</td>
				<td>${tmp.email}</td>
				<td>${tmp.userAddr1} ${tmp.userAddr2} ${tmp.userAddr3}</td>
				<td>${tmp.regdate }</td>
				<td>
					<c:choose>
						<c:when test="${empty tmp.grade || tmp.grade eq 'user' }">일반유저</c:when>
						<c:when test="${tmp.grade eq 'manager' }">관리자</c:when>
					</c:choose>
				</td>
				<td>
					<select name="grade" id="grade_${tmp.id }" onchange="chageGradeSelect('${tmp.id }')">
						<option value="user" ${tmp.grade eq 'user'? 'selected':'' }>일반유저</option>
						<option value="manager" ${tmp.grade eq 'manager'? 'selected':'' }>관리자</option>
					</select>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link" href="users_list.do?pageNum=${startPageNum-1}&condition=${condition }&keyword=${encodedK}&order=${order}">&laquo;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">&laquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				<li class="page-item ${i eq pageNum? 'active' : '' }">
					<a class="page-link" href="users_list.do?pageNum=${i}&condition=${condition }&keyword=${encodedK}&order=${order}">${i}</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum ne totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="users_list.do?pageNum=${endPageNum+1}&condition=${condition }&keyword=${encodedK}&order=${order}">&raquo;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">&raquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
</div>
<jsp:include page="../../include/bottomnavbar.jsp"></jsp:include>
<script>
	function chageGradeSelect(id){
		var langSelect = document.getElementById("grade_"+id);
		var grade = langSelect.options[langSelect.selectedIndex].value;
		location.href="${pageContext.request.contextPath }/users/manager/users_manage.do?pageNum=${pageNum}&grade="+grade+"&id="+id+"&condition=${condition }&keyword=${encodedK}&order=${order}";
	}
</script>
</body>
</html>