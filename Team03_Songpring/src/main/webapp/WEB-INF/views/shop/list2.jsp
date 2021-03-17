<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/list2.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	a {
		color: #000; 
	}
	.card-img-top {
		height: 250px;
		object-fit: scale-down;
	}
	.card .card-text {
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display: block;
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
</style>
</head>
<body>
<div class="container">
<ul>
	<li><a href="list1.do?genre=novel">소설</a></li>
	<li><a href="list1.do?genre=culture">교양</a></li>
	<li><a href="list1.do?genre=workbook">문제집</a></li>
	<li><a href="list1.do?genre=comicbook">만화</a></li>
	<li><a href="list1.do?genre=dictionary">사전</a></li>
</ul>
<ul>
	<li><a href="list1.do?order=highPrice">최고가</a></li>
	<li><a href="list1.do?order=lowPrice">최저가</a></li>
	<li><a href="list1.do?order=sellCount">판매수</a></li>
	<li><a href="list1.do?order=date">출판일</a></li>
</ul>
<div class="row" id="galleryList">
	<c:forEach var="tmp" items="${list }">
		<div class="col-6 col-md-4 col-lg-3">
			<div class="card mb-3">
				<div class="img-wrapper">
					<a href="detail.do?num=${tmp.num}">
						<img class="card-img-top" src="${pageContext.request.contextPath }${tmp.imagePath}" />
					</a>
				</div>
				<div class="card-body">
					<h5 class="card-title">[
						<c:choose>
							<c:when test="${tmp.genre eq 'novel'}">소설</c:when>
							<c:when test="${tmp.genre eq 'culture'}">교양</c:when>
							<c:when test="${tmp.genre eq 'workbook'}">문제집</c:when>
							<c:when test="${tmp.genre eq 'comicbook'}">만화</c:when>
							<c:when test="${tmp.genre eq 'dictionary'}">사전</c:when>
						</c:choose>
						]<a href="detail.do?num=${tmp.num}"> ${tmp.title }</a></h5>
					<p class="card-text"><small>저자</small> <a href="list2.do?writer=${writer }">${tmp.writer }</a></p>
					<p class="card-text"><small>출판</small> <a href="list2.do?publisher=${publisher }">${tmp.publisher }</a></p>
					<p class="card-text">${tmp.regdate }</p>
					<p class="card-text">${tmp.price } 원</p>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
</div>
</body>
</html>