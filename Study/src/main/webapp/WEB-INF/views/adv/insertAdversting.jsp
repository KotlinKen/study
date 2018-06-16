<jsp:include page ="/WEB-INF/views/common/header.jsp"><jsp:param value="" name="pageTitle"/></jsp:include>

1234

<form action="${rootPath}/adv/insertAdversting"  action="post" enctype="multipart/form-data" >
	<input type="text" name="title" />
	<textarea name="content" id="" cols="30" rows="10"></textarea>
	<input type="file" name="img1" />
	<input type="file" name="img2" />
	<input type="text" name="url"/>
	<select name="" id="">
		<option value="maintop">메인상단</option>
		<option value="">메인사이드</option>
		<option value="">팝업</option>
	</select>
	<input type="date" name="startAd" />
	<input type="date" name="endAd" />
	<button type="submit">전송</button>
</form>



<jsp:include page ="/WEB-INF/views/common/footer.jsp" />
