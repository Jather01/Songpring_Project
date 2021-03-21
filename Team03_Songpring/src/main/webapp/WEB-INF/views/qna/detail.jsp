<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qna/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/* 리뷰 글 스타일 */
	.comment ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comment dt{
		margin-top: 5px;
	}
	.comment dd{
		margin-left: 50px;
	}
	.comment-form textarea, .comment-form button{
		float: left;
	}
	.comment li{
		clear: left;
	}
	.comment ul li{
		border-top: 1px solid #888;
	}
	.comment-form textarea{
		width: 85%;
		height: 100px;
	}
	.comment-form button{
		width: 15%;
		height: 100px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
	.comment .comment-form{
		display: none;
	}
	/* .reply_icon 을 li 요소를 기준으로 배치 하기 */
	.comment li{
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
	<table class="table table-bordered">
		<tr>
			<th>글번호</th>
			<td>${dto.num }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${dto.writer }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${dto.title }</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>${dto.regdate }</td>
		</tr>
		<tr>
			<td colspan="2">
				<div>${dto.content }</div>
			</td>
		</tr>
	</table>
	<a class="btn btn-success" href="list.do">목록보기</a>
	<c:if test="${dto.writer eq sessionScope.id }">
		<a class="btn btn-primary" href="private/updateform.do?num=${dto.num }">수정</a>
		<a class="btn btn-danger" href="javascript:deleteConfirm()">삭제</a>
	</c:if>
	<c:if test="${sessionScope.userGrade eq 'manager' and empty dto.managerComment}">
		<!-- 원글에 리뷰를 작성하는 form -->
		<form class="comment-form insert-form" action="manager/comment_update.do" method="post">
			<!-- 원글의 글번호가 num이 된다. -->
			<input type="hidden" name="num" value="${dto.num }"/>
			<textarea name="managerComment"></textarea>
			<button type="submit">답변 등록</button>
		</form>
	</c:if>
	<c:if test="${not empty dto.managerComment}">
		<!-- 답변 -->
		<div class="comment">
			<ul>
				<li id="comment" style="padding-left:50px;">
					<dl>
						<dt>
							<span>관리자</span>
							<c:if test="${sessionScope.userGrade eq 'manager'}">
								| <a data-num="comment${dto.num }" href="javascript:" class="comment-update-link">수정</a>
								| <a data-num="comment${dto.num }" href="javascript:" class="comment-delete-link">삭제</a>
							</c:if>
						</dt>
						<dd><pre>${dto.managerComment }</pre></dd>
					</dl>
					<c:if test="${sessionScope.userGrade eq 'manager'}">
						<form class="comment-form update-form" action="manager/comment_update.do" method="post">
							<input type="hidden" name="num" value="${dto.num }"/>
							<textarea name="managerComment">${dto.managerComment }</textarea>
							<button type="submit">수정</button>
						</form>
					</c:if>
				</li>
			</ul>
		</div>
	</c:if>
</div>
<jsp:include page="../include/bottomnavbar.jsp"></jsp:include>
<script>
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(document).on("click",".comment-update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#comment"+$(this).attr("data-num");
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
			var selector="#comment"+data.num; //"#comment6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".update-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	$(document).on("click",".comment-delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		let isDelete=confirm("답변을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+
			"/qna/manager/comment_delete.do?num="+num;
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="delete.do?num=${dto.num}";
		}
	}
</script>
</body>
</html>