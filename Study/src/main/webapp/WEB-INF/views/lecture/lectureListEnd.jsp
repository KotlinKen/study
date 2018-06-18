<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script>
	$(document).ready(function(){
		$("#town").hide();
		$("#kind").hide();
		
		// TOWN선택
		$("#local").on("change", 	function(){
			var localNo = $("option:selected", this).val();
			
			if(localNo == ""){
				$("#town").hide();
				return;
			}
			$("#town").show();

			$.ajax({
				url: "selectTown.do",
				data: {localNo : localNo},
				dataType: "json",
				success : function(data){
					var html="<option>세부 지역을 선택하세요</option>";
					
					for(var index in data){
						html += "<option value='"+data[index].TNO +"'>" + data[index].NAME + "</option></br>";
					}				
					$("#town").html(html);
				}			
			});
		});
		
		// 세부 과목 선택
		$("#subject").on("change", 	function(){
			var subNo = $("option:selected", this).val();
			
			if(subNo == ""){
				$("#kind").hide();
				return;
			}
			$("#kind").show();

			$.ajax({
				url: "selectKind.do",
				data: {subNo : subNo},
				dataType: "json",
				success : function(data){
					var html="<option>세부 과목을 선택하세요</option>";
					
					for(var index in data){
						html += "<option value='"+data[index].KNO +"'>" + data[index].NAME + "</option></br>";
					}
					
					$("#kind").html(html);
				}			
			});
		});
	});
</script>
<body>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/lecture/insertLecture.do'">강의
	작성</button>
	<div id="lectureList-container">	
		<!-- 지역 -->
		<label for="local">지역 : </label>
		<select name="local" id="local">
			<option value="" selected>지역</option>
			<c:if test="${!empty locList}">
				<c:forEach var="loc" items="${locList }" varStatus="vs">
					<option value="${loc.LNO }">${loc.LOCAL1 }</option>
				</c:forEach>		
			</c:if>
		</select>	<%-- 
		<label for="local">지역:</label> 
		<select name="lno" id="local">
			<c:forEach var="local" items="${locList }">
				<option value="${local.LNO }">${local.LOCAL1 }</option>
			</c:forEach>
		</select> --%>
		&nbsp; 
		
		<select name="tno" id="town">
		</select> 
		
		<!-- 카테고리 -->
		<label for="subject">카테고리</label>
		<select name="subject" id="subject"> <!-- kind선택시 ajax로 그에 맞는 과목 가져오기 -->
			<option value="">과목을 선택하세요.</option>
			<c:if test="${!empty subjectList }">
			<c:forEach var="sub" items="${subjectList }" varStatus="vs">
				<option value="${sub.SUBNO }">${sub.NAEM }</option>
			</c:forEach>
			</c:if>
		</select>
		
		<select name="kno" id="kind"> <!-- ajax로 kind가져오기 -->
		<!-- 카테고리 end -->
		</select>
		&nbsp; 		
		
		<label for="diff">난이도 : </label>
		<select name="dno" id="diff">
			<option value="">난이도를 선택하세요</option>
			
			<c:if test="${!empty diffList }">
			<c:forEach var="diff" items="${diffList }" varStatus="vs">
				<option value="${diff.DNO }">${diff.NAME }</option>
			</c:forEach>
			</c:if>
		</select>
		
		<input type="text" name="leadername" id="leadername" placeholder="팀장명을 적어주세요" /> 
		<input type="submit" value="필터 검색" />

	
		<button type="button" id="sort-deadline">마감임박순</button>
		<button type="button" id="sort-deadline">인기스터디순</button>
	
		<hr />
		
		<div id="lecture-container">
	
		</div>
	</div>

	<input type="hidden" name="case" value="0" />
	<!-- 조건없이 리스트를 가져오나, 조건있이 리스트를 가져오나 여부. 임시방편. -->
	<input type="hidden" name="cPageNo" value="2" />
	<!-- cPage 번호 저장. -->
	
	<c:if test="${!empty lectureList }">
		<table>
			<tr>
				<th></th>
				<th>지역</th>
				<th>분야</th>
				<th>과목</th>
				<th>비용</th>
				<th>상태</th>
				<th>모집일</th>
				<th>운영일</th>
				<th>운영시간</th>
				<th>작성자</th>
				<th>등록일</th>
			</tr>
			
			<c:forEach var="lecture" items="${lectureList}" varStatus="vs">
				<div class="lecture">
					<tr>
						<td>${vs.index+1}</td>
						<td>${lecture.LOCAL} ${lecture.TNAME}</td>
						<td>${lecture.SUBNAME}</td>
						<td>${lecture.KNAME}</td>
						<td>${lecture.PRICE}원</td>
						<td>${lecture.STATUS }</td>
						<td>${lecture.LDATE }</td>
						<td>
							<fmt:parseDate value="${lecture.SDATE}" type="date" var="sdate" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${sdate }" pattern="yyyy/MM/dd"/> 
							~ 
							<fmt:parseDate value="${lecture.EDATE}" type="date" var="edate" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${edate }" pattern="yyyy/MM/dd"/>
						</td>
						<td>${lecture.TIME }</td>
						<td>${lecture.MNAME }</td>
						<td>${lecture.REGDATE }</td>
					</tr>			
				</div>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>