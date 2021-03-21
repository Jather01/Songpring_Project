<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/home.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
	.img-wrapper {
		width: 300px;
		height: 400px;
		object-fit: scale-down;
	}
	.img-div {
		padding-left: 10px;
		padding-right: 10px;
	}
	.txt_post {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 8; /* 라인수 */
		-webkit-box-orient: vertical;
		word-wrap: break-word;
		line-height: 1.5em;
		height: 12em;
	}
	a {
		color: #000;
	}
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
	<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<c:forEach var="i" begin="0" end="2">
				<c:choose>
					<c:when test="${i eq 0 }">
						<a href="${pageContext.request.contextPath }/shop/detail.do?num=${list[i].num}">
							<div class="carousel-item active">
								<img src="${pageContext.request.contextPath }${list[i].imagePath}" class="d-block w-100" height="300" style="object-fit: contain;">
							</div>
						</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath }/shop/detail.do?num=${list[i].num}">
							<div class="carousel-item">
								<img src="${pageContext.request.contextPath }${list[i].imagePath}" class="d-block w-100" height="300" style="object-fit: contain;">
							</div>
						</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
			<img src="${pageContext.request.contextPath }/resources/images/left_arrow.png" width="50" height="50"/>
		</a>
		<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
			<img src="${pageContext.request.contextPath }/resources/images/right_arrow.png" width="50" height="50"/>
		</a>
	</div>
	<div style="height: 20px;"></div>
	<div class="row no-gutters">
		<a href="${pageContext.request.contextPath }/shop/detail.do?num=${list[3].num}">
			<div class="img-div">
				<img class="img-wrapper" src="${pageContext.request.contextPath }${list[3].imagePath}">
			</div>
		</a>
		<div class="col-6 col-md-4 col-lg-4">
			<div class="card-body">
				<h3><a href="${pageContext.request.contextPath }/shop/detail.do?num=${list[3].num}" >오늘의 책</a></h3>
				<h5 class="card-title">[
						<c:choose>
							<c:when test="${list[3].genre eq 'novel'}">소설</c:when>
							<c:when test="${list[3].genre eq 'culture'}">교양</c:when>
							<c:when test="${list[3].genre eq 'workbook'}">문제집</c:when>
							<c:when test="${list[3].genre eq 'comicbook'}">만화</c:when>
							<c:when test="${list[3].genre eq 'dictionary'}">사전</c:when>
						</c:choose>
						] <a href="${pageContext.request.contextPath }/shop/detail.do?num=${list[3].num}">${list[3].title }</a></h5>
				<p class="card-text"><small>저자</small> ${list[3].writer } | <small>출판</small> ${list[3].publisher } | ${list[3].regdate }</p>
				<p class="card-text">${list[3].price } 원</p>
			</div>
		</div>
		<div class="col-6 col-md-4 col-lg-4">
			<div class="card" style="width: 100%;">
				<ul class="list-group list-group-flush">
					<li class="list-group-item"><a href="${pageContext.request.contextPath }/shop/list1.do" >전체 상품</a></li>
					<li class="list-group-item"><a href="${pageContext.request.contextPath }/notice/list.do" >공지사항</a></li>
					<li class="list-group-item"><a href="${pageContext.request.contextPath }/qna/list.do" >Q&A</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<jsp:include page="include/bottomnavbar.jsp"></jsp:include>
</body>
</html>