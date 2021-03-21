<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/notice/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<table class="table table-striped">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tmp" items="${list }">
					<tr>
						<td>${tmp.num }</td>
						<td><a href="detail.do?num=${tmp.num}">${tmp.title}</a></td>
						<td>${tmp.regdate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav>
			<ul class="pagination justify-content-center">
				<c:choose>
					<c:when test="${startPageNum ne 1 }">
						<li class="page-item">
							<a class="page-link" href="list.do?pageNum=${startPageNum-1}&condition=${condition}&keyword=${encodedK}">&laquo;</a>
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
						<a class="page-link" href="list.do?pageNum=${i}&condition=${condition}&keyword=${encodedK}">${i}</a>
					</li>
				</c:forEach>
				<c:choose>
					<c:when test="${endPageNum ne totalPageCount }">
						<li class="page-item">
							<a class="page-link" href="list.do?pageNum=${endPageNum+1}&condition=${condition}&keyword=${encodedK}">&raquo;</a>
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
		<div class="pagination justify-content-center">
			<form action="list.do" method="get">
				<select name="condition" id="condition">
					<option value="title" ${condition eq 'title'? 'selected':'' }>제목</option>
					<option value="content" ${condition eq 'content'? 'selected':'' }>내용</option>
				</select>
				<input type="text" name="keyword" value="${keyword}"/>
				<button class="btn btn-success" type="submit">검색</button>
			</form>
		</div>
		<!-- 만약 검색 키워드가 존재한다면 몇개의 글이 검색되었는지 알려준다. -->
		<c:if test="${empty not keyword }">
			<div class="alert alert-success"><strong>${totalRow}</strong>개의 자료가 검색 되었습니다.</div>
		</c:if>
	</div>
<jsp:include page="../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>