<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/private/orderInfo.do</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	ul.orderView {
		padding-left:0px;
		list-style:none;
	}
	.orderInfo {
		border: 5px solid #eee;
		padding: 10px 20px;
		margin: 20px 0;
	}
	
	.orderInfo span {
		font-size: 20px;
		font-weight: bold;
		display: inline-block;
		width: 90px;
	}
	
	.orderView li {
		margin-bottom: 20px;
		padding-bottom: 20px;
		border-bottom: 1px solid #999;
	}
	
	.orderView li::after {
		content: "";
		display: block;
		clear: both;
	}
	
	.thumb {
		float: left;
		width: 200px;
	}
	
	.thumb img {
		width: 200px;
		height: 200px;
	}
	
	.gdsInfo {
		float: right;
		width: calc(100% - 220px);
		line-height: 2;
	}
	
	.gdsInfo span {
		font-size: 20px;
		font-weight: bold;
		display: inline-block;
		width: 100px;
		margin-right: 10px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
<section id="content">
	<div class="orderInfo">
		<c:forEach items="${orderView}" var="orderView" varStatus="status">
			<c:if test="${status.first}">
				<p><span>수령인</span>${orderView.orderRec}</p>
				<p><span>주소</span>(${orderView.addrNum }) ${orderView.userAddr1} ${orderView.userAddr2} ${orderView.userAddr3}	</p>
				<p><span>가격</span>${orderView.amount} 원</p>
			</c:if>
		</c:forEach>
	</div>
	<ul class="orderView">
		<c:forEach items="${orderView}" var="orderView">
			<li>
				<div class="thumb">
					<img src="${pageContext.request.contextPath }${orderView.imagePath}" />
				</div>
				<div class="gdsInfo">
					<p>
						<span>상품명</span>${orderView.title}<br />
						<span>개당 가격</span>${orderView.price} 원<br />
						<span>구입 수량</span>${orderView.cartStock} 개<br />
						<span>총 금액</span>${orderView.price * orderView.cartStock} 원
					</p>
				</div>
			</li>
		</c:forEach>
	</ul>
</section>
</div>
<jsp:include page="../../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>