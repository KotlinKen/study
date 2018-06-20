<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- <jsp:param value="" name="pageTitle"/> --%>

<style>
div#board-container{width:400px; margin:0 auto; text-align:center;}
div#board-container input,div#board-container button{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<script src="${pageContext.request.contextPath }/resources/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<%-- <!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
 --%>
<div id="board-container">
<input type="text" class="form-control" placeholder="글번호" name="boardNo" id= "boardNo" value="${board.boardNo }" required>
 <input type="text" class="form-control" placeholder="제목" name="boardTitle" id="boardTitle" value="${board.boardTitle }" required>
   <input type="text" class="form-control" name="boardWriter" value="${board.boardWriter}" readonly required> 

   <c:forEach items="${attachmentList}" var="a" varStatus="vs">
       <button type="button" 
               class="btn btn-outline-success btn-block"
               onclick="fileDownload('${a.originalFileName}','${a.renamedFileName }');">
           첨부파일${vs.count} - ${a.originalFileName }
       </button>
   </c:forEach>
  
  <textarea class="form-control" name="boardContent" placeholder="내용" required>${board.boardContent }</textarea> 
<div class="container">
<label for="content">comment</label>
<div class="input-group">
<input type="hidden" name="boardNo"/>
<input type="text" class="form-control" id="replyContent" name="replyContent" placeholder="내용을 입력하세요">
<span class="input-group-btn">
<input type="button" class="insertBtn" value="등록" onclick="location.href='${pageContext.request.contextPath}/board/boardCommentInsert.do?'">
</span>
</div>
</div>
  <!-- <form action = "boardComment.do" name="boardComment" method="post"> -->
  
       <input type="button" class="updateBtn" value="글수정" onclick="location.href='${pageContext.request.contextPath}/board/boardUpdate.do?no='+${board.boardNo}">
       <input type="button" class="delBtn" value="글삭제" onclick="location.href='${pageContext.request.contextPath}/board/boardDelete.do?no='+${board.boardNo}">
</div>
 <script>
function fileDownload(oName, rName){
	//한글파일명, 특수문자가 포함있을 경우 대비
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/boardDownload.do?oName="+oName+"&rName="+rName;
}
</script> 