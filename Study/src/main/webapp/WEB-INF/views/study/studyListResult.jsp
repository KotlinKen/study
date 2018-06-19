<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	 --%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js" ></script>
 <c:forEach var="study" items="${list}">
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
</c:forEach>
<input type="hidden" name="cPage-basic" value="${cPage}" />
<!-- <script>
$(document).scroll(function(e) {
	console.log("input"+$("input[name=case]").val());
	
    var maxHeight = $(document).height();
    var currentScroll = $(window).scrollTop() + $(window).height();
	var cPage=Number($("input[name=cPage-basic]").val());
 
	console.log("cPage="+cPage);
	var isPage=Math.floor(${total}/${numPerPage})+1;
	console.log("isPage="+isPage);
	var filter={lno:$("select#local option:selected").val(),tno:$("select#town option:selected").val(),
			subno:$("select#subject option:selected").val(),kno:$("select#kind option:selected").val(),
			dno:$("select#diff option:selected").val(),leadername:$("input#leadername").val()};
	
	if($("input[name=case]").val()==0){
		console.log("그냥리스트 추가 되고이다");
		if (maxHeight <= currentScroll+100 &&cPage<=isPage) {
		      $.ajax({
		        url:"studyListAdd.do",
		        dataType:"json",
		        data:{cPage:cPage,numPerPage:${numPerPage}},
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
		        	$("input[name=cPage-basic]").val(cPage+Number(1));
		        	$("div#study-list").append(html);
		        },error:function(){
		        	
		        }
		       
		      });
		}
	}
		
    
    
 });
</script>
 -->
