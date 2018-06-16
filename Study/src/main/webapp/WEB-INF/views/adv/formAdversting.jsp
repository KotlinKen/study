<jsp:include page ="/WEB-INF/views/common/header.jsp"><jsp:param value="" name="pageTitle"/></jsp:include>

<form action="${rootPath}/adv/insertAdversting.do"  name="boardFrm" method="post" enctype="multipart/form-data">
	<input type="text" name="title" />
	<input type="text" name="title" />
	<textarea name="content" id="content" cols="30" rows="10"></textarea>
	<input type="file" name="img" />
	<input type="file" name="img" />
	<input type="text" name="url"/>
	<select name="position" id="position">
		<option value="maintop">메인상단</option>
		<option value="">메인사이드</option>
		<option value="">팝업</option>
	</select>
	<input type="date" name="startAd" id="startAd" />
	<input type="date" name="endAd" />
	<button type="submit">전송</button>
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

})



</script>


<jsp:include page ="/WEB-INF/views/common/footer.jsp" />
