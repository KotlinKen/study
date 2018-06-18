<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import = 'com.pure.study.member.model.vo.Member' %>
<style>
	span.check-no{
		color: red;
		display: none;
	}
	span.check-yes{
		color: green;
		display: none;
	}
	
</style>

	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
		<jsp:param value="내 정보 보기" name="pageTitle"/>
	</jsp:include>
			<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp"/>
			<form id="update-form" action="${pageContext.request.contextPath }/member/updateUser.do" method="post" enctype="multipart/form-data">
				<c:if test="${memberLoggedIn != null }">
						<input type="hidden" name="mno" id="mno" value="${memberLoggedIn.mno }" />
						회원 아이디 : 
						<input type="text" name="mid" id="mid" value="${memberLoggedIn.mid }" />					
						<br />
						
						회원 이름 : 
						<input type="text" name="mname" id="mname" value="${memberLoggedIn.mname }" />
						<br />
						
						비밀번호 변경 : 
						<button type="button" 
							class="btn btn-outline-success"
				    		data-toggle="modal" 
				    		data-target="#pwdUpdate">비밀번호 변경</button>
						<br />
						
						연락처 : 
						<input type="text" name="phone" id="phone" value="${memberLoggedIn.phone }" />
						<br />
						
						주소 : 
						<input type="text" name="addr1" id="addr1" value="${memberLoggedIn.addr1 }" />
						<br />
						<input type="text" name="addr2" id="addr2" value="${memberLoggedIn.addr2 }" />
						<br />
						<input type="text" name="addrDetail" id="addrDetail" value="${memberLoggedIn.addrDetail }" />
						<br />
						<input type="text" name="post" id="post" value="${memberLoggedIn.post }" />
						<br />
						
						사진 : 
						<img src="${pageContext.request.contextPath }/resources/upload/member/${memberLoggedIn.mprofile}" alt="${memberLoggedIn.mprofile}" style="width:100px;" /> 
						<br />
						<input type="file" name="post-file" id="post-file" />
						<input type="hidden" name="pre_mprofile" id="pre-file" value="${memberLoggedIn.mprofile }" />
						<br />
						
						이메일 변경 : 
						<button type="button"
								class="btn btn-outline-success"
					    		data-toggle="modal" 
					    		data-target="#emailUpdate">이메일 변경</button>
						<input type="email" name="email" id="email" value="${memberLoggedIn.email }" readonly /> 
						<br />
						
						생년월일 : 
						<input type="date" name="birth" id="birth" value="${memberLoggedIn.birth }" />
						<br />
						
						성별 : 
						<input type="radio" name="gender" id="M" value="M" ${memberLoggedIn.gender=='M'?'checked':'' }/>
						<label for="M">남</label>
						<input type="radio" name="gender" id="F" value="F" ${memberLoggedIn.gender=='F'?'checked':'' } />
						<label for="F">여</label>
						<br />
						
						관심사 : 
						<c:forEach var="f" items="${favor }" varStatus="vs">
							<input type="checkbox" name="favor" id="favor${vs.index }" value="${f.KINDNAME}" ${ f.KINDNAME eq memberLoggedIn.favor[vs.index] ?'checked':''}/>
							<label for="favor${vs.index }">${f.KINDNAME }</label>							
						</c:forEach>		
						<br />
						
						자기 소개 : 
						<textarea class="form-control" name="cover" cols="30" rows="10" placeholder="자기소개 및 특이 사항">${memberLoggedIn.cover }</textarea>
						<br/>
						<button type="submit" id="submit">수정</button>						
				</c:if>
				
			</form>
			<form id="drop-form" action="${pageContext.request.contextPath }/member/memberDrop.do" onsubmit="return confirm('정말 탈퇴하시겠습니까?')">
				<input type="hidden" name="mid" value="${memberLoggedIn.mid }" />
				<button type="submit" id="drop">탈퇴하기</button>
			</form>
			<!-- 비밀번호 팝업창 시작 -->
		<div class="modal fade" id="pwdUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <form action="${pageContext.request.contextPath }/member/newPwd.do" method="post" onsubmit="return pwdDuplicateCheck();">
		      <div class="modal-body">
		      	<input type="password" class="form-control" name="oldPwd" id="oldPwd" placeholder="기존 비밀번호" required/>
		      	<br />
		      	<input type="password" class="form-control" name="newPwd" id="newPwd" placeholder="새 비밀번호" required/>
		      	<br />
		      	<input type="password" class="form-control" name="newPwd_" id="newPwdCheck" placeholder="새 비밀번호 확인" required/>
		      	<span class="check-no" >불일치</span>
				<span class="check-yes" >일치</span>
				<input type="hidden" id="pwd-ok" value="1" />
		      </div>
		      <div class="modal-footer">
		        <button type="submit" class="btn btn-outline-success">변경</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>
		<!-- 비밀번호 변경 팝업창 끝 -->
		<!-- 이메일 팝업창 시작 -->
		<div class="modal fade" id="emailUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">이메일 변경</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <form action="${pageContext.request.contextPath }/member/newEmail.do" method="post" onsubmit="return emailDuplicateCheck();">
		      <div class="modal-body">
		      	<input type="email" class="form-control" name="email" id="newEmail" placeholder="이메일 변경" required/>
		      	<button type="button" class="btn btn-outline-success" id="emailUpdate">인증번호 발송</button>
		      	<br />
		      	<input type="hidden" id="send" value="keySend" />
		      	<input type="text" id="key" placeholder="인증키 입력" />
		      	<input type="hidden" id="keyCheck" value="check" />
		      	<button type="button" class="btn btn-outline-success" id="emailUpdateCheck">인증번호 확인</button>
		      	<span class="check-no" >불일치</span>
				<span class="check-yes" >일치</span>
				<input type="hidden" id="email-ok" value="1" />
		      </div>
		      <div class="modal-footer">
		        <button type="submit" class="btn btn-outline-success">변경</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>
		<!-- 이메일 변경 팝업창 끝 -->
			
			<script>
				$(function(){
					$("#newPwdCheck").on("keyup",function(){
						var p1 = $("#newPwd").val();
						var p2 = $(this).val();
						console.log(p1);
						console.log(p2);
						if(p1==p2){
							//console.log("일치");
							$(".check-no").hide();
							$(".check-yes").show();
							$("#pwd-ok").val(0);
						}else{
							//console.log("불일치");
							$(".check-yes").hide();
							$(".check-no").show();
							$("#pwd-ok").val(1);
							
						}
					});
					
					//파일을 변경하거나 변경하지 않을 경우의 로직
					$("#submit").click(function(){
						if($("#post-file").val()==""){
							console.log("pre");
						}else{
							console.log("post");
							$("input[name=post-file]").attr("name","mprofile");
						}
					});
					
					//이메일 변경
					$("[type=button]#emailUpdate").click(function(){
						var newEmail = $("#newEmail").val().trim();
						console.log("확인");
						if($("#send").val()=="keySend"){
							console.log("확인"+$("#send").val());
							$.ajax({
								url: "newEmailKey.do",
								data: {newEmail: newEmail},
								dataType: "json",
								success: function(data){
									console.log(data);
									if(data.isUsable==true){
										//console.log(data.tempPwd);
										$("#keyCheck").val(data.tempPwd);
									}else{
										
									}
									
								},
								error: function(jqxhr, textStatus, errorThrown){
									console.log("ajax실패",jqxhr, textStatus, errorThrown);
								}
								
							});
							
						}
					});
					
					$("#emailUpdateCheck").click(function(){
						var key = $("#keyCheck").val();
						var inputKey = $("#key").val();
						
						if(key==inputKey){
							console.log("이메일 인증키 일치!");
							$(".check-no").hide();
							$(".check-yes").show();
							$("#email-ok").val(0);
						}else{
							console.log("이메일 인증키 불일치!");		
							$(".check-yes").hide();
							$(".check-no").show();
							$("#email-ok").val(1);
						}
						
						
					});
					
					
				});
				function pwdDuplicateCheck(){
					var po = $("#pwd-ok").val();
					if(po=="1"){
						console.log("ok");
						alert("비밀번호가 불일치합니다.");
						return false;
					}
					
					return true;
				}
				function emailDuplicateCheck(){
					var po = $("#email-ok").val();
					if(po=="1"){
						console.log("ok");
						alert("인증키가 불일치 합니다.");
						return false;
					}
					
					return true;
				}
				
			</script>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	