<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop/manager/updatedorm.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.img-wrapper img{
		width: 500px;
		height: 500px;
		object-fit: scale-down;
		margin-bottom: 50px;
	}
	#content{
		width: 99%;
		height: 400px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<form action="update.do" method="post" id="updateForm">
		<input type="hidden" name="num" id="num" value="${shopDto.num }"/>
		<input type="hidden" name="imagePath" id="imagePath"  value="${shopDto.imagePath }"/>
		<div class="form-group">
			<label for="title">책 제목</label>
			<input class="form-control" type="text" name="title" id="title" value="${shopDto.title }"/>
		</div>
		<div class="form-group">
			<label for="genre">장르</label>
			<select name="genre" id="genre">
				<option value="novel" ${shopDto.genre=="novel"? "selected":"" }>소설</option>
				<option value="culture" ${shopDto.genre=="culture"? "selected":"" }>교양</option>
				<option value="workbook" ${shopDto.genre=="workbook"? "selected":"" }>문제집</option>
				<option value="comicbook" ${shopDto.genre=="comicbook"? "selected":"" }>만화</option>
				<option value="dictionary" ${shopDto.genre=="dictionary"? "selected":"" }>사전</option>
			</select>
		</div>
		<div class="form-group">
			<label for="writer">저자</label>
			<input class="form-control" type="text" name="writer" id="writer" value="${shopDto.writer }"/>
		</div>
		<div class="form-group">
			<label for="publisher">출판사</label>
			<input class="form-control" type="text" name="publisher" id="publisher" value="${shopDto.publisher }"/>
		</div>
		<div class="form-group">
			<label for="regdate">출판 날짜</label>
			<input class="form-control" type="date" name="regdate" id="regdate" value="${shopDto.regdate }"/>
		</div>
		<div class="form-group">
			<label for="price">가격</label>
			<input class="form-control" type="text" name="price" id="price" value="${shopDto.price }"/>
		</div>
		<div class="form-group">
			<label for="content">책 설명</label>
			<textarea class="form-control" name="content" id="content">${shopDto.content }</textarea>
		</div>
		<div class="form-group">
			<label for="page">페이지 수</label>
			<input class="form-control" type="text" name="page" id="page" value="${shopDto.page }"/>
		</div>
		<div class="form-group">
			<label for="bookSize">책 크기(가로*세로*두께)</label>
			<input class="form-control" type="text" name="bookSize" id="bookSize" value="${shopDto.bookSize }"/>
			<small class="form-text text-muted">가로*세로*두께 형식으로 적어주세요.</small>
			<div class="invalid-feedback">형식을 맞춰주세요.</div>
		</div>
	</form>
	<form action="ajax_upload.do" method="post" id="ajaxForm" enctype="multipart/form-data">
		<div class="form-group">
			<label for="image">이미지</label>
			<input type="file" class="form-control-file" name="image" id="image"
				 accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG"/>
		</div>
	</form>
	<button class="btn btn-primary" id="submitBtn" onclick="submitContents(this);">등록</button>
	<div class="img-wrapper pagination justify-content-center">
		<img id="bookMain" src="${pageContext.request.contextPath }${shopDto.imagePath }"/>
	</div>
</div>
<jsp:include page="../../include/bottomnavbar.jsp"></jsp:include>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
		$("#updateForm").submit();
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
	//form 플러그인을 이용해서 form 이 ajax 전송(페이지 전환없이) 되도록 한다.
	$("#ajaxForm").ajaxForm(function(data){
		console.log(data);
		// 로딩할 이미지의 경로 구성
		let src="${pageContext.request.contextPath }"+data.imagePath;
		// img 요소의 src속성으로 지정을 해서 이미지를 표시한다.
		$("#bookMain").attr("src",src);
		// insertForm에 input type="hidden"에 value로 넣어준다.
		$("#imagePath").val(data.imagePath);
	});
	// 이미지를 선택하면 강제로 폼 전송 시키기
	$("#image").on("change",function(){
		$("#ajaxForm").submit();
	});
	// 버튼을 누르면 insertForm 강제 제출해서 이미지 정보가 저장되도록 한다.
	/* $("#submitBtn").on("click",function(){
		$("#insertForm").submit();
	}); */
	
	// 정규 표현식
	let reg_bookSize=/[0-9]+\*[0-9]+\*[0-9]+/;
	$("#bookSize").on("input", function(){
		let inputBookSize=$("#bookSize").val();
		//일단 모든 검증 클래스를 제거하고
		$("#bookSize").removeClass("is-valid is-invalid");
		//만일 책 사이즈가 정규표현식에 매칭되지 않는다면
		if(!reg_bookSize.test(inputBookSize)){
			isEmailValid=false;
			$("#bookSize").addClass("is-invalid");
		}else{
			isEmailValid=true;
			$("#bookSize").addClass("is-valid");
		}
	});
</script>
</body>
</html>