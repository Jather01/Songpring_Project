<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/list1.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.img-wrapper {
		width: 150px;
		height: 200px;
	}
	.img-div {
		padding: 10px 10px;
		object-fit: scale-down;
	}
	.gutters {
		height: 220px;
		border: 1px solid gray;
		border-radius: 5px;
	}
	.padding-10 {
		padding-left: 10px;
		padding-right: 10px;
	}
	a {
		color: #000;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<div class="pagination justify-content-center">
		<form action="list1.do" method="get">
			<select name="condition" id="condition">
				<option value="all" ${condition eq 'all'? 'selected':'' }>통합검색</option>
				<option value="novel" ${condition eq 'novel'? 'selected':'' }>소설</option>
				<option value="culture" ${condition eq 'culture'? 'selected':'' }>교양</option>
				<option value="workbook" ${condition eq 'workbook'? 'selected':'' }>문제집</option>
				<option value="comicbook" ${condition eq 'comicbook'? 'selected':'' }>만화</option>
				<option value="dictionary" ${condition eq 'dictionary'? 'selected':'' }>사전</option>
			</select>
			<input type="text" name="keyword" value="${keyword }" />
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</div>
	<div style="height: 10px"></div>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="border-radius: 5px;">
		<div class="navbar-nav" style="width: 100%;">
			<table style="width: 100%;">
				<tr>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do">전체</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=novel">소설</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=culture">교양</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=workbook">문제집</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=comicbook">만화</a></td>
					<td align = "center"><a class="nav-link" href="${pageContext.request.contextPath }/shop/list1.do?genre=dictionary">사전</a></td>
					<td align = "center" style="width: 10%">
						<div class="btn-group">
							<button type="button" class="btn btn-primary dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<c:choose>
									<c:when test="${order eq 'highPrice' }">최고가</c:when>
									<c:when test="${order eq 'lowPrice' }">최저가</c:when>
									<c:when test="${order eq 'sellCount' }">판매수</c:when>
									<c:when test="${order eq 'date' }">출판일</c:when>
									<c:otherwise>정렬</c:otherwise>
								</c:choose>
							</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="list1.do?order=highPrice&keyword=${encodedK}&genre=${genre}&condition=${condition}">최고가</a>
								<a class="dropdown-item" href="list1.do?order=lowPrice&keyword=${encodedK}&genre=${genre}&condition=${condition}">최저가</a>
								<a class="dropdown-item" href="list1.do?order=sellCount&keyword=${encodedK}&genre=${genre}&condition=${condition}">판매수</a>
								<a class="dropdown-item" href="list1.do?order=date&keyword=${encodedK}&genre=${genre}&condition=${condition}">출판일</a>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</nav>
	<c:if test="${not empty keyword }">
		<c:choose>
			<c:when test="${totalRow eq 0 }">
				<div class="alert alert-success">
					검색된 자료가 없습니다.
				</div>
			</c:when>
			<c:otherwise>
				<div class="alert alert-success">
					<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
				</div>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:forEach var="tmp" items="${list }">
		<div class="row no-gutters gutters">
			<a href="detail.do?num=${tmp.num}">
				<div class="img-div">
					<img class="img-wrapper" src="${pageContext.request.contextPath }${tmp.imagePath}">
				</div>
			</a>
			<div class="col-md-8 padding-10">
				<div class="card-body">
					<h5 class="card-title">[
						<c:choose>
							<c:when test="${tmp.genre eq 'novel'}">소설</c:when>
							<c:when test="${tmp.genre eq 'culture'}">교양</c:when>
							<c:when test="${tmp.genre eq 'workbook'}">문제집</c:when>
							<c:when test="${tmp.genre eq 'comicbook'}">만화</c:when>
							<c:when test="${tmp.genre eq 'dictionary'}">사전</c:when>
						</c:choose>
						] <a href="detail.do?num=${tmp.num}">${tmp.title }</a></h5>
					<p class="card-text"><small>저자</small> ${tmp.writer } | <small>출판</small> ${tmp.publisher } | ${tmp.regdate }</p>
					<p class="card-text">${tmp.price } 원</p>
				</div>
			</div>
		</div>
		<div style="height: 5px"></div>
	</c:forEach>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link" href="list1.do?pageNum=${startPageNum-1}&keyword=${encodedK}&genre=${genre}&writer=${writer}&publisher=${publisher}&order=${order}">&laquo;</a>
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
					<a class="page-link" href="list1.do?pageNum=${i}&keyword=${encodedK}&genre=${genre}&writer=${writer}&publisher=${publisher}&order=${order}">${i}</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum ne totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="list1.do?pageNum=${endPageNum+1}&keyword=${encodedK}&genre=${genre}&writer=${writer}&publisher=${publisher}&order=${order}">&raquo;</a>
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
<jsp:include page="../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>