<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	 --%>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/study/studyForm.do'">스터디 작성</button>
<div id="studylist-container">
	<form action="searchStudy.do" name="filterFrm" id="filterFrm" method="post">
	
	</form>
	
	<div id="studylist">
		<ul>
		 <c:forEach var="study" items="${list }" >
		 	<li>${study.SNO } ${study.TNO } ${study.LNO } ${study.MNO }  제목 : ${study.TITLE } 내용 : ${study.CONTENT } </li>
		 </c:forEach>
		</ul>
	</div>
</div>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/>	 --%>
