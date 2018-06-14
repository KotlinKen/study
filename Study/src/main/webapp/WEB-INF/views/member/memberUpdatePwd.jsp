<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
		<jsp:param value="" name="pageTitle"/>
	</jsp:include>
	<form action="${pageContext.request.contextPath }/member/memberUpdatePwd.do" method="post">
		새 비밀번호 : <input type="text" name="pwd" id="pwd" />
		새 비밀번호 확인 : <input type="text" id="pwd-check" />
		<input type="hidden" name="key" value="${key }" />
		<input type="hidden" name="mid" value="${mid }" />
		<button type="submit">변경</button>
	</form>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	