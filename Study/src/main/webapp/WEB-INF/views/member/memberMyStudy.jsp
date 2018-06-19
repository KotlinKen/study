<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
		<jsp:param value="내 스터디 목록" name="pageTitle"/>
	</jsp:include>
	<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp" />
	내 스터디
	<p>총 ${count }의 스터디 신청 건이 있습니다.</p> <!--  스터디 가져올 경우 기간 마감된 것도 표시해줌. -->
	<table>
		<tr>
			<th>번호</th>
			<th>강의/스터디명</th>
			<th>아이디</th>
			<th>팀장/강사명</th>
			<th>수업일정</th>
			<th>스터디 시간</th> <!-- 18/5/6 ~ 18/6/6(시간) -->
			<th>보기</th>
		</tr>
		<c:forEach var="ms" items="${myStudyList}" varStatus="vs" >
			<tr>
				<td>${vs.index }</td>
				<td>${ms.title }</td>
				<td>${ms.mid}</td>
				<td>${ms.captain}</td>
				<td>${ms.freq}</td>
				<td>${ms.sdate} ~ ${ms.edate}(${ms.time })</td>
				<td>
					<button type=button>자세히</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	<br />
	<!-- 페이지바 -->
	<%
		int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("count")));
		int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
		int cPage = 1;
		try{
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e){
			
		}
	%>
	<%=com.pure.study.common.util.Utils.getPageBar(totalContents, cPage, numPerPage,"memberMyStudyList.do") %>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	