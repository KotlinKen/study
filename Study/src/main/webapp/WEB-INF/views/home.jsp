<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<script>
	function moveAdminPage(){
		location.href="${pageContext.request.contextPath}/admin/adminMain.do";
	}
</script>
<body>
	<h1>
		Hello world!  
	</h1>
	
	<P>The time on the server is ${serverTime}. </P>
	
	<button type="button" onclick="moveAdminPage();">Go To AdminPage</button>
</body>
</html>
