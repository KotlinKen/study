<jsp:include page ="/WEB-INF/views/common/header.jsp"><jsp:param value="" name="pageTitle"/></jsp:include>

<div class="tabs">
	<span class="showPopup"><a href="${rootPath }/adv/adverstingListPaging?type=베너" >베너</a></span><span class="seperate">|</span><span class="showBanner"><a href="${rootPath }/adv/adverstingListPaging?type=메인" >메인</a></span>
</div>

<form action="${rootPath }/adv/adverstingListPaging" >
	<div class="form-row">
		<div class="form-group col-md-3">
			<input type="text" name="searchKeyword" class="form-control" value="${param.searchKeyword }"/>
		</div>
		<div class="form-group col-md-1">
			<button type="submit" class="form-control btn btn-primary btn-lg active">검색</button>
		</div>
	</div>
</form>



<div class="form-row">
	<div class="form-group col-md-3">
		<select id="position" name="position" class="form-control" id="position">
			<option selected>메인TOP</option>
			<option>윙 1</option>
			<option>윙 2</option>
			<option>윙 3</option>
		</select>
	</div>
	<div class="form-group col-md-3">
		<select id="position" name="position" class="form-control">
			<option selected>메인TOP</option>
			<option>윙 1</option>
			<option>윙 2</option>
			<option>윙 3</option>
		</select>
	</div>
</div>

<script>

</script>

총 ${count }건의 게시물이 있습니다.
<input type="button" value="글쓰기"  class="btn btn-bd-download d-none d-lg-inline-block mb-3 mb-md-0 ml-md-3"  id="btn-add" onclick="location.href='adverstingWrite'" />

<table class="rm_table">
<thead>
	<tr>
		<th width="5%">번호</th>
		<th width="8%">위치</th>
		<th width="15%">제목</th>
		<th width="20%">내용</th>
		<th width="6%">시작일</th>
		<th width="6%">종료일</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="list" items="${list}" varStatus="status">
		<tr onclick="fn_boardView('${list.ANO }')">
			<td class="first_col">${list.ANO}</td>
			<td>${list.POSITION}</td>
			<td>${list.TITLE}</td>
			<td>${list.CONTENT}</td>
			<td class="advDate">${fn:substring(list.STARTAD, 0, 10)}</td>
			<td class="advDate">${fn:substring(list.ENDAD, 0, 10)}</td>


		</tr>
	</c:forEach>
</tbody>
</table>



<%
	int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("count")));
	int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
	int cPage =1;
	try{
		cPage = Integer.parseInt(String.valueOf(request.getParameter("cPage")));
	}catch(NumberFormatException e){
		
	}
	
%>

  <%= com.pure.study.common.util.Utils.getPageBar(totalContents, cPage, numPerPage, "adverstingListPaging.do") %>
  
<script>
	function fn_boardView(ano){
		location.href="${rootPath}/adv/adverstingView?ano="+ano;
	}
</script>
<jsp:include page ="/WEB-INF/views/common/footer.jsp" />
