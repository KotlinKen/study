<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Map" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js" ></script>
<style>
div.forCopy{
	display:none;
}

</style>
<script>
$(function(){
	//local 지역 리스트를 가져와 select 만듦. 
	 $.ajax({
		url:"selectLocal.do",
		dataType:"json",
		success:function(data){
			
			var html="<option>선택하세요</option>";
			for(var index in data){
				//console.log(data[index]);
				html +="<option value='"+data[index].LNO+"'";
				if(${study.LNO}==data[index].LNO) html+="selected";
				html += ">"+data[index].LOCAL1+"</option><br/>";
			}
			$("select#local").html(html);
			
			
		},error:function(){
			
		}
	}); 
	
	
	$.ajax({
		url:"selectTown.do",
		data:{lno:${study.LNO}},
		dataType:"json",
		success:function(data){
			
			var html="";
			for(var index in data){
				html +="<option value='"+data[index].TNO+"'";
				if(${study.TNO}==data[index].TNO) html+="selected";
				html += ">"+data[index].NAME+"</option><br/>";
			}
			$("select#town").html(html);
			
		},error:function(){
			
		}
	});
	
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
				html +="<option value='"+data[index].SUBNO+"'";
				if(${study.SUBNO}==data[index].SUBNO) html+="selected";
				html+=">"+data[index].NAME+"</option><br/>";
			}
			$("select#subject").html(html);
			
		},error:function(){
			
		}
	}); 
	
	$.ajax({
		url:"selectKind.do",
		dataType:"json",
		data:{subno:${study.SUBNO}},
		success:function(data){
			var html="";
			for(var index in data){
				html +="<option value='"+data[index].KNO+"'";
				if(${study.KNO}==data[index].KNO) html+="selected";
				html += ">"+data[index].NAME+"</option><br/>";
			}
			$("select#kind").html(html);
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
				html +="<option value='"+data[index].DNO+"'";
				if(${study.DNO}==data[index].DNO) html+="selected";
				html+=">"+data[index].NAME+"</option><br/>";
			}
			$("select#dno").html(html);
			
		},error:function(){
			
		}
	}); 
	
	//첨부파일 + 버튼 클릭시 첨부파일창이 밑에 더 생긴다.
		$("form[name=studyFrm]").on("click","button.addFile",function(){
			
			if($("div.fileWrapper").length<10){
				$("div.fileWrapper:last").after($("div.forCopy").clone().removeClass("forCopy").addClass("fileWrapper"));
			}
				
		});
		
		//첨부파일 - 버튼 클릭시  해당 첨부파일 영역이 사라진다.
		$("form[name=studyFrm]").on("click","button.removeFile",function(){
			//console.log($("div.fileWrapper:eq(0)"));
			//if( $(this).parent("div.fileWrapper")[0]!==$("div.fileWrapper:eq(0)")[0]){ //맨첫번째 첨부파일은 삭제이벤트 발생안함.
				$(this).parent("div.fileWrapper").remove();
			//}else{//맨 첫번째 첨부파일을 삭제하려고 하면, 외관상으로만 파일이름을 지운다. 
				//console.log("맨첫번째 파일 지울라구?");
				//$("div.fileWrapper:eq(0)").find("label.custom-file-label").html("파일을 선택하세요"); 

			//}
		});
	 
		//첨부파일 선택하면 파일 이름이 input창에 나타나게한다.
		//첨부파일이름 표시
		$("form[name=studyFrm]").on("change","[name=upFile]",function(){
			var fileName= $(this).prop("files")[0].name;
			
			$(this).next(".custom-file-label").html(fileName);
			$(this).next("input[name=isNew]").val("true");
			
		});
	
		
		/* $("button#upfileAllDelete").click(function(){
			if(confirm("정말 첨부파일을 모두 제거하겠습니까?")){
				$("div.fileWrapper").remove();
			}
			
		}); */
		
		// 날짜를 조정해보자...
	   $("input[class=changeDate]").on("change", function(){
	      var week = [ "일", "월", "화", "수", "목", "금", "토" ];
	      
	      var sdate = $("#sdate").val();
	      var sday = new Date(sdate).getDay();
	      var startArray = sdate.split("-");
	      var start_date = new Date(startArray[0], startArray[1], startArray[2]);
	      
	      var edate = $("#edate").val();
	      var endArray = edate.split("-");
	      var end_date = new Date(endArray[0], endArray[1], endArray[2]);   
	      
	      var difference = (end_date.getTime() - start_date.getTime())/1000/24/60/60;
	      
	      if( difference >= 0 && difference < 7 ){
	         $(".day").attr("disabled", true);
	         
	          for( var i = 0; i < difference+1; i++ ){
	             if( sday + i < 7)         
	                $("input[class=day]").eq(sday+i).attr("disabled", false);             
	             else
	                $("input[class=day]").eq(sday+i-7).attr("disabled", false);   
	          }
	      }      
	   });

	
});

//유효성 검사
function validate(){
	
		// time만들기.
	   var starttime = $("select#starttime option:checked").val();
	   var endtime = $("select#endtime option:checked").val();   
	   
	   $("input#time").val(starttime + "~" + endtime);
	   
	   
	   //기존의 파일 이름 연결해서 보내기 
	   var oldFiles="";
	   $("input[name=isNew]").each(function(index){
		   
		   if($(this).val()=="false"){
			   console.log("돌아가냐");
			   if(index!=0) oldFiles+=",";
			   oldFiles+=$(this).next("label").text();
			   
		   }
	   });
	   console.log("oldFiles ="+oldFiles );
	   $("input#originFile").val(oldFiles);
	   
	   
	   
	return true;
}

</script>
<form action="studyUpdateEnd.do" name="studyFrm" method="post" onsubmit="return validate();" enctype="multipart/form-data">
	
		<label for="local">지역 : </label>
		<select name="lno" id="local">
		</select>
		<select name="tno" id="town">
		</select>	
		<label for="title">스터디 제목 : </label><input type="text" name="title" id="title" placeholder="제목" class="form-control" value="${study.TITLE }" required /><br />
		<label for="content">스터디 내용 : </label><textarea name="content" id="content" cols="30" rows="10" placeholder="내용을 입력해주세요" class="form-control">${study.CONTENT }</textarea><br />
		<label for="depart">카테고리</label>
		<select name="subject" id="subject"> <!-- kind선택시 ajax로 그에 맞는 과목 가져오기 -->
		</select>
		<select name="kno" id="kind"> <!-- ajax로 kind가져오기 -->
		</select>&nbsp;&nbsp;&nbsp;<label for="diff">난이도 : </label>
		<select name="dno" id="dno">
			<option value="1">입문</option>
		</select><br />
		<label for="ldate">신청마감 : </label><input type="date" name="ldate" id="ldate" value="${study.LDATE }"/>
		<label for="schedule">스터디 일정 : </label><input type="date" name="sdate" class="changeDate" id="sdate" value="${study.SDATE }"/>~<input type="date" name="edate" class="changeDate" id="edate" value="${study.EDATE }"/><br />
		<label for="freq">스터디빈도 : </label>
		<label>월 </label><input type="checkbox" name="freq" id="" value="일" ${fn:contains(study.FREQ, "일")? "checked":""}/>
		<label>화 </label><input type="checkbox" name="freq" id="" value="월" ${fn:contains(study.FREQ, "월")? "checked":""}/>
		<label>수 </label><input type="checkbox" name="freq" id="" value="화" ${fn:contains(study.FREQ, "화")? "checked":""}/>
		<label>목 </label><input type="checkbox" name="freq" id="" value="수" ${fn:contains(study.FREQ, "수")? "checked":""}/>
		<label>금 </label><input type="checkbox" name="freq" id="" value="목" ${fn:contains(study.FREQ, "목")? "checked":""}/>
		<label>토 </label><input type="checkbox" name="freq" id="" value="금" ${fn:contains(study.FREQ, "금")? "checked":""}/>
		<label>일 </label><input type="checkbox" name="freq" id="" value="토" ${fn:contains(study.FREQ, "토")? "checked":""}/> 
		
		<label for="starttime">스터디 시간</label>
		
		<!-- 시간을 시작시간, 끝나는 시간으로 나누어서 비교하기 위해서 spilt함 -->
		<c:set var="times" value="${fn:split(study.TIME,'~')}"/>
		
		<select name="starttime" id="starttime">
			<c:forEach var="i" begin="6" end="23">
			<option value="${i }:00" ${fn:contains(fn:split(study.TIME,'~')[0],i)? "selected":""} >${i }:00</option>
			
			</c:forEach>
		</select>
		<select name="endtime" id="endtime">
			<c:forEach var="j" begin="7" end="24">
			<option value="${j }:00"${fn:contains(times[1],j)? "selected":""}>${j }:00</option>
			
			</c:forEach>
		</select><br />
		<input type="hidden" name="time" id="time"/>
		<label for="price">일회 사용회비 : </label><input type="text" name="price" id="price" class="form-control" placeholder="협의 - 스터디 카페 대여비 - 6000원" value="${study.PRICE }"/>
		<br />
		<label for="recruit">모집 인원 : </label>
		<select name="recruit" id="recruit">
			<c:forEach var="i" begin="2" end="10">
			<option value="${i }" ${study.RECRUIT==i? "selected":"" } >${i }명</option>
			</c:forEach>
		</select><br />
		<label for="etc">기타 : </label><textarea name="etc" id="etc" cols="30" rows="10" class="form-control" >${study.ETC }</textarea><br /> 
		
		<!-- 기존의 업로드 파일 값들을 보낸다. -->
		<input type="hidden" name="originFile" id="originFile" />
		<button type="button" class="addFile">파일 추가</button>
		
		
		<!-- <button type="button" id="upfileAllDelete">첨부파일 모두 삭제</button> -->
		<c:set var="imgFiles" value="${fn:split(study.UPFILE,',')}"/>
		<c:forEach var="img" items="${imgFiles }">
		<div class="input-group mb-3 fileWrapper" style="padding:0px">
			  <div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">첨부파일</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" id="upFile1" name="upFile">
			     <!-- 새로 첨부한 파일인지의 여부 -->
			    <input type="hidden" name="isNew" value="false" />
			    <label class="custom-file-label" for="upFile1">${img }</label>
			  </div>
			  <!-- <button type="button" class="addFile">+</button> -->
			  
			 
			  <button type="button" class="removeFile">-</button>
		</div>
		</c:forEach>
		
		
		
		
		<input type="reset" value="취소하기" />
		<input type="submit" value="수정하기" />
		<input type="hidden" name="sno" value="${study.SNO }" />
	</form>
	<div class="input-group mb-3 forCopy" style="padding:0px">
			  <div class="input-group-prepend" style="padding:0px">
			    <span class="input-group-text">첨부파일</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" id="upFile1" name="upFile">
			     <!-- 새로 첨부한 파일인지의 여부 -->
			 	 <input type="hidden" name="isNew" value="true" />
			    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
			  </div>
			  
			  <button type="button" class="removeFile">-</button>
		</div>