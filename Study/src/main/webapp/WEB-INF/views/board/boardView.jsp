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
<div id="board-container">

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
</div>
 <script>
function fileDownload(oName, rName){
	//한글파일명, 특수문자가 포함있을 경우 대비
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/board/boardDownload.do?oName="+oName+"&rName="+rName;
}
</script> 