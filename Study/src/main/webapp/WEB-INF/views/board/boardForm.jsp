<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--    <jsp:param value="" name="pageTitle"/>
 --%><script>
function validate(){
   
   return true;
}
$(function(){
   $("[name=upFile]").on("change",function(){
      //var fileName= $(this).val();
      var fileName= $(this).prop("files")[0].name;
      
      $(this).next(".custom-file-label").html(fileName);
   });
   
});

</script>
<style>
/*부트스트랩 라벨명정렬*/
div#board-container label.custom-file-label{text-align:left;}
div#board-container{
   width:400px;
   margin:0 auto;
   text-align:center;
   
}
div#board-container input{margin-bottom:15px;}
</style>
<script src="${pageContext.request.contextPath }/resources/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<%-- <!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" /> --%>
<div id="board-container">
   <form action="boardFormEnd.do" name="boardFrm" method="post" onsubmit="return validate();" enctype="multipart/form-data">
      <input type="text" name="boardTitle" id="boardTitle" placeholder="제목" class="form-control" required/>
      <input type="text" name="boardWriter" id="boardWriter" value="${memberLoggedIn.userId }" class="form-control" readonly required/>
      <div class="input-group mb-3" style="padding:0px">
        <div class="input-group-prepend" style="padding:0px">
          <span class="input-group-text">첨부파일</span>
        </div>
        <div class="custom-file">
          <input type="file" class="custom-file-input" id="upFile1" name="upFile">
          <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
        </div>
      </div>
      
       <div class="input-group mb-3" style="padding:0px">
        <div class="input-group-prepend" style="padding:0px">
          <span class="input-group-text">첨부파일2</span>
        </div>
        <div class="custom-file">
          <input type="file" class="custom-file-input" id="upFile2" name="upFile">
          <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
        </div>
      </div>
      <textarea name="boardContent" id="boardContent" cols="30" rows="10" class="form-control" placeholder="내용" required></textarea><br />
      <input type="submit" class="btn btn-outline-success" value="저장"/>
      
   </form>

</div>