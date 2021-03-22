<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/private/cartList.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
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
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<div style="float:left; width: 50%; margin-bottom: 10px;">
		<input type="checkbox" name="allCheck" id="allCheck" style="margin-right: 5px "/><label for="allCheck">모두 선택</label>
	</div>
	<div style="float:left; width: 50%; text-align: right; margin-bottom: 10px;">
		<button type="button" class="btn btn-danger" id="selectDelete_btn">선택 삭제</button>
	</div>
	<c:forEach var="tmp" items="${cartList }">
		<div class="row no-gutters gutters">
			<input type="checkbox" name="chBox" class="chBox" data-cartNum="${tmp.cartNum}" style="margin-top: 10px; margin-left: 5px;"/>
			<a href="${pageContext.request.contextPath }/shop/detail.do?num=${tmp.num}">
				<div class="img-div">
					<img class="img-wrapper" src="${pageContext.request.contextPath }${tmp.gdsThumbImg}">
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
						] <a href="${pageContext.request.contextPath }/shop/detail.do?num=${tmp.num}">${tmp.gdsName }</a></h5>
					<p class="card-text">권 당 ${tmp.gdsPrice } 원</p> 
					<p class="card-text">수량 ${tmp.cartStock }</p>
					<p class="card-text">총 ${tmp.gdsPrice * tmp.cartStock } 원</p>
					<button type="button" class="btn btn-danger" id="delete_btn${tmp.cartNum}" data-cartNum="${tmp.cartNum}">카트에서 삭제</button>
					<script>
						// 개별 삭제 기능
						$(document).on("click","#delete_btn${tmp.cartNum}", function(){
							var confirm_val = confirm("정말 삭제하시겠습니까?");
						
							if(confirm_val) {
								var checkArr = new Array();
								checkArr.push($(this).attr("data-cartNum"));
						
								$.ajax({
									url : "${pageContext.request.contextPath }/shop/private/deleteCart.do",
									type : "post",
									data : { chbox : checkArr },
									success : function(result){
										if(result == 1) {     
											location.href = "${pageContext.request.contextPath }/shop/private/cartList.do";
										} else {
											alert("삭제 실패");
										}
									}
								});
							}
						});
					</script>
				</div>
			</div>
		</div>
		<div style="height: 5px"></div>
	</c:forEach>
</div>
<jsp:include page="../../include/bottomnavbar.jsp"></jsp:include>
<script>
	// 전체 선택
	$(document).on("click","#allCheck", function(){
		var chk = $("#allCheck").prop("checked");
		if (chk) {
			$(".chBox").prop("checked", true);
		} else {
			$(".chBox").prop("checked", false);
		}
	});
	// 개별 선택을 누르면 전체 선택 체크가 해제 된다.
	$(document).on("click",".chBox", function(){
		$("#allCheck").prop("checked", false);
	});
	// 체크된 상품 삭제 기능
	$(document).on("click","#selectDelete_btn", function(){
		var checked=$("input[class='chBox']:checked").length;
		if(checked==0) return false;
		var confirm_val = confirm("정말 삭제하시겠습니까?");

		if (confirm_val) {
			var checkArr = new Array();

			$("input[class='chBox']:checked").each(function() {
				checkArr.push($(this).attr("data-cartNum"));
			});

			$.ajax({
				url : "${pageContext.request.contextPath }/shop/private/deleteCart.do",
				type : "post",
				data : {chbox : checkArr},
				success : function(result) {
					if (result == 1) {
						location.href = "${pageContext.request.contextPath }/shop/private/cartList.do";
					} else {
						alert("삭제 실패");
					}
				}
			});
		}
	});
</script>
</body>
</html>