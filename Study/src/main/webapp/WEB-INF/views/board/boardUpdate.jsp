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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" /> --%>
<div id="board-container">
   <form action="boardUpdateEnd.do" name="boardUpdateFrm" method="post" onsubmit="location.href='${pageContext.request.contextPath}/board/boardView.do?no='+${board.boardNo}" enctype="multipart/form-data">
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
<button type="submit">확인</button>
</form>
</div>