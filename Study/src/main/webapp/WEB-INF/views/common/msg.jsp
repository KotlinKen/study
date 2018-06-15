<jsp:include page ="/WEB-INF/views/common/header.jsp"><jsp:param value="" name="pageTitle"/></jsp:include>






<script>
	alert("${msg}");
	
	if("성공" == "${msg}"){
	}else{
		
	}
		location.href="${rootPath}${loc}";
</script>








<jsp:include page ="/WEB-INF/views/common/footer.jsp" />
