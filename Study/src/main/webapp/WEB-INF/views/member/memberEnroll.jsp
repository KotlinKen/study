<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
	div#enroll-container{
		margin-left: 30%;
		margin-right: 30%;
	}
</style>
	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
		<jsp:param value="회원가입 페이지" name="pageTitle"/>
	</jsp:include>
	<div id="enroll-container">
	
	<form action="memberEnrollEnd.do" 
		  method="post"
		  onsubmit="return validate();">
		<input type="text" 
			   class="form-control" 
			   name="mid" 
			   id="mid_"
			   placeholder="아이디" required/>
		<br />
		<input type="password" 
			   class="form-control" 
			   name="pwd" 
			   id="pwd_"
			   placeholder="패스워드" required/>
		<br />
		<input type="password" 
			   class="form-control" 
			   id="pwd2"
			   placeholder="패스워드확인" required/>
		<br />
		<input type="text" 
			   class="form-control" 
			   name="mname" 
			   id="mname"
			   placeholder="이름" required/>
		<br />
		<input type="text" 
			   class="form-control" 
			   name="phone" 
			   id="phone"
			   placeholder="연락처" required/>
		<br />
		<input type="text" 
			   class="form-control" 
			   name="addr" 
			   id="addr"
			   placeholder="주소" required/>
		<br />
		
		<input type="email" 
			   class="form-control" 
			   name="email" 
			   id="email"
			   placeholder="이메일" required/>
		<br />
		생년월일 : 
		<input type="date" 
				class="form-control"  
				name="birth" 
				id="birth" required/>
		<hr />
		<input type="file" 
			   class="form-control" 
			   name="mprofile" 
			   id="mprofile"
			   placeholder="프로필" required/>
		<select name="gender" 
				id="gender"
				class="form-control" required>
			<option value="" disabled selected>성별</option>
			<option value="M">남</option>
			<option value="F">여</option>
		</select>
		<div class="form-check-inline form-check">
			관심사 : &nbsp;
			<c:forEach var="d" items="${departList}" varStatus="vs">
				<input type="checkbox" value="${d.DNAME }"
				   class="form-check-input" 
				   name="favor" id="favor${vs.index} " />
			<label for="favor${vs.index }" 
				   class="form-check-label" >${d.DNAME }</label>
			&nbsp;
			</c:forEach>
		</div>
		<br />
		
		자기 소개 : 
		<textarea class="form-control" name="cover" cols="30" rows="10" placeholder="자기소개 및 특이 사항" required></textarea>
		<br/>
		<input type="submit" value="가입" 
			   class="btn btn-outline-success" /> 
	</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	