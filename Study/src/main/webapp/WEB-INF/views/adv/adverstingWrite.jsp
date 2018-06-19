<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page ="/WEB-INF/views/common/header.jsp">
	<jsp:param value="광고등록" name="pageTitle"/>
</jsp:include>


<form action="${rootPath}/adv/adverstingWriteEnd"  method="post" enctype="multipart/form-data">
  <div class="form-row">
    <div class="form-group col-md-4">
      <label for="position">배너위치</label> 
      <select id="position" name="position" class="form-control">
        <option selected>메인TOP</option>
        <option>베너</option>
        <option>팝업</option>
        <option>윙 2</option>
        <option>윙 3</option>
      </select>
    </div>
    <div class="form-group col-md-12">
      <label for="inputEmail4">제목</label>
      <input type="text" class="form-control" id="title" name="title" placeholder="광고 제목을 입력해주세요" autocomplete="off">
    </div>
    
   <div class="form-group col-md-12">
    <label for="content">광고 내용을 간략히 적어주세요.</label>
    <textarea class="form-control" name="content" id="content" rows="3"></textarea>
  </div>
    
    
  </div>
  <div class="form-row">
      
    <div class="form-group col-md-6">
      <label for="img">이미지</label>
      <input type="file" class="form-control" id="img" name="img" placeholder="이미지를 선택해주세요">
      <div><img src="" alt="" class="col-md-12" /> </div>
    </div>
    
  </div>
	<div class="form-row">
		 <div class="form-group col-md-6">
		  <label for="startAd">시작일</label> 
		  <input type="date" class="form-control" name="startAd" id="startAd" />
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
	      <label for="backColor">백보드 컬러</label> 
	      <input type="text" class="form-control" id="backColor" name="backColor" placeholder="보드컬러를 작성해주세요" autocomplete="off" >
	    </div>
	</div>
	<div class="form-row">
	   <div class="form-group col-md-6">
	       <input type="checkbox" class="form-check-input" id="status" name="status"  checked>
  		   <label class="form-check-label" for="status">사용유무</label>
	    </div>
	</div>
  
  #FEE800
   
  <button type="submit" class="btn btn-primary">등록</button>
</form>

<script>
$(function(){
	
	var startDate = new Date();
	var endDate = new Date();
	endDate.setMonth(endDate.getMonth()+1);
	// 시작날짜 오늘 부터로 초기값 설정
	$("[name=startAd]").val( startDate.toISOString().substring(0, 10));
	// 종료 시간 기본 한달로 초기값 설정
	$("[name=endAd]").val(endDate.toISOString().substring(0, 10));

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
