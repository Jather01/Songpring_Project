<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/private/orderList.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	section#content ul{padding-left:0px; list-style:none;}
	section#content ul li { border:5px solid #eee; padding:10px 20px; margin-bottom:20px; }
	section#content .orderList span { font-size:20px; font-weight:bold; display:inline-block; width:90px; margin-right:10px; }
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
<c:choose>
	<c:when test="${empty orderList }">
		<div class="alert alert-warning">
			<strong>주문내역이 없습니다.</strong>
		</div>
	</c:when>
	<c:otherwise>
		<section id="content">
			<ul class="orderList">
				<c:forEach var="tmp" items="${orderList }">
					<li>
						<div>
							<p><span>주문번호</span><a href="${pageContext.request.contextPath }/shop/private/orderView.do?orderId=${tmp.orderId}">${tmp.orderId}</a></p>
							<p><span>수령인</span>${tmp.orderRec}</p>
							<p><span>주소</span>(${tmp.addrNum}) ${tmp.userAddr1} ${tmp.userAddr2} ${tmp.userAddr3}</p>
							<p><span>가격</span>${tmp.amount} 원</p>
						</div>
					</li>
				</c:forEach>
			</ul>
		</section>
	</c:otherwise>
</c:choose>
</div>
<jsp:include page="../../include/bottomnavbar.jsp"></jsp:include>
</body>
</html>