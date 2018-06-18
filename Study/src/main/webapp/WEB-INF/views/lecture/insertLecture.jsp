<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
div.forCopy{
	display:none;
}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script>
function validate(){	
	// time만들기.
	var startTime = $("#startTime option:checked").val();
	var endTime = $("#endtime option:checked").val();	
	
	$("#time").val(startTime + "~" + endTime);
	
	return true;
}
$(function(){
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
	
	//첨부파일 선택하면 파일 이름이 input창에 나타나게한다.
	//첨부파일이름 표시
	$("[name=upFile]").on("change",function(){
		//var fileName= $(this).val();
		var fileName= $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});	
	
	//첨부파일 + 버튼 클릭시 첨부파일창이 밑에 더 생긴다.
	$("form[name=lectureFrm]").on("click","button.addFile",function(){
		console.log("adddd");
		if($("div.fileWrapper").length<10){
			$("div.fileWrapper:last").after($("div.forCopy").clone().removeClass("forCopy").addClass("fileWrapper"));
		}
			
	});
	
	//첨부파일 - 버튼 클릭시  해당 첨부파일 영역이 사라진다.
	$("form[name=lectureFrm]").on("click","button.removeFile",function(){
		console.log($("div.fileWrapper:eq(0)"));
		if( $(this).parent("div.fileWrapper")[0]!==$("div.fileWrapper:eq(0)")[0]){ //맨첫번째 첨부파일은 삭제이벤트 발생안함.
			$(this).parent("div.fileWrapper").remove();
		}
	});	
});

</script>
<div id="lecture-container">
	<form action="lectureFormEnd.do" name="lectureFrm" method="post" onsubmit="return validate();" enctype="multipart/form-data">
	
	<!-- 지역 -->
	<label for="local">지역 : </label>
	<select name="local" id="local">
		<option value="" selected>지역</option>
		<c:if test="${!empty locList}">
			<c:forEach var="loc" items="${locList }" varStatus="vs">
				<option value="${loc.LNO }">${loc.LOCAL1 }</option>
			</c:forEach>		
		</c:if>
	</select>
	
	<!-- 시,군,구 -->
	<select name="tno" id="town">
	
	</select>	
	<!-- 지역 end -->	
	
	<label for="title">스터디 제목 : </label><input type="text" name="title" id="title" placeholder="제목" class="form-control" required /><br />
	<label for="content">스터디 내용 : </label><textarea name="content" id="content" cols="30" rows="10" placeholder="내용을 입력해주세요" class="form-control"></textarea><br />

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
	&nbsp;&nbsp;&nbsp;
	
	<label for="diff">난이도 : </label>
	<select name="dno" id="diff">
		<option value="">난이도를 선택하세요</option>
		
		<c:if test="${!empty diffList }">
		<c:forEach var="diff" items="${diffList }" varStatus="vs">
			<option value="${diff.DNO }">${diff.NAME }</option>
		</c:forEach>
		</c:if>
	</select>
	<br />
	
	<label for="ldate">신청마감 : </label><input type="date" name="ldate" id="ldate" />
	<label for="schedule">스터디 일정 : </label><input type="date" name="sdate" id="sdate" />~<input type="date" name="edate" id="edate" /><br />

	<label for="freq">스터디빈도 : </label>
    <label>월 </label><input type="checkbox" name="freqs" value="월" />
    <label>화 </label><input type="checkbox" name="freqs" value="화" />
    <label>수 </label><input type="checkbox" name="freqs" value="수" />
    <label>목 </label><input type="checkbox" name="freqs" value="목" />
    <label>금 </label><input type="checkbox" name="freqs" value="금" />
    <label>토 </label><input type="checkbox" name="freqs" value="토" />
    <label>일 </label><input type="checkbox" name="freqs" value="일" /> 
	    
	<label for="starttime">스터디 시간</label>
	<select name="starttime" id="starttime">
		<c:forEach var="i" begin="6" end="23">
		<option value="${i }:00">${i }:00</option>
		
		</c:forEach>
	</select>
	<select name="endtime" id="endtime">
		<c:forEach var="j" begin="7" end="24">
			<option value="${j }:00">${j }:00</option>		
		</c:forEach>
	</select>
	
	<input type="hidden" name="time" id="time" />
	<br />
	
	<label for="price">일회 사용회비 : </label><input type="text" name="price" id="price" class="form-control" placeholder="협의 - 스터디 카페 대여비 - 6000원" />
	<br />
	
	<label for="recruit">모집 인원 : </label>
	<select name="recruit" id="recruit">
		<c:forEach var="i" begin="2" end="10">
		<option value="${i }">${i }명</option>
		</c:forEach>
	</select>
	<br />
	
	<label for="cover">자기소개 : </label>
	<textarea name="cover" id="cover" cols="30" rows="10" class="form-control" placeholder="자기소개 및 특이사항을 작성해주세요"></textarea>
	<br /> 
	
	<label for="etc">기타 : </label>
	<textarea name="etc" id="etc" cols="30" rows="10" class="form-control"></textarea>
	<br /> 
	
	<div class="input-group mb-3 fileWrapper" style="padding:0px">
		  <div class="input-group-prepend" style="padding:0px">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="upFile1" name="upFile">
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		  <button type="button" class="addFile">+</button>
		  <button type="button" class="removeFile">-</button>
	</div>
	<div class="input-group mb-3 forCopy" style="padding:0px">
		  <div class="input-group-prepend" style="padding:0px">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="upFile1" name="upFile">
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		  <button type="button" class="addFile">+</button>
		  <button type="button" class="removeFile">-</button>
	</div>
	
	<input type="reset" value="취소하기" />
	<input type="submit" value="등록하기" />
	</form>
	
</div>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/>	 --%>
