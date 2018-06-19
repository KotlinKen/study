<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
	table, tr, th, td{
		border: 2px solid black;
	}
</style>

	<jsp:include page="/WEB-INF/views/common/header.jsp"> 
		<jsp:param value="내 스터디 목록" name="pageTitle"/>
	</jsp:include>
	<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp" />
	<br />
	<select id="searchKwd">
		<option value="none" readonly>검색 키워드</option>
		<option value="title">강의/스터디명</option>
		<option value="captain">팀장/강사명</option>
		<option value="subject">과목</option>
		<option value="place">스터디 장소</option>
		<option value="diff">난이도</option>
		<option value="term">기간</option>
		<option value="freq">주기</option>
	</select>
	<form action="searchMyPageKwd.do" 
		  method="post" id="formSearch" onsubmit="return fn_search();">
		
		
	</form>
	<p>총 ${count }의 스터디 신청 건이 있습니다.</p> <!--  스터디 가져올 경우 기간 마감된 것도 표시해줌. -->
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
			<th>보기</th>
		</tr>
		<c:forEach var="ms" items="${myStudyList}" varStatus="vs" >
			<tr>
				<td>${vs.index+1 }</td>
				<td>${ms.title }</td>
				<td>${ms.captain}</td>
				<td>${ms.type }</td>
				<td>${ms.subject }</td>
				<td>${ms.place}</td>
				<td>${ms.diff}</td>
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
	
	<script>
		var exec = 0;
		$(function(){
			$("select#searchKwd").on("change",function(){
				var html = "";
				$("form#formSearch").empty();
				if($(this).val()=='title'){
					html="<input type='text' name='kwd' id='titleKwd' placeholder='강의/스터디명' />";
					html+="<input type='hidden' name='searchKwd' value='title' />";
					
					console.log('title');
				} 
				if($(this).val()=='captain'){
					html="<input type='text' name='kwd' id='captainKwd' placeholder='강사/팀장명' />";
					html+="<input type='hidden' name='searchKwd' value='captain' />";
					
					console.log('captain');
				} 
				if($(this).val()=='subject'){
					html="<select id='subjectKwd' name='kwd'>";
					
					console.log('subject');
				} 
				if($(this).val()=='place'){
					html="<select id='placeKwd' name='kwd'>";
					
					console.log('place');
				} 
				if($(this).val()=='diff'){
					html="<select id='diffKwd'>";
					
					console.log('diff');
				} 
				if($(this).val()=='term'){
					html="<input type='date' name='kwd' id='dateKwd' />";
					
					console.log('term');
				} 
				if($(this).val()=='freq'){
					html = "<input type='checkbox' name='kwd' id='freqKwd1' />";
					html += "<label for='freqKwd1'>월</label>";
					html += "<input type='checkbox' name='kwd' id='freqKwd2' />";
					html += "<label for='freqKwd2'>화</label>";
					html += "<input type='checkbox' name='kwd' id='freqKwd3' />";
					html += "<label for='freqKwd3'>수</label>";
					html += "<input type='checkbox' name='kwd' id='freqKwd4' />";
					html += "<label for='freqKwd4'>목</label>";
					html += "<input type='checkbox' name='kwd' id='freqKwd5' />";
					html += "<label for='freqKwd5'>금</label>";
					html += "<input type='checkbox' name='kwd' id='freqKwd6' />";
					html += "<label for='freqKwd6'>토</label>";
					html += "<input type='checkbox' name='kwd' id='freqKwd7' />";
					html += "<label for='freqKwd7'>일</label>";
					console.log('freq');
				}
				html+="<button type='submit' id='btn-search'>검색</button>";
				$("form#formSearch").html(html);
				
			});
		
			
		});
		function fn_search(){
			console.log($("#formSearch > input").val());
			var search = $("#formSearch > input").val();
			
			return true;
		}
	</script>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	