<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.pageTitle}</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<style>

div#userId-container span.guide{display: none; font-size: 12px; position: absolute; top:12px; right: 10px;}
span.pwd{display: none; font-size: 12px; position: absolute; top:12px; right: 10px;}
div#userId-container span.ok{color: green;}
div#userId-container span.error{color: red;}
</style>
</head>
<body>

<script>
 $(function () {
	 /* 패스워드 */
	$("#password2").blur(function () {
		var p1 = $("#password_").val();
		var p2 = $(this).val();
		if(p1!=p2){
			alert("패스워드가 일치하지 않습니다.");
			$("#password_").focus();
		}
	});
	
	/* 아이디 */
	$("#userId_").on("keyup",function(){
		var userId = $(this).val().trim();
		if(userId.length<4) return;
		
		$.ajax({
			url : "checkIdDuplicate.do",
			data : {userId:userId},
			dataType:"json",
			success : function(data){
				console.log(data);
				if(data.isUsable==true){
					$(".guide.ok").show();
					$(".guide.error").hide();
					$("#idDuplicateCheck").val(1);
				}else{
					$(".guide.error").show();
					$(".guide.ok").hide();
					$("#idDuplicateCheck").val(0);
				}
			},
			error :function(jqxhr,textStatus,errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
			}
		});
	});
	
	/* 파일 업로드 */
	$("input:file").change(function() {
		var ext = $("input:file").val().split(".").pop().toLowerCase();
		if(ext.length > 0){
			if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) { 
				alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
				return false;  
			}
		} 
		console.log(ext);
		var data = new FormData();
		var upFile = document.getElementById("upFile").files[0];
		data.append("upFile",upFile);
		
		$.ajax({
			url: "memberImgUpload.do",
			data: data,
			contentType : false,
			processData : false,
			type: "POST",
			dataType : "json",
			success : function(date){
				var html = "";
				html += "<img class ='call_img'   src='${pageContext.request.contextPath }/resources/upload/member/"+date.renamedFileName+"'>";
				$("#div-img-ik").before(html);
				$("#mprofile").val(date.renamedFileName)
				$(".fa").on("click",function () {
					$(this).parent().remove();
				});
			},
			error:function(jqxhr,textStatus,errorThrown){
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			},
			cache : false,
			processData:false
		});	
		
	});
	
});

function validate() {
	/* id */
	var userId = $("#userId_");
	if(userId.val().trim().length<4){
		alert("아이디는 최소4자이이상이어야합니다");
		userId.focus();
		return false;
	}
	if(userId.val().indexOf(" ")>=0){
		alert("아이디는 공백을 사용할 수 없습니다");
		userId.focus();
		return false;
	}
	if(userId.val().search(/[!@#$%^&*()?_~]/g)>=0){
		alert("아이디는 특수문자를 사용할 수 없습니다");
		userId.focus();
		return false;
	}
	if(userId.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g)>=0){
		alert("아이디는 한글을 사용할 수 없습니다");
		userId.focus();
		return false;
	}
	
	var idcheck = $("#idDuplicateCheck").val()
	if(idcheck==0){
		alert("아이디가 중복 됩니다.");
		userId.focus();
		return false;
	}
	
	/* password */
	var password = $("#password_");
	if(password.val()==userId.val()){
		alert("아이디와 패스워드가 동일합니다.");
		password.focus();
		return false;
	}
	if(password.val().trim().length<8 ){
		alert("패스워든는 8글자보다 작습니다");
		password.focus();
		return false;
	}
	
	if(password.val().indexOf(" ")>=0){
		alert("패스워드는 공백을 사용할 수 없습니다");
		password.focus();
		return false;
	}
	if(password.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g)>=0){
		alert("패스워드는 한글을 사용할 수 없습니다");
		password.focus();
		return false;
	}
	if(password.val().search(/[!@#$%^&*()?_~]/g)<=2){
		alert("패스워드는 특수문자를 최소2개 이상 사용해야 합니다.");
		password.focus();
		return false;
	}
	if(password.val().search(/[0-9]/g)<=3){
		alert("패스워드는 숫자를 최소3개 이상 사용해야 합니다.");
		password.focus();
		return false;
	}
	
	var name = $("#name");

	if(name.val().trim().length<2){
		alert("이름을 2글자 이상 입력해 주세요.");
		name.focus();
		return false;
	}

	if(name.val().trim().indexOf(" ")>=0){
		alert("이름을에 공백을  사용할 수 없습니다.");
		name.focus();
		return false;
	}
	if(name.val().search(/[!@#$%^&*()?_~]/g)!=-1){
		alert("이름에 특수 문자를 입력할 수 없습니다.");
		name.focus();
		return false;
	}
 	if(name.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ]/g)!=-1){
		alert("이름에 온전한 한글을 입력해 주세요.");
		name.focus();
		return false;
	} 
	if(name.val().search(/[a-z|A-Z]/g)!=-1){
		alert("이름에 영어를 입력할 수 없습니다..");
		name.focus();
		return false;
	}
	if(name.val().search(/[0-9]/g)!=-1){
		alert("이름에 숫자를 입력할 수 없습니다.");
		name.focus();
		return false;
	}
	
	var phone = $("#phone");
	if(phone.val().search(/[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|!@#$%^&*()?_~]/g)!=-1){
		alert("전화번호는 숫자만 가능합니다.");
		phone.focus();
		return false;
	}
	if(phone.val().trim().length<7){
		alert("전화번호를 다시 입력해 주세요.");
		phone.focus();
		return false;
	}
	
	/* 이메일  */
	var email = $("#email").val();
	var emailaddr = $("#emailaddr");
	if(emailaddr.val().search(/[.]/g)==-1){
		alert("이메일 형식이 바르지 않습니다.");
		emailaddr.focus();
		return false;
	}
	
	var checkPoint = $("#checkPoint").val();
	if(checkPoint==0){
		return false;
	}

	/* 생년월일  */
	var year = $("#year");
	if(year.val().trim().length!=4){
		alert("생년월일을 다시 입력하세요.");
		year.focus();
		return false;
	} 
	 
	
	return true;
}
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
 
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
 
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
 
                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
    
    /* 이메일 인증 번호 전송 */
    function fn_certification() {
    	var email = $("#email").val();
    	var emailaddr = $("#emailaddr").val();
    	
    	if(email.trim().length==0){
    		alert("이메일을 입력하세요.");
    		email.focus();
    	}
    	if(emailaddr.trim().length==0){
    		alert("이메일을 입력하세요.");
    		emailaddr.focus();
    	}
    	
    	var data = new FormData();
		var em = email +"@"+emailaddr;
		data.append("em",em);
    	
    	$.ajax({
    		url: "certification.do",
			data: data,
			contentType : false,
			processData : false,
			type: "POST",
			dataType : "json",
			success : function(date){
				console.log("성공"); 
				
			},
			error:function(jqxhr,textStatus,errorThrown){
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			},
			cache : false,
			processData:false
    		
    	});
    }
    
    /* 이메일 인증번호 확인 */
    function checkJoinCode() {
    	var email = $("#email").val();
    	var emailaddr = $("#emailaddr").val();
    	var inputCode = $("#inputCode").val();
    	
    	if(email.trim().length==0){
    		alert("이메일을 입력하세요.");
    		email.focus();
    	}
    	if(emailaddr.trim().length==0){
    		alert("이메일을 입력하세요.");
    		emailaddr.focus();
    	}
    	
    	var data = new FormData();
		var em = email +"@"+emailaddr;
		console.log("em : "+em); 
		data.append("em",em);
    	data.append("inputCode",inputCode)
    	$.ajax({
    		url: "checkJoinCode.do",
			data: data,
			contentType : false,
			processData : false,
			type: "POST",
			dataType : "json",
			success : function(date){
				if(date.result==true){
					$("#checkPoint").val(1);
					alert("이메일 인증을 성공했습니다.")
				}else{
					$("#checkPoint").val(0);
					alert("이메일 인증을 실패했습니다.")
				}
			},
			error:function(jqxhr,textStatus,errorThrown){
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorThrown);
			},
			cache : false,
			processData:false
    		
    	});
    }
</script>

<div id="enroll-container">
	<form action="${pageContext.request.contextPath}/member/memberEnrollEnd.do" method="post" onsubmit="return validate();">
		<div id="userId-container">
			<input type="text"  name="mid" id="userId_" placeholder="아이디" required/> <br />
			<span class="guide ok">중복된 아이디가 없습니다.</span>
			<span class="guide error">중복된 아이디가 있습니다.</span>
			<input type="hidden" id="idDuplicateCheck" value="0"/>
		</div>
		<div>
			<input type="password"  name="pwd" id="password_" placeholder="비밀번호" required/> <br />
			<input type="password" id="password2" placeholder="비밀번호 확인" required/> <br />
			<span class="pwd ok">비밀번호가 동일합니다.</span>
			<span class="pwd error">비밀번호가 다릅니다.</span>
		</div>
		
		<input type="text"  name="mname" id="name" placeholder="이름" required/> 
		<br />
		<input type="text"  name="phone" id="phone" maxlength="11" placeholder="전화번호" required/> 
		<br />
		<input type="text"  name="email" id="email"  placeholder="이메일" required/>
		 @
		<input type="text" name="email" id="emailaddr"  placeholder="직접입력" required/> 
		
		<button type="button" onclick="fn_certification();">인증번호</button>
		<br />
		
		<input type="text" id="inputCode" placeholder="인증번호를 입력하세요"/>
		<input type="button" value="확인" onclick="checkJoinCode();" />
		<input type="hidden" id="checkPoint" value="0" />
		<br />
		
		<input type="text" name="birth" id="year" placeholder="출생년도" > 
		<select name="birth" id="month">
			<option value="" selected>출생월</option>
			<option value="1">1월</option>
			<option value="2">2월</option>
			<option value="3">3월</option>
			<option value="4">4월</option>
			<option value="5">5월</option>
			<option value="6">6월</option>
			<option value="7">7월</option>
			<option value="8">8월</option>
			<option value="9">9월</option>
			<option value="10">10월</option>
			<option value="11">11월</option>
			<option value="12">12월</option>
		</select>
		<select name="birth" id="day">
			 <option value="">출생일</option>
			 <option value="1">1</option>
		     <option value="2">2</option>
		     <option value="3">3</option>
		     <option value="4">4</option>
		     <option value="5">5</option>
		     <option value="6">6</option>
		     <option value="7">7</option>
		     <option value="8">8</option>
		     <option value="9">9</option>
		     <option value="10">10</option>
		     <option value="11">11</option>
		     <option value="12">12</option>
		     <option value="13">13</option>
		     <option value="14">14</option>
		     <option value="15">15</option>
		     <option value="16">16</option>
		     <option value="17">17</option>
		     <option value="18">18</option>
		     <option value="19">19</option>
		     <option value="20">20</option>
		     <option value="21">21</option>
		     <option value="22">22</option>
		     <option value="23">23</option>
		     <option value="24">24</option>
		     <option value="25">25</option>
		     <option value="26">26</option>
		     <option value="27">27</option>
		     <option value="28">28</option>
		     <option value="29">29</option>
		     <option value="30">30</option>
		     <option value="31">31</option>
		</select>
		
		<br />
		
		<div class="input">
             <input type="button" class="btn-primary box" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
         </div>
         <div class="input">
             <input type="text" name="addr" id="sample4_postcode" placeholder="우편번호" required>
         </div>
         <div class="input">
             <input type="text" name="addr" id="sample4_jibunAddress" placeholder="지번주소" required>
         </div>
         <div class="input">
             <input type="text" name="addr" id="sample4_roadAddress" placeholder="도로명주소" required>
         </div>
         <div class="input">
             <input type="text" name="addr" id="sample4_jibunAddress" placeholder="상세정보" required>
         </div>
                    
		<input type="radio" name="gender" value="M" id="male" checked/><label for="male">male</label>
		<input type="radio" name="gender" value="F" id="fmale" /><label for="fmale">fmale</label>
		
		 <br />
		 
		프로필사진 : <input type="file" name="upFile" id="upFile" />
		<input type='hidden' name='mprofile' id="mprofile" value='no' >
		<div id="div-img-ik"></div>
		
		<br />
		<!-- ======db연동으로 수정요망======= -->
		<div class="form-check-inline form-check">
			관심분야 : &nbsp;
			<input type="checkbox" class="form-check-input" value="JAVA" name="favor" id="hobby1"  />
			<label for="hobby1" class="form-check-input">JAVA</label>
			<input type="checkbox" class="form-check-input" value="C++" name="favor" id="hobby2" />
			<label for="hobby2" class="form-check-input">C++</label>
			<input type="checkbox" class="form-check-input" value="JAVASCRIPT" name="favor" id="hobby3" />
			<label for="hobby3" class="form-check-input">JAVASCRIPT</label>
			<input type="checkbox" class="form-check-input" value="PYTHON" name="favor" id="hobby4" />
			<label for="hobby4" class="form-check-input">PYTHON</label>
		</div>
		<!-- ======db연동으로 수정요망======= -->
		

		
		<br />
		 <button type="button" onclick="location.href='${pageContext.request.contextPath}'">취소</button>		
		 <input type="submit" value="가입"  />
	</form>
	
	
	
</div>
</body>
</html>