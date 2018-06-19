<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
	table, th, td, tr{
		border: 2px solid black;
	}
</style>

	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
		<jsp:param value="내 신청 목록" name="pageTitle"/>
	</jsp:include>
	<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp"/>
	<p>총 ${count }의 스터디 신청 건이 있습니다.</p> <!-- 스터디 가져올 경우 기간 마감된 것도 표시해줌. -->
	<table>
		<tr>
			<th>번호</th>
			<th>강의/스터디명</th>
			<th>팀장/강사명</th>
			<th>분류</th>
			<th>과목</th>
			<th>스터디 장소</th>
			<th>난이도</th>
			<th>수업일정(주기)</th>
			<th>스터디 기간 및 시간</th> <!-- 18/5/6 ~ 18/6/6(시간) -->			
			<th>상태</th>
			<th>신청인원</th>
			<th>신청마감</th>
			<th>신청일</th>
			<th>보기</th>
		</tr>
		<c:forEach var="a" items="${applyList}" varStatus="vs" >
			<tr>
				<td>${vs.index+1 }</td>
				<td>${a.title }</td>
				<td>${a.captain}</td>
				<td>${a.type }</td>
				<td>${a.subject }</td>
				<td>${a.place}</td>
				<td>${a.diff}</td>
				<td>${a.freq}</td>
				<td>${a.sdate} ~ ${a.edate}(${a.time })</td>
				<td>${a.status}</td>
				<td>${a.applycnt} / ${a.recruit}</td>
				<td>${a.ldate}</td>
				<td>${a.adate}</td>
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
	<%=com.pure.study.common.util.Utils.getPageBar(totalContents, cPage, numPerPage,"memberApplyList.do") %>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	