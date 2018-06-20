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
				<option value="${local.LNO }">${local.LOCAL }</option>
			</c:forEach>
			</select>&nbsp;
			<select name="tno" id="town">
			<option value="0">지역을 선택하세요</option>
			</select>
			<label for="subject">카테고리 :</label>
			<select name="kno" id="kind">
			<option value="0">전체</option>
			<c:forEach var="k" items="${kindList }">
				<option value="${k.KNO }">${k.KINDNAME }</option>
			</c:forEach>
			</select>&nbsp;
			<select name="subno" id="subject">
			<option value="0">카테고리를 선택하세요</option>
		
			</select>
			
			<label for="diff">난이도 : </label>
			<select name="dno" id="diff">
			<option value="0">전체</option>
			<c:forEach var="diff" items="${diffList }">
				<option value="${diff.DNO }">${diff.DIFFICULTNAME }</option>
			</c:forEach>
			</select>
			<input type="text" name="leadername" id="leadername" placeholder="팀장명을 적어주세요" />
			<input type="button" id="filterSearch" value="필터 검색" />
			
		</div>
			
	
		<button type="button" id="sort-deadline">마감임박순</button>
		<button type="button" id="sort-deadline">인기스터디순</button>
		
		<hr />
		<div id="study-list">
		
		</div>
	
	<input type="hidden" id="cPageNo" value="1" />
	<input type="hidden" id="total" value="0" />
	<input type="hidden" id="numPerPage" />
	<input type="hidden" name="case" value="none" /> <!-- 조건없이 리스트를 가져오나, 조건있이 리스트를 가져오나 여부. 임시방편. -->
	<!-- <input type="hidden" name="cPageNo" value="1"/>cPage 번호 저장. -->
	
	

</div>
<script>
$(function(){
	
	
	$.ajax({
		url:"selectStudyList.do",
		dataType:"json",
		success:function(data){
			$("input#total").val(data.total);
			$("input#numPerPage").val(data.numPerPage);
			$("input#cPageNo").val(data.cPage);
			var html="";
        	for(index in data.list){
        	    html+="<div class='studyone'>";
        		html+="<span class='studyinfo'>신청기간 : ~"+data.list[index].LDATE+"</span><br/>";
        		html+="<span class='studyinfo'>"+data.list[index].LNAME+"-"+data.list[index].TNAME+data.list[index].DNAME+"</span><br/>";
        		html+="<span class='studyinfo'>"+data.list[index].KNAME+ data.list[index].SUBNAME+"</span><br/>";
        		html+="<span class='studyinfo'>"+ data.list[index].TITLE +"</span><br/>";
        		html+="<span class='studyinfo'>"+ data.list[index].SDATE+"~"+data.list[index].EDATE+"</span><br/>";
        		html+="<span class='studyinfo'>"+ data.list[index].MPROFILE +"</span><br/>";
        		html+="<span class='studyinfo'>"+ data.list[index].UPFILE +"</span><br/>";
        		html+="<span class='studyinfo'>"+ data.list[index].STATUS +"</span><br/><hr>";
        		html
        		html+="</div>";
        	}
			$("div#study-list").html(html); 
		},error:function(){
			
		}
	});
	
	//카테고리를 선택하면 그에 맞는 과목들을 가져온다.
	$("select#kind").on("change",function(){
		var html="";
		if($(this).val()!="0"){
			$.ajax({
				url:"selectSubject.do",
				data:{kno:$(this).val()},
				dataType:"json",
				success:function(data){
					for(var index in data){
						html +="<option value='"+data[index].SUBNO+"'>"+data[index].SUBJECTNAME+"</option><br/>";
						$("select#subject").html(html);
					}
				}
			});
		}else{
			html ="<option value='0'>카테고리를 선택하세요</option><br/>";
			$("select#subject").html(html);
		}
	});
	
	//지역을 선택하면 그에 맞는 도시들을 가져온다.
	$("select#local").on("change",function(){
		var html="";
		if($(this).val()!="0"){
			$.ajax({
				url:"selectTown.do",
				data:{lno:$(this).val()},
				dataType:"json",
				success:function(data){
					for(var index in data){
						html +="<option value='"+data[index].TNO+"'>"+data[index].TOWNNAME+"</option><br/>";
						$("select#town").html(html);
					}
				}
			});
		}else{
			html ="<option value='0'>지역을 선택하세요</option><br/>";
			$("select#town").html(html);
		}
	});
	
	
	
	$("div#study-list").on("click","div.studyone",function(){
		console.log("되나");
		location.href="${pageContext.request.contextPath}/study/studyView.do?sno="+$(this).children("input").val();
	});//스터디를 클릭하면..
	
	
	//필터 조건 정하고 검색 버튼을 누른 이벤트
	$("input#filterSearch").on("click",function(){
		var filter={lno:$("select#local option:selected").val(),tno:$("select#town option:selected").val(),
				subno:$("select#subject option:selected").val(),kno:$("select#kind option:selected").val(),
				dno:$("select#diff option:selected").val(),leadername:$("input#leadername").val(),cPage:1};
		
		$("input[name=case]").val("search"); //검색인 경우 case 설정
		
		$.ajax({
			url:"searchStudy.do",
			data:filter,
			dataType:"json",
			success:function(data){
				console.log(data);
			 	
				var html="";
	        	for(index in data.list){
	        		html+="<div class='studyone'>";
	        		html+="<span class='studyinfo'>신청기간 : ~"+data.list[index].LDATE+"</span><br/>";
	        		html+="<span class='studyinfo'>"+data.list[index].LNAME+"-"+data.list[index].TNAME+data.list[index].DNAME+"</span><br/>";
	        		html+="<span class='studyinfo'>"+data.list[index].SUBNAME+ data.list[index].KNAME+"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data.list[index].TITLE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data.list[index].SDATE+"~"+data.list[index].EDATE+"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data.list[index].MPROFILE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data.list[index].UPFILE +"</span><br/>";
	        		html+="<span class='studyinfo'>"+ data.list[index].STATUS +"</span><br/>";
	        		html+="<input type='hidden' value='"+data.list[index].SNO+"'/>";
	        		html+="</div>"; 
	        	} 
	        	
	         	
	        	$("div#study-list").html(html); 
	        	
	        	//새로 cPage 1로 설정
	        	$("input#cPageNo").val(data.cPage);
	        	$("input#total").val(data.total);
	        	
			},error:function(){
				
			}
		});
	});
	
	//무한 스크롤.
	//내려갈 때 계속 해당하는 스터디 리스트가 나옴
	//내용이 없을 때도 내려가는데 그건 어떻게 막지? --나중 우선순위
	
	var scrollTime=500;
	var timer = null;
	
	$(window).on('scroll',function(){
		var maxHeight = $(document).height();
	    var currentScroll = $(window).scrollTop() + $(window).height();
		if(maxHeight <= currentScroll-200){
			clearTimeout(timer);
			timer = setTimeout(listAddbyPaging,scrollTime);
		}
		
	});
	
	function listAddbyPaging(){
		console.log("페이징되어서 가져옴");
		
	    var urlPath="";
		var cPage=Number($("input#cPageNo").val());
		var total =Number($("input#total").val());
		var numPerPage= Number($("input#numPerPage").val());
		var listCase=$("input[name=case]").val();
		
		//아무 조건없이 페이징 하느냐, 있이 하느냐, 마감임박순으로 하느냐, 인기스터디 순으로 하느냐에 따라 분기.
	    if(listCase=="none"){
	    	urlPath="studyListAdd.do";
	    }else if(listCase=="search"){
	    	urlPath="searchStudyAdd.do";
	    }else if(listCase=="deadline"){
			urlPath="";	    	
	    }else{
	    	
	    } 
	    
		console.log("cPage="+cPage);
		var isPage=Math.floor(total/numPerPage)+1;
		console.log("isPage="+isPage);
		
		 //최대 가져올 수 있는 cPage 검사. 
		 if (cPage<=isPage) {
		      $.ajax({
		        url:urlPath,
		        dataType:"json",
		        data:{cPage:cPage,total:total,numPerPage:numPerPage},
		        success:function(data){
		        	console.log(data);
		        	var html="<div class='studyone'>";
		        	
		        	for(index in data.addList){
		        		html+="<span class='studyinfo'>신청기간 : ~"+data.addList[index].LDATE+"</span><br/>";
		        		html+="<span class='studyinfo'>"+data.addList[index].LNAME+"-"+data.addList[index].TNAME+data.addList[index].DNAME+"</span><br/>";
		        		html+="<span class='studyinfo'>"+data.addList[index].SUBNAME+ data.addList[index].KNAME+"</span><br/>";
		        		html+="<span class='studyinfo'>"+ data.addList[index].TITLE +"</span><br/>";
		        		html+="<span class='studyinfo'>"+ data.addList[index].SDATE+"~"+data.addList[index].EDATE+"</span><br/>";
		        		html+="<span class='studyinfo'>"+ data.addList[index].PROFILE +"</span><br/>";
		        		html+="<span class='studyinfo'>"+ data.addList[index].UPFILE +"</span><br/>";
		        		html+="<span class='studyinfo'>"+ data.addList[index].STATUS +"</span><br/>";
		        	}
		        	
		        	html+="</div>";
		        	$("input#cPageNo").val(data.cPage);
		        	$("div#study-list").append(html);
		        },error:function(){
		        	
		        }
		      });//ajax 끝
		  }//if문 끝
		
	}
});


</script>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/>	 --%>
