<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js" ></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>	 --%>
<style>
div.forCopy{
	display:none;
}

</style>
<script>
function validate(){
	// time만들기.
	   var starttime = $("select#starttime option:checked").val();
	   var endtime = $("select#endtime option:checked").val();   
	   
	   $("input#time").val(starttime + "~" + endtime);
	
	
	return true;
}
$(function(){
	
	
	
	//첨부파일 선택하면 파일 이름이 input창에 나타나게한다.
	//첨부파일이름 표시
	$("[name=upFile]").on("change",function(){
		//var fileName= $(this).val();
		var fileName= $(this).prop("files")[0].name;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
	//local 지역 리스트를 가져와 select 만듦. 
	 $.ajax({
		url:"selectLocal.do",
		dataType:"json",
		success:function(data){
			
			var html="<option>선택하세요</option>";
			for(var index in data){
				//console.log(data[index]);
				html +="<option value='"+data[index].LNO+"'>"+data[index].LOCAL1+"</option><br/>";
			}
			$("select#local").html(html);
			
			
		},error:function(){
			
		}
	}); 
	
	//local 선택하면 town 리스트 가져와 select 만듦. 
	//on(change) event, ajax event
	 $("select#local").on("change",function(){
		 var lno=$("select#local option:selected").val();
		 console.log(lno);
		$.ajax({
			url:"selectTown.do",
			dataType:"json",
			data:{lno:lno},
			success:function(data){
				
				var html="";
				for(var index in data){
					html +="<option value='"+data[index].TNO+"'>"+data[index].NAME+"</option><br/>";
				}
				$("select#town").html(html);
				
			},error:function(){
				
			}
		});
	});
	 
	//subject 리스트를 가져와 select 만듦. 프로그래밍, 회화, 운동 등등..
	 $.ajax({
		url:"selectSubject.do",
		dataType:"json",
		success:function(data){
			var html="<option>선택하세요</option>";
			for(var index in data){
				html +="<option value='"+data[index].SUBNO+"'>"+data[index].NAME+"</option><br/>";
			}
			$("select#subject").html(html);
			
		},error:function(){
			
		}
	}); 
	
	
	//subject를 선택하면 해당하는 과목들을들을 가져와 리스트를 생성한다.
	 $("select#subject").on("change",function(){
		$.ajax({
			url:"selectKind.do",
			dataType:"json",
			data:{subno:$("select#subject option:selected").val()},
			success:function(data){
				var html="";
				for(var index in data){
					html +="<option value='"+data[index].KNO+"'>"+data[index].NAME+"</option><br/>";
				}
				$("select#kind").html(html);
				
			},error:function(){
				
			}
		});
	});
	
	//diff(난이도) 리스트를 가져와 select 만듦.
	 $.ajax({
		url:"selectLv.do",
		dataType:"json",
		success:function(data){
			var html="";
			for(var index in data){
				html +="<option value='"+data[index].DNO+"'>"+data[index].NAME+"</option><br/>";
			}
			$("select#dno").html(html);
			
		},error:function(){
			
		}
	}); 
	
	
	//첨부파일 + 버튼 클릭시 첨부파일창이 밑에 더 생긴다.
	$("form[name=studyFrm]").on("click","button.addFile",function(){
		console.log("adddd");
		if($("div.fileWrapper").length<10){
			$("div.fileWrapper:last").after($("div.forCopy").clone().removeClass("forCopy").addClass("fileWrapper"));
		}
			
	});
	
	//첨부파일 - 버튼 클릭시  해당 첨부파일 영역이 사라진다.
	$("form[name=studyFrm]").on("click","button.removeFile",function(){
		console.log($("div.fileWrapper:eq(0)"));
		if( $(this).parent("div.fileWrapper")[0]!==$("div.fileWrapper:eq(0)")[0]){ //맨첫번째 첨부파일은 삭제이벤트 발생안함.
			$(this).parent("div.fileWrapper").remove();
		}
	});
	
	
});

</script>
<div id="study-container">
	<form action="studyFormEnd.do" name="studyFrm" method="post" onsubmit="return validate();" enctype="multipart/form-data">
	
		<label for="local">지역 : </label>
		<select name="lno" id="local">
		</select>
		<select name="tno" id="town">
		</select>	
		<label for="title">스터디 제목 : </label><input type="text" name="title" id="title" placeholder="제목" class="form-control" required /><br />
		<label for="content">스터디 내용 : </label><textarea name="content" id="content" cols="30" rows="10" placeholder="내용을 입력해주세요" class="form-control"></textarea><br />
		<label for="depart">카테고리</label>
		<select name="subject" id="subject"> <!-- kind선택시 ajax로 그에 맞는 과목 가져오기 -->
		</select>
		<select name="kno" id="kind"> <!-- ajax로 kind가져오기 -->
		</select>&nbsp;&nbsp;&nbsp;<label for="diff">난이도 : </label>
		<select name="dno" id="dno">
			<option value="1">입문</option>
		</select><br />
		<label for="ldate">신청마감 : </label><input type="date" name="ldate" id="ldate" />
		<label for="schedule">스터디 일정 : </label><input type="date" name="sdate" id="sdate" />~<input type="date" name="edate" id="edate" /><br />
		<label for="freq">스터디빈도 : </label>
		<label>월 </label><input type="checkbox" name="freq" id="" value="월"/>
		<label>화 </label><input type="checkbox" name="freq" id="" value="화"/>
		<label>수 </label><input type="checkbox" name="freq" id="" value="수"/>
		<label>목 </label><input type="checkbox" name="freq" id="" value="목"/>
		<label>금 </label><input type="checkbox" name="freq" id="" value="금"/>
		<label>토 </label><input type="checkbox" name="freq" id="" value="토"/>
		<label>일 </label><input type="checkbox" name="freq" id="" value="일"/> 
		
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
		</select><br />
		<input type="hidden" name="time" id="time"/>
		<label for="price">일회 사용회비 : </label><input type="text" name="price" id="price" class="form-control" placeholder="협의 - 스터디 카페 대여비 - 6000원" />
		<br />
		<label for="recruit">모집 인원 : </label>
		<select name="recruit" id="recruit">
			<c:forEach var="i" begin="2" end="10">
			<option value="${i }">${i }명</option>
			</c:forEach>
		</select><br />
		<!-- 자기소개는 멤버의 자기소개의 것을 불러오고 저장하면 그것을 멤버에서 또 수정함~ -->
		<!-- <label for="cover">자기소개 : </label><textarea name="cover" id="cover" cols="30" rows="10" class="form-control" placeholder="자기소개 및 특이사항을 작성해주세요"></textarea><br /> --> 
		<label for="etc">기타 : </label><textarea name="etc" id="etc" cols="30" rows="10" class="form-control"></textarea><br /> 
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
