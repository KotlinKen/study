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
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
	integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
	crossorigin="anonymous"></script>
<style>
div#userId-container span.guide {
	display: none;
	font-size: 12px;
	position: absolute;
	top: 12px;
	right: 10px;
}
span.pwd {
	display: none;
	font-size: 12px;
	position: absolute;
	top: 12px;
	right: 10px;
}
div#userId-container span.ok {
	color: green;
}
div#userId-container span.error {
	color: red;
}
</style>
</head>
<body>

	<script>
		$(function() {
			/* 패스워드 */
			$("#password_").blur(function() {
				var p1 = $("#password_");
				var p2 = $(this).val();
				if(p1.val().trim().length ==0){
					 document.getElementById("pwd").innerHTML = "패스워드를 입력하세요";
					p1.focus();
				}else{
					document.getElementById("pwd").innerHTML = "";
				}
			
				if (p1.val().trim().length < 8) {
					document.getElementById("pwd").innerHTML = "사용불가";
					password.focus();
				}
				if (p1.val().indexOf(" ") >= 0) {
					document.getElementById("pwd").innerHTML = "사용불가";
					password.focus();
				}
				if (p1.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g) >= 0) {
					document.getElementById("pwd").innerHTML = "사용불가";
					password.focus();
				}
			
				if (p1.val().search(/[!@#$%^&*()?_+~]/g) == -1) {
					document.getElementById("pwd").innerHTML = "사용불가";
					password.focus();
				} 
			  
				if (p1.val().search(/[0-9]/g) == -1) {
					document.getElementById("pwd").innerHTML = "사용불가";
					password.focus();
				}
			});
			$("#password2").blur(function() {
				var p1 = $("#password_").val();
				var p2 = $(this).val();
				if(p1.trim().length==0){
					document.getElementById("pwd2").innerHTML = "패스워드를 입력하세요.";
					$("#pwdDuplicateCheck").val(0);
					$("#password_").focus();
					return;
				}
				if (p1 != p2) {
					document.getElementById("pwd2").innerHTML = "패스워드가 다릅니다.";
					$("#pwdDuplicateCheck").val(0);
					$("#password_").focus();
				} else {
					document.getElementById("pwd2").innerHTML = "패스워드가 동일합니다.";
					$("#pwdDuplicateCheck").val(1);
				}
			});
			/* 아이디 */
			$("#userId_").on("keyup", function() {
				var userId = $(this).val().trim();
				if (userId.length > 11)
					alert("아이디가 너무 김니다.")
			});
			/* 파일 업로드 */
			$("input:file").change(
			function() {
				var ext = $("input:file").val().split(".")
						.pop().toLowerCase();
				if (ext.length > 0) {
					if ($.inArray(ext, [ "gif", "png", "jpg",
							"jpeg" ]) == -1) {
						alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
						return false;
					}
				}
				console.log(ext);
				var data = new FormData();
				var upFile = document.getElementById("upFile").files[0];
				data.append("upFile", upFile);
				$.ajax({
					url : "memberImgUpload.do",
					data : data,
					contentType : false,
					processData : false,
					type : "POST",
					dataType : "json",
					success : function(date) {
						var html = "";
						html += "<img class ='call_img'   src='${pageContext.request.contextPath }/resources/upload/member/"+date.renamedFileName+"'>";
						$("#div-img-ik").before(html);
						$("#mprofile").val(
								date.renamedFileName)
						$(".fa").on(
								"click",
								function() {
									$(this).parent()
											.remove();
								});
					},
					error : function(jqxhr, textStatus,
							errorThrown) {
						console.log(jqxhr);
						console.log(textStatus);
						console.log(errorThrown);
					},
					cache : false,
					processData : false
				});
			});
		});
		function fn_checkID() {
			var userId = $("#userId_").val().trim();
			if (userId.length < 4) {
				alert("아이디는 4글자 이상 입니다.");
				userId.focus();
				return;
			}
			if (userId.length > 11) {
				alert("아이디는 10글자 이하 입니다.");
				userId.focus();
				return;
			}
			if (userId.indexOf(" ") >= 0) {
				alert("아이디는 공백을 사용할 수 없습니다");
				userId.focus();
				return;
			}
			if (userId.search(/[!@#$%^&*()?_~]/g) >= 0) {
				alert("아이디는 특수문자를 사용할 수 없습니다");
				userId.focus();
				return;
			}
			if (userId.search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g) >= 0) {
				alert("아이디는 한글을 사용할 수 없습니다");
				userId.focus();
				return;
			}
			$.ajax({
				url : "checkIdDuplicate.do",
				data : {
					userId : userId
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					if (data.isUsable == true) {
						$(".guide.ok").show();
						$(".guide.error").hide();
						$("#idDuplicateCheck").val(1);
					} else {
						$(".guide.error").show();
						$(".guide.ok").hide();
						$("#idDuplicateCheck").val(0);
					}
				},
				error : function(jqxhr, textStatus, errorThrown) {
					console.log("ajax실패", jqxhr, textStatus, errorThrown);
				}
			});
		}
		function validate() {
			/* id */
			var userId = $("#userId_");
			if (userId.val().trim().length < 4) {
				alert("아이디는 최소4자이이상이어야합니다");
				userId.focus();
				return false;
			}
			if (userId.val().trim().length > 11) {
				alert("아이디는 최소11자이이하이어야합니다");
				userId.focus();
				return false;
			}
			if (userId.val().indexOf(" ") >= 0) {
				alert("아이디는 공백을 사용할 수 없습니다");
				userId.focus();
				return false;
			}
			if (userId.val().search(/[!@#$%^&*()?_~]/g) >= 0) {
				alert("아이디는 특수문자를 사용할 수 없습니다");
				userId.focus();
				return false;
			}
			if (userId.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g) >= 0) {
				alert("아이디는 한글을 사용할 수 없습니다");
				userId.focus();
				return false;
			}
			var idcheck = $("#idDuplicateCheck").val();
			if (idcheck == 0) {
				alert("아이디가 확인 하세요.");
				userId.focus();
				return false;
			}
			/* password */
			var password = $("#password_");
			var pwdcheck = $("#pwdDuplicateCheck").val();
			if (password.val() == userId.val()) {
				alert("아이디와 패스워드가 동일합니다.");
				password.focus();
				return false;
			}
			if (password.val().trim().length < 8) {
				alert("패스워든는 8글자보다 작습니다");
				password.focus();
				return false;
			}
			if (password.val().indexOf(" ") >= 0) {
				alert("패스워드는 공백을 사용할 수 없습니다");
				password.focus();
				return false;
			}
			if (password.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g) >= 0) {
				alert("패스워드는 한글을 사용할 수 없습니다");
				password.focus();
				return false;
			}
		
			if (password.val().search(/[!@#$%^&*()?_+~]/g) == -1) {
				alert(password.val()+"패스워드는 특수문자를 사용해야 합니다.");
				password.focus();
				return false;
			} 
		  
			if (password.val().search(/[0-9]/g) == -1) {
				alert("패스워드는 숫자를 사용해야 합니다.");
				password.focus();
				return false;
			}
			if (pwdcheck == 0) {
				alert("비밀번호가 일치하지 않습니다");
				password.focus();
				return false;
			}
			var name = $("#name");
			if (name.val().trim().length < 2) {
				alert("이름을 2글자 이상 입력해 주세요.");
				name.focus();
				return false;
			}
			if (name.val().trim().indexOf(" ") >= 0) {
				alert("이름을에 공백을  사용할 수 없습니다.");
				name.focus();
				return false;
			}
			if (name.val().search(/[!@#$%^&*()?_~]/g) != -1) {
				alert("이름에 특수 문자를 입력할 수 없습니다.");
				name.focus();
				return false;
			}
			if (name.val().search(/[ㄱ-ㅎ|ㅏ-ㅣ]/g) != -1) {
				alert("이름에 온전한 한글을 입력해 주세요.");
				name.focus();
				return false;
			}
			if (name.val().search(/[a-z|A-Z]/g) != -1) {
				alert("이름에 영어를 입력할 수 없습니다..");
				name.focus();
				return false;
			}
			if (name.val().search(/[0-9]/g) != -1) {
				alert("이름에 숫자를 입력할 수 없습니다.");
				name.focus();
				return false;
			}
			var phone = $("#phone");
			if (phone.val().search(/[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|!@#$%^&*()?_~]/g) != -1) {
				alert("전화번호는 숫자만 가능합니다.");
				phone.focus();
				return false;
			}
			if (phone.val().trim().length < 9) {
				alert("전화번호를 다시 입력해 주세요.");
				phone.focus();
				return false;
			}
			/* 이메일  */
			var email = $("#email").val();
			var emailaddr = $("#emailaddr");
			if (emailaddr.val().search(/[.]/g) == -1) {
				alert("이메일 형식이 바르지 않습니다.");
				emailaddr.focus();
				return false;
			}
			var checkPoint = $("#checkPoint").val();
			if (checkPoint == 0) {
				alert("이메일 인증을 바랍니다");
				emailaddr.focus();
				return false;
			}
			/* 생년월일  */
			var year = $("#year");
			var month = $("#month");
			var day = $("#day");
			if (year.val().trim().length != 4) {
				alert("생년월일을 다시 입력하세요.");
				year.focus();
				return false;
			}
			if (month.val().trim().length == 0) {
				alert("생년월일을 다시 입력하세요.");
				year.focus();
				return false;
			}
			if (day.val().trim().length == 0) {
				alert("생년월일을 다시 입력하세요.");
				year.focus();
				return false;
			}
			return true;
		}
	</script>

	<script>
		/* 이메일 인증 번호 전송 */
		function fn_certification() {
			var email = $("#email").val();
			var emailaddr = $("#emailaddr").val();
			if (email.trim().length == 0) {
				alert("이메일을 입력하세요.");
				email.focus();
			}
			if (emailaddr.trim().length == 0) {
				alert("이메일을 입력하세요.");
				emailaddr.focus();
			}
			if (emailaddr.search(/[.]/g) == -1) {
				alert("이메일 형식이 바르지 않습니다.");
				emailaddr.focus();
			}
			if(emailaddr.search(/[@]/g) >0){
				alert("이메일 형식이 바르지 않습니다.");
				emailaddr.focus();
			}
			var data = new FormData();
			var em = email + "@" + emailaddr;
			data.append("em", em);
			alert("인증번호 전송");
			$.ajax({
				url : "certification.do",
				data : data,
				contentType : false,
				processData : false,
				type : "POST",
				dataType : "json",
				success : function(date) {
					if(date.check==true){
					$("#checkcertification").val(1);
					}else{
					alert("인증번호 전송실패");
					}
				},
				error : function(jqxhr, textStatus, errorThrown) {
					alert("인증번호 전송실패");
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				},
				cache : false,
				processData : false
			});
		}
		/* 이메일 인증번호 확인 */
		function checkJoinCode() {
			var email = $("#email").val();
			var emailaddr = $("#emailaddr").val();
			var inputCode = $("#inputCode").val();
			var checkcertification = $("#checkcertification").val();
			if (email.trim().length == 0) {
				alert("이메일을 입력하세요.");
				email.focus();
			}
			if (emailaddr.trim().length == 0) {
				alert("이메일을 입력하세요.");
				emailaddr.focus();
			}
			if(checkcertification ==0){
				alert("이메일을 인증을 먼저 하세요.");
				emailaddr.focus();
			}
			var data = new FormData();
			var em = email + "@" + emailaddr;
			console.log("em : " + em);
			data.append("em", em);
			data.append("inputCode", inputCode)
			$.ajax({
				url : "checkJoinCode.do",
				data : data,
				contentType : false,
				processData : false,
				type : "POST",
				dataType : "json",
				success : function(date) {
					console.log(data.result);
					if (date.result == true) {
						$("#checkPoint").val(1);
						alert("이메일 인증을 성공했습니다.")
					} else {
						$("#checkPoint").val(0);
						alert("이메일 인증을 실패했습니다.")
					}
				},
				error : function(jqxhr, textStatus, errorThrown) {
					alert("이메일 인증을 실패했습니다.")
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				},
				cache : false,
				processData : false
			});
		}
	</script>

	<div id="enroll-container">
		<form
			action="${pageContext.request.contextPath}/member/memberEnrollEnd.do"
			method="post" name='mainForm' id='mainForm'
			onsubmit="return validate();">
			<div id="userId-container">
				<input type="text" name="mid" id="userId_" placeholder="아이디" required autocomplete="off" />
				<button type="button" onclick="fn_checkID();">아이디 확인</button>
				<br /> <span class="guide ok">중복된 아이디가 없습니다.</span> 
				<span class="guide error">중복된 아이디가 있습니다.</span> 
				<input type="hidden" id="idDuplicateCheck" value="0" />
			</div>
			<div>
				<input type="password" name="pwd" id="password_" placeholder="비밀번호" required autocomplete="off"  /> <br /> 
				<span id="pwd"></span> 
				<input type="password" id="password2" placeholder="비밀번호 확인"  required autocomplete="off"  /> <br /> 
				<span id="pwd2"></span> 
				<input type="hidden" id="pwdDuplicateCheck" value="0" />
			</div>

			<input type="text" name="mname" id="name" placeholder="이름" required  autocomplete="off"  /><br /> 
			<input type="text" name="phone" id="phone" maxlength="11" placeholder="전화번호" required required autocomplete="off"  /> <br /> 
			<input type="text" name="email" id="email" placeholder="이메일" required  autocomplete="off"  /> @ 
			<input type="text" name="email" id="emailaddr" placeholder="직접입력" required  autocomplete="off"  />
			<input type="button" value="인증번호" onclick="fn_certification();" /> 
			<input type="hidden" id="checkcertification" value="0" /> 
			<input type="text" id="inputCode" placeholder="인증번호를 입력하세요" required autocomplete="off"/>
			<input type="button" value="확인" onclick="checkJoinCode();" /> 
			<input type="hidden" id="checkPoint" value="0" /> <br />
			<input type="date" name="birth" required/><br />
			<input type="radio" name="gender" value="M" id="male" checked /> 
			<label for="male">male</label> 
			<input type="radio" name="gender" value="F"id="fmale" /> <label for="fmale">fmale</label> <br /> 
			<br /><hr /><br />
			프로필사진 : <input type="file" name="upFile" id="upFile" /> 
			<input type='hidden' name='mprofile' id="mprofile" value='no'>
			<div id="div-img-ik"></div>
			<br />
			<div class="form-check-inline form-check">
				관심분야 : &nbsp;
				<c:forEach var="v" items="${list }">
					<input type="checkbox" class="form-check-input" value="${v.KINDNAME }"
						name="favor" id="${v.KINDNAME }" />
					<label for="${v.KINDNAME }" class="form-check-input">${v.KINDNAME }</label>
				</c:forEach>
			</div>

			<br /> 자기소개 <br />
			<textarea rows="10" cols="50" name="cover"></textarea>

			<br />
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}'">취소</button>
			<input type="submit" value="가입" />
		</form>

	</div>
</body>
</html>