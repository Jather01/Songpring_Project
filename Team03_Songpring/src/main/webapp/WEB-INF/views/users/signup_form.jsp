<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>회원 가입 폼 입니다.</h1>
	<!-- 
		[ novalidate 로 웹브라우저 자체의 검증기능 사용하지 않기 ]
		<input type="email" />  같은경우 웹브라우저가 직접 개입하기도 한다.
		해당기능 사용하지 않기 위해서는 novalidate 를 form 에 명시해야 한다. 
	 -->
	<form action="${pageContext.request.contextPath }/users/signup.do" method="post" id="myForm" novalidate>
		<div class="form-group">
			<label for="name">이름</label>
			<input class="form-control" type="text" name="name" id="name" placeholder="이름을 입력하세요"/>
		</div>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id"/>
			<small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요.</small>
			<div class="invalid-feedback">사용할수 없는 아이디 입니다</div>
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호</label>
			<input class="form-control" type="password" name="pwd" id="pwd"/>
			<small class="form-text text-muted">5글자~10글자 이내로 입력하세요.</small>
			<div class="invalid-feedback">비밀번호를 확인 하세요</div>
		</div>
		<div class="form-group">
			<label for="pwd2">비밀번호 확인</label>
			<input class="form-control" type="password" id="pwd2"/>
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="email" name="email" id="email"/>
			<div class="invalid-feedback">이메일 형식을 확인 하세요.</div>
		</div>
		<div class="form-group">
			<input type="text" id="sample2_postcode" placeholder="우편번호">
			<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="userAddr1" id="sample2_address" placeholder="주소"><br>
			<input type="text" name="userAddr2" id="sample2_detailAddress" placeholder="상세주소">
			<input type="text" name="userAddr3" id="sample2_extraAddress" placeholder="참고항목">
			<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
			
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		</div>
		<button class="btn btn-outline-primary" type="submit">가입</button>
	</form>
</div>
<script>
	//[아이디를 검증할 정규 표현식]
	//영문자 소문자로 시작하고 5~10 글자 이내인지 검증
	let reg_id=/^[a-z].{4,9}$/;
	
	//[비밀번호를 검증할 정규 표현식]
	//5~10 글자 이내인지 검증
	let reg_pwd=/^.{5,10}$/;
	
	//[이메일을 검증할 정규 표현식] (정확히 검증하려면 javascript 이메일 정규 표현식 검색해서 사용!)
	//@ 가 포함되어 있는지 검증 
	let reg_email=/@/; 

	//아이디 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isIdValid=false;
	//비밀번호 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isPwdValid=false;
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isEmailValid=false;
	//폼 전체의 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isFormValid=false;
	

	//폼에 submit 이벤트가 일어 났을때 jquery 를 활용해서 폼에 입력한 내용 검증하기
	// id 가 myForm 인 요소에 submit 이벤트가 일어 났을때 실행할 함수 등록 
	$("#myForm").on("submit", function(){
		//폼 전체의 유효성 여부를 얻어낸다.
		isFormValid = isIdValid && isPwdValid && isEmailValid;
		//만일 폼이 유효하지 않는다면
		if(!isFormValid){
			return false; ///폼 전송 막기 
		}
	});
	
	//이메일을 입력했을때 실행할 함수 등록
	$("#email").on("input", function(){
		let inputEmail=$("#email").val();
		//일단 모든 검증 클래스를 제거하고
		$("#email").removeClass("is-valid is-invalid");
		//만일 이메일이 정규표현식에 매칭되지 않는다면
		if(!reg_email.test(inputEmail)){
			isEmailValid=false;
			$("#email").addClass("is-invalid");
		}else{
			isEmailValid=true;
			$("#email").addClass("is-valid");
		}
	});
	
	
	// id 가 pwd 와  pwd2 인 요소에 input(입력) 이벤트가 일어 났을때 실행할 함수 등록 
	$("#pwd, #pwd2").on("input", function(){
		// input 이벤트가 언제 일어나는지 확인 요망!
		//console.log("input!!");
		
		//입력한 두 비밀번호를 읽어온다.
		let pwd=$("#pwd").val();
		let pwd2=$("#pwd2").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#pwd").removeClass("is-valid is-invalid");
		
		//비밀번호가 정규표현식에 매칭되지 않으면 
		if(!reg_pwd.test(pwd)){
			//비밀번호가 유효하지 않는다고 표시하고 
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
			//함수를 여기서 종료 
			return;
		}
		
		//두 비밀번호가 같은지 확인해서
		if(pwd==pwd2){//만일 같으면 
			//유효하다는 클래스를 추가 
			$("#pwd").addClass("is-valid");
			isPwdValid=true;
		}else{//다르면
			//유효하지 않다는 클래스 추가 
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
		}
	});
	
	//아이디 입력란에 입력했을때 실행할 함수 등록 
	$("#id").on("input", function(){
		//1. 입력한 아이디를 읽어와서
		let inputId=$("#id").val();
		
		//2. 서버에 ajax 요청으로 보내서 사용 가능 여부를 응답 받아서 반응을 보여준다.
		//일단 모든 검증 클래스를 제거하고
		$("#id").removeClass("is-valid is-invalid");
		
		//입력한 문자열이 정규표현식과 매칭되는지 테스트
		if(!reg_id.test(inputId)){//만일 매칭되지 않으면
			//아이디가 유효하지 않다고 표시하고 
			$("#id").addClass("is-invalid");
			isIdValid=false;
			//함수를 여기서 종료 한다
			return;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/users/checkid.do",
			method:"GET",
			data:"inputId="+inputId,
			success:function(responseData){
				/*
					checkid.jsp 페이지에서 응답할때 
					contentType="application/json" 이라고 설정하면
					함수의 인자로 전달되는 responseData 는 object 이다.
					{isExist:true} or {isExist:false} 
					형식의 object 이기 때문에 바로 사용할수 있다. 
				*/
				console.log(responseData);
				if(responseData.isExist){//이미 존재하는 아이디인 경우
					$("#id").addClass("is-invalid");
					isIdValid=false;
				}else{//존재하지 않는 아이디 즉 사용가능한 아이디인 경우 
					$("#id").addClass("is-valid");
					//아이디가 유효 하다고 표시한다. 
					isIdValid=true;
				}
			}
		});
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
                document.getElementById('sample2_postcode').value = data.zonecode;
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