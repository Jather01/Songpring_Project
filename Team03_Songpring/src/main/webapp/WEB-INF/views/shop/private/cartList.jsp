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
	.listResult { padding:20px; background:#eee; }
	.listResult .sum { float:left; width:45%; font-size:22px; }
	
	.listResult .orderOpne { float:right; width:45%; text-align:right; }
	.listResult .orderOpne button { font-size:18px; padding:5px 10px; border:1px solid #999; background:#fff;}
	.listResult::after { content:""; display:block; clear:both; }
	
	.orderInfo { border:5px solid #eee; padding:20px; display:none;}
	.orderInfo .inputArea { margin:10px 0; }
	.orderInfo .inputArea label { display:inline-block; width:120px; margin-right:10px; }
	.orderInfo .inputArea input { font-size:14px; padding:5px; }
	#userAddr2, #userAddr3 { width:250px; }
	
	.orderInfo .inputArea:last-child { margin-top:30px; }
	.orderInfo .inputArea button { font-size:20px; border:2px solid #ccc; padding:5px 10px; background:#fff; margin-right:20px;}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<c:set var="sum" value="${0}" />
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
					<p class="card-text">합계 ${tmp.gdsPrice * tmp.cartStock } 원</p>
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
		<c:set var="sum" value="${sum + (tmp.gdsPrice * tmp.cartStock)}" />
	</c:forEach>
	
	<div class="listResult">
		<div class="sum">
			총 ${sum} 원
		</div>
		<div class="orderOpne">
			<button type="button" class="orderOpne_bnt" ${empty cartList? 'hidden':''}>주문 정보 입력</button>
		</div>
	</div>
		<div class="orderInfo">
			<form role="form" method="post" autocomplete="off">
				<input type="hidden" name="amount" value="${sum}" />
				<div class="inputArea">
					<label for="">수령인</label>
					<input type="text" name="orderRec" id="orderRec" required="required" value="${dto.name }" />
				</div>
				<div class="inputArea">
					<label for="orderPhon">수령인 연락처</label>
					<input type="text" name="orderPhon" id="orderPhon" required="required" />
				</div>
				<div class="inputArea">
			<input type="text" name="addrNum" id="sample2_postcode" placeholder="우편번호" value="${dto.addrNum}">
			<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="userAddr1" id="sample2_address" placeholder="주소" value="${dto.userAddr1}"><br>
			<input type="text" name="userAddr2" id="sample2_detailAddress" placeholder="상세주소" value="${dto.userAddr2}">
			<input type="text" name="userAddr3" id="sample2_extraAddress" placeholder="참고항목" value="${dto.userAddr3}">
			<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
			
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				</div>
				<div class="inputArea">
					<button type="submit" class="order_btn">주문</button>
					<button type="button" class="cancel_btn">취소</button>
				</div>
			</form>
		</div>
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
	// 주문 정보 입력 버튼
	$(".orderOpne_bnt").click(function() {
		$(".orderInfo").slideDown();
		$(".orderOpne_bnt").slideUp();
	});
	// 취소 버튼
	$(".cancel_btn").click(function() {
		$(".orderInfo").slideUp();
		$(".orderOpne_bnt").slideDown();
	});
	// 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');
    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }
    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample2_postcode").value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);
        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';
        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }
    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께
        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</body>
</html>