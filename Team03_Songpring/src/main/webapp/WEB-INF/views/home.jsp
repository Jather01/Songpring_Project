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
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
	<div id="carouselExampleControls" class="carousel slide" data-ride="carousel" style="background: #cecece">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${pageContext.request.contextPath }/resources/images/0.png" class="d-block w-100" height="150" style="object-fit: contain;">
			</div>
			<div class="carousel-item">
				<img src="${pageContext.request.contextPath }/resources/images/1.png" class="d-block w-100" height="150" style="object-fit: contain;">
			</div>
			<div class="carousel-item">
				<img src="${pageContext.request.contextPath }/resources/images/2.png" class="d-block w-100" height="150" style="object-fit: contain;">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
			<img src="${pageContext.request.contextPath }/resources/images/left_arrow.png" width="50" height="50"/>
		</a>
		<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
			<img src="${pageContext.request.contextPath }/resources/images/right_arrow.png" width="50" height="50"/>
		</a>
	</div>
	<div style="height: 20px"></div>
	<div class="row no-gutters">
		<div class="img-div">
			<img class="img-wrapper" src="${pageContext.request.contextPath }/resources/images/01_iron_man_2.jpg">
		</div>
		<div class="col-md-4 padding-10">
			<div class="card-body">
				<h3><a href="#" style="color: #000">오늘의 책</a></h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Id sint cumque commodi odio deserunt voluptate aperiam dicta autem ad reprehenderit aspernatur pariatur delectus quam mollitia repellat amet neque repellendus tempora.</p>
				<h5 class="card-title">[샘플] 아무거나</h5>
				<p class="card-text"><small>저자</small> 김저자 | <small>출판</small> 에이콘아카데미</p>
				<p class="card-text"> 0 원</p>
			</div>
		</div>
	</div>
</div>
<jsp:include page="include/bottomnavbar.jsp"></jsp:include>
</body>
</html>