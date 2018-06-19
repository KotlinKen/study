<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page ="/WEB-INF/views/common/header.jsp">
	<jsp:param value="광고등록" name="pageTitle"/>
</jsp:include>


<form action="${rootPath}/adv/adverstingReWrite"  name="adverstingReWrite"  method="post" enctype="multipart/form-data">
  <div class="form-row">
    <div class="form-group col-md-4">
      <label for="position">배너위치</label> 
      <select id="position" name="position" class="form-control">
        <option>메인TOP</option>
        <option ${("베너" eq adversting.POSITION) ? "selected" : ""}>베너</option>
        <option ${("팝업" eq adversting.POSITION) ? "selected" : ""}>팝업</option>
        <option ${("윙 2" eq adversting.POSITION) ? "selected" : ""}>윙 2</option>
        <option ${("윙 3" eq adversting.POSITION) ? "selected" : ""}> 윙 3</option>
      </select>
    </div>
    <input type="hidden" name="ano" value="${adversting.ANO }" />
    <div class="form-group col-md-12">
      <label for="inputEmail4">제목</label>
      <input type="text" class="form-control" id="title" name="title" placeholder="광고 제목을 입력해주세요" autocomplete="off" value="${adversting.TITLE}">
    </div>
    
   <div class="form-group col-md-12">
    <label for="content">광고 내용을 간략히 적어주세요.</label>
    <textarea class="form-control" name="content" id="content" rows="3">${adversting.CONTENT}</textarea>
  </div>
    
    
  </div>
  <div class="form-row">
      
    <div class="form-group col-md-6">
      <label for="img1">메인이미지</label>
      <input type="hidden" name="advImg" value="${adversting.ADVIMG }"/>
      <input type="file" class="form-control" id="img1" name="img" placeholder="이미지를 선택해주세요">
      <div><img src="${rootPath}/resources/upload/adversting/${adversting.ADVIMG}" alt="" class="col-md-12" /> </div>
    </div>
 
  </div>
	<div class="form-row">
		 <div class="form-group col-md-6">
		  <label for="startAd">시작일</label> 
		  <input type="date" class="form-control" name="startAd" id="startAd"  />
		</div>
		 <div class="form-group col-md-6">
		  <label for="endAd">종료일</label> 
		  <input type="date" class="form-control" name="endAd" id="endAd" />
		</div>
	</div>
	<div class="form-row">
	   <div class="form-group col-md-6">
	      <label for="url">링크를 작성해주세요.</label> 
	      <input type="text" class="form-control" id="url" name="url" placeholder="링크를 작성해주세요." autocomplete="off">
	    </div>
	</div>

	<div class="form-row">
	   <div class="form-group col-md-6">
	       <input type="checkbox" class="form-check-input" id="status" name="status">
	       ${adversting.STATUS }
  		   <label class="form-check-label" for="status">사용유무</label>
	    </div>
	</div>
   	<div class="form-row">
	   <div class="form-group col-md-6">
	      <label for="backColor">백보드 컬러</label> 
	      <input type="text" class="form-control" id="backColor" name="backColor" placeholder="백보드 컬러를 작성해주세요" autocomplete="off" value="${adversting.BACKCOLOR }">
	    </div>
	</div>
  
   
  <button type="submit" class="btn btn-primary">수정</button>
  <button type="button" class="btn btn-primary" onclick="fn_delete()">삭제</button>
</form>

<script>

function fn_delete(){
	$("[name=adverstingReWrite]").attr("action", "${rootPath}/adv/adverstingDelete");
	$("[name=adverstingReWrite]").submit();
}



$(function(){
	console.log("${adversting.STARTAD}");
	var startDate = "${adversting.STARTAD}";
	var endDate = "${adversting.ENDAD}";
	$("[name=startAd]").val( startDate.substring(0, 10));
	$("[name=endAd]").val(endDate.substring(0, 10));

});


//이미지 섬네일보기 
$("[name=img]").change(function(){
	var img = $(this).next().find("img");
	$file  = $(this)[0].files[0];
	var reader = new FileReader();
	reader.readAsDataURL($file);
	
	//확장자 확인후 진행 여부
	var chk = $(this).val().split(".").pop().toLowerCase();
	if($.inArray(chk, ['gif','png','jpg','jpeg']) == -1){
		alert("이미지만 등록할 수 있습니다.");
		$(this).val("");
		return; 
	}
	
	reader.onload = function(){
		img.attr("src", reader.result);

	}
});


</script>


<jsp:include page ="/WEB-INF/views/common/footer.jsp" />
