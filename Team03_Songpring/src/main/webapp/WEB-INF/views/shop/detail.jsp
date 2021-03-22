<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.img-wrapper {
		width: 450px;
		height: 600px;
		object-fit: scale-down;
	}
	.img-div {
		padding-left: 10px;
		padding-right: 10px;
	}
	/* 리뷰 글 스타일 */
	.reviews ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.reviews dt{
		margin-top: 5px;
	}
	.reviews dd{
		margin-left: 50px;
	}
	.review-form textarea, .review-form button{
		float: left;
	}
	.reviews li{
		clear: left;
	}
	.reviews ul li{
		border-top: 1px solid #888;
	}
	.review-form textarea{
		width: 85%;
		height: 100px;
	}
	.review-form button{
		width: 15%;
		height: 100px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
	.update-form {
		display: none;
	}
	/* .reply_icon 을 li 요소를 기준으로 배치 하기 */
	.reviews li{
		position: relative;
	}
	pre {
	  display: block;
	  padding: 9.5px;
	  margin: 0 0 10px;
	  font-size: 13px;
	  line-height: 1.42857143;
	  color: #333333;
	  word-break: break-all;
	  word-wrap: break-word;
	  background-color: #f5f5f5;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<div class="row no-gutters">
		<div class="img-div">
			<img class="img-wrapper" src="${pageContext.request.contextPath }${shopDto.imagePath}">
		</div>
		<div class="col-md-4 padding-10">
			<div class="card-body">
				<h3 class="card-title">[
					<c:choose>
						<c:when test="${shopDto.genre eq 'novel'}">소설</c:when>
						<c:when test="${shopDto.genre eq 'culture'}">교양</c:when>
						<c:when test="${shopDto.genre eq 'workbook'}">문제집</c:when>
						<c:when test="${shopDto.genre eq 'comicbook'}">만화</c:when>
						<c:when test="${shopDto.genre eq 'dictionary'}">사전</c:when>
					</c:choose>
					] ${shopDto.title }</h3>
				<p class="card-text"><small>저자</small> ${shopDto.writer } | <small>출판</small> ${shopDto.publisher }</p>
				<p class="card-text"><small>판매 수</small> ${shopDto.sellCount }</p>
				<p class="card-text">${shopDto.price } 원</p>
				<table class="table table-striped">
					<tbody>
						<tr>
							<th>출간일</th>
							<td>${shopDto.regdate }</td>
						</tr>
						<tr>
							<th>쪽수</th>
							<td>${shopDto.page }쪽</td>
						</tr>
						<tr>
							<th>크기</th>
							<td>${shopDto.bookSize }mm</td>
						</tr>
					</tbody>
				</table>
				<span>구매수량</span>
				<input type="hidden" name="gdsNum" id="gdsNum" value="${shopDto.num }" />
				<input type="number" name="cartStock" id="cartStock" min="1" max="100" value="1"/>
				<button type="submit" class="btn btn-primary" id="addCartBtn">카트에 담기</button>
			</div>
		</div>
	</div>
	<div>
		<h4>책 설명</h4>
		<p>${shopDto.content }</p>
	</div>
	<c:if test="${sessionScope.userGrade eq 'manager'}">
		<a class="btn btn-secondary" href="manager/updateform.do?num=${shopDto.num }">책 정보 수정</a>
		<a class="btn btn-secondary" href="manager/delete.do?num=${shopDto.num }">책 정보 삭제</a>
	</c:if>
	<div style="height: 20px"></div>
	<!-- 원글에 리뷰를 작성하는 form -->
	<form class="review-form insert-form" action="private/review_insert.do" method="post">
		<!-- 원글의 글번호가 bookNum 번호가 된다. -->
		<input type="hidden" name="bookNum" value="${shopDto.num }"/>
		<c:choose>
			<c:when test="${empty id }">
				<textarea name="content" disabled>로그인이 필요합니다.</textarea>
			</c:when>
			<c:when test="${checkReviewCount ge 1 }">
				<textarea name="content" disabled>이미 리뷰를 작성하셨습니다.</textarea>
			</c:when>
			<c:otherwise>
				<textarea name="content"></textarea>
			</c:otherwise>
		</c:choose>
		<button type="submit">등록</button>
	</form>
	<!-- 리뷰 목록 -->
	<div id="paging" class="reviews">
		<ul>
			<c:forEach var="tmp" items="${reviewList }">
				<li id="review${tmp.num }" style="padding-left:50px;">
					<dl>
						<dt>
							<span>${tmp.writer }</span>
							<span>${tmp.regdate }</span>
							<c:if test="${tmp.writer eq id }">
								| <a data-num="${tmp.num }" href="javascript:" class="review-update-link">수정</a>
								| <a data-num="${tmp.num }" href="javascript:" class="review-delete-link">삭제</a>
							</c:if>
						</dt>
						<dd><pre>${tmp.content }</pre></dd>
					</dl>
					<!-- 로그인된 아이디와 리뷰의 작성자가 같으면 수정 폼 출력 -->
					<c:if test="${tmp.writer eq id }">
						<form class="review-form update-form" action="private/review_update.do" method="post">
							<input type="hidden" name="num" value="${tmp.num }"/>
							<textarea name="content">${tmp.content }</textarea>
							<button type="submit">수정</button>
						</form>
					</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
	<nav class="navbar justify-content-center">
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link" href="detail.do?num=${shopDto.num }&pageNum=${startPageNum-1 }#paging">&laquo;</a>
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
					<a class="page-link" href="detail.do?num=${shopDto.num }&pageNum=${i}#paging">${i}</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum ne totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="detail.do?num=${shopDto.num }&pageNum=${endPageNum+1}#paging">&raquo;</a>
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
<script>
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(document).on("click",".review-update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#review"+$(this).attr("data-num");
		//구성된 id  선택자를 이용해서 원하는 li 요소에서 .update-form 을 찾아서 동작하기
		$(selector)
		.find(".update-form")
		.slideToggle();
	});
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정폼을 
	//ajax 요청을 통해 전송하고 응답받기
	$(document).on("submit", ".update-form", function(){
		//이벤트가 일어난 폼을 ajax로 전송되도록 하고 
		$(this).ajaxSubmit(function(data){
			//수정이 일어난 댓글의 li 요소를 선택해서 원하는 작업을 한다.
			var selector="#review"+data.num; //"#review6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".update-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	$(document).on("click",".review-delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		let isDelete=confirm("리뷰를 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+
			"/shop/private/review_delete.do?num="+num+"&bookNum=${shopDto.num}";
		}
	});
	$(document).on("submit",".insert-form", function(){
		//로그인 여부
		var isLogin=${not empty id};
		var isReview=${checkReviewCount ge 1}
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.");
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/shop/detail.do?num=${shopDto.num}";
			return false; //폼 전송 막기 		
		}
		if(isReview == true){
			alert("이미 리뷰를 작성하셨습니다.");
			return false;
		}
	});
	function deleteReview(num){
		var isDelete=confirm("이 제품을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="delete.do?num=${dto.num}";
		}
	}
	$(document).on("click","#addCartBtn", function(){
		var gdsNum = $("#gdsNum").val();
		var cartStock = $("#cartStock").val();
	
		var data = {
			gdsNum : gdsNum,
			cartStock : cartStock
		};
   
		$.ajax({
			url : "${pageContext.request.contextPath }/shop/private/addCart.do",
			type : "post",
			data : data,
			success : function(result){
				if(result == 1) {
					alert("카트 담기 성공");
					$("#cartStock").val("1");
				} else {
					alert("회원만 사용할 수 있습니다.")
					$("#cartStock").val("1");
				}
			},
			error : function(){
			alert("카트 담기 실패");
			}
		});
	});
</script>
</body>
</html>