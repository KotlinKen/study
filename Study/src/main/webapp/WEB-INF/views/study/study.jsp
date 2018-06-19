<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js" ></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<!-- 사용자작성 css -->
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	 --%>
<div id="studylist-container">
	
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/study/studyForm.do'">스터디 작성</button>
		<!-- <form action="searchStudy.do" name="filterFrm" id="filterFrm" method="post"> -->
		<div id="study-search">
			<label for="local">지역:</label>
			<select name="lno" id="local">
			<option value="0">전체</option>
			<c:forEach var="local" items="${localList }">
				<option value="${local.LNO }">${local.LOCAL1 }</option>
			</c:forEach>
			</select>&nbsp;
			<select name="tno" id="town">
			<option value="0">지역을 선택하세요</option>
			</select>
			<label for="subject">카테고리 :</label>
			<select name="subno" id="subject">
			<option value="0">전체</option>
			<c:forEach var="sub" items="${subjectList }">
				<option value="${sub.SUBNO }">${sub.NAME }</option>
			</c:forEach>
			</select>
			<select name="kno" id="kind">
			<option value="0">카테고리를 선택하세요</option>
			</select>&nbsp;
			<label for="diff">난이도 : </label>
			<select name="dno" id="diff">
			<option value="0">전체</option>
			<c:forEach var="diff" items="${diffList }">
				<option value="${diff.DNO }">${diff.NAME }</option>
			</c:forEach>
			</select>
			<input type="text" name="leadername" id="leadername" placeholder="팀장명을 적어주세요" />
			<input type="button" id="filterSearch" value="필터 검색" />
			
		</div>
			
	
		<button type="button" id="sort-deadline">마감임박순</button>
		<button type="button" id="sort-deadline">인기스터디순</button>
		
		<hr />
		<div id="study-list">
			 <%-- <c:forEach var="study" items="${list}">
			 	<div class="studyone">
			 		<span>신청기간 :~ ${study.LDATE} </span><br />
			 		<span>${study.LNAME}-${study.TNAME} │ ${study.DNAME}</span><br />
			 		<span>${study.SUBNAME }/${study.KNAME }</span>
			 		<span>${study.TITLE }</span><br />
			 		<span>${study.SDATE }~${study.EDATE }</span><br />
			 		<span>${study.PROFILE }</span> <!-- 팀장사진 <--><br /></-->
			 		<span>${study.UPFILE }<!-- 스터디 사진 하나만 가져와서 set --></span><br />
			 		<span>${study.STATUS }</span>
			 		<input type="hidden" id="studyNo" value="${study.SNO }" /> 
			 	</div>
			 </c:forEach> --%>
		
		</div>
	
	
	<input type="hidden" name="case" value="0" /> <!-- 조건없이 리스트를 가져오나, 조건있이 리스트를 가져오나 여부. 임시방편. -->
	<!-- <input type="hidden" name="cPageNo" value="1"/>cPage 번호 저장. -->


</div>
<script>
$(function(){
	console.log("cPage="+${cPage});
	console.log("numPerPage="+${numPerPage}); 
	
	$.ajax({
		url:"selectStudyList.do",
		dataType:"html",
		success:function(data){
			$("div#study-list").html(data);
		},error:function(){
			
		}
	});
	
	$("div#study-list").on("click","div.studyone",function(){
		console.log("되나");
		location.href="${pageContext.request.contextPath}/study/studyView?sno="+$(this).children("input").val();
	});//스터디를 클릭하면..
	
	
	$("input#filterSearch").on("click",function(){
		var filter={lno:$("select#local option:selected").val(),tno:$("select#town option:selected").val(),
				subno:$("select#subject option:selected").val(),kno:$("select#kind option:selected").val(),
				dno:$("select#diff option:selected").val(),leadername:$("input#leadername").val(),cPage:1};
		$("input[name=case]").val(1); //검색인 경우 case 설정
		$.ajax({
			url:"searchStudy.do",
			data:filter,
			dataType:"html",
			success:function(data){
				
				/* var html="<div class='studyone'>";
	        	for(index in data){
	        		html+="<span class='studyinfo'>신청기간 : ~"+data[index].LDATE+"</span><br/>";
	        		html+="<span class='studyinfo'>"+data[index].LNAME+"-"+data[index].TNAME+data[index].DNAME+"</span><br/>";
	        		html+="<span class='studyinfo'>"+data[index].SUBNAME+ data[index].KNAME+"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].TITLE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].SDATE+"~"+data[index].EDATE+"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].PROFILE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].UPFILE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].STATUS +"</span><br/>";
	        		
	        		
	        	}
	        	html+="</div>"; */
	        	$("div#study-list").html(data);
			},error:function(){
				
			}
		});
	});
	
	//무한 스크롤.
	//내려갈 때 계속 해당하는 스터디 리스트가 나옴
	//내용이 없을 때도 내려가는데 그건 어떻게 막지? --나중 우선순위
	 $(document).scroll(function() {
	    var maxHeight = $(document).height();
	    var currentScroll = $(window).scrollTop() + $(window).height();
	    var urlPath="";
		var cPage=Number($("input[name=cPageNo]").val());
	    if($("input[name=case]").val()==0) urlPath="studyListAdd.do";
		else urlPath="searchStudyAdd.do";
		console.log("cPage="+cPage);
		var isPage=Math.floor(8/${numPerPage})+1;
		console.log("isPage="+isPage);
	    if (maxHeight <= currentScroll+100 &&cPage<=isPage) {
	      $.ajax({
	        url:urlPath,
	        dataType:"json",
	        data:{cPage:cPage,total:8,numPerPage:${numPerPage}},
	        success:function(data){
	        	console.log(data);
	        	var html="<div class='studyone'>";
	        	for(index in data){
	        		html+="<span class='studyinfo'>신청기간 : ~"+data[index].LDATE+"</span><br/>";
	        		html+="<span class='studyinfo'>"+data[index].LNAME+"-"+data[index].TNAME+data[index].DNAME+"</span><br/>";
	        		html+="<span class='studyinfo'>"+data[index].SUBNAME+ data[index].KNAME+"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].TITLE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].SDATE+"~"+data[index].EDATE+"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].PROFILE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].UPFILE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data[index].STATUS +"</span><br/>";
	        		
	        		
	        	}
	        	html+="</div>";
	        	$("div#study-list").append(html);
	        },error:function(){
	        	
	        }
	       
	      });
	      $("input[name=cPageNo]").val(cPage+Number(1));
	    }
	 }); 
});


</script>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/>	 --%>
