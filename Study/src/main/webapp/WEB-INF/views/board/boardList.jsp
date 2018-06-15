<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--   <jsp:param value="" name="pageTitle"/>
 --%><style>
 
input#btn-add{float:right; margin: 0 0 15px;}
</style> 

<section id="board-container" class="container">
   <h2>총 게시물 수는 ${count }개 입니다.</h2>
   <input type="button" class="btn btn-outline-success"
   value="글쓰기" id="btn-add" onclick="location.href='boardForm.do'"/>
   
   <table class="table" id="tbl-board">
  <tr>
  <th scope="col">글번호</th>
    <th scope="col">글제목</th>
    <th scope="col">작성자</th>
    <th scope="col">내용</th>
    <th scope="col">작성일자</th>
    <th scope="col">첨부파일</th>
    <th scope="col">조회수</th>
</tr>
<c:forEach var="board" items="${list }" varStatus="vs">
   <tr onclick="location.href='${pageContext.request.contextPath}/board/boardView.do?no='+${board.BOARDNO}">


<td>${board.BOARDNO }</td>
<td>${board.BOARDTITLE }</td>
<td>${board.BOARDWRITER }</td>
<td>${board.BOARDCONTENT }</td>
<td>${board.BOARDDATE }</td>
<td>${board.FILECNT }</td>
<td>${board.BOARDREADCOUNT }</td>
</tr>
</c:forEach>
  
  
  
  
  </table>
   
   </section>
   
   <!-- 페이지바 -->
   <% 
   int count = Integer.parseInt(String.valueOf(request.getAttribute("count")));
   int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
   int cPage = 1;
   try{
	   cPage = Integer.parseInt(request.getParameter("cPage"));
   }catch(NumberFormatException e){
	   
   }

   %>
   <%=com.pure.study.common.util.Utils.getPageBar(count,cPage,numPerPage,"boardList.do")%>