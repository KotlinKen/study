<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.pageTitle }</title>
<!-- 부트스트랩관련 라이브러리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<link rel="shortcut icon" href="">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />

<style>
 
</style>
</head>
<body>

<div id="container">
	<header>
		<div id="header-container">
			<h2>${param.pageTitle }</h2>
		</div>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="#">
				<img src="${pageContext.request.contextPath }/resources/images/logo-spring.png" alt="스프링로고" width="50px" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
		  	</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mr-auto">
			      <li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}">Home</a></li>
						<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> Dropdown </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="${rootPath}/demo/demo.do">Demo</a> 
								<a class="dropdown-item" href="${rootPath}/demo/selectDevList.do">회원리스트</a> 
								<a class="dropdown-item" href="${rootPath}/board/boardList.do">게시판</a> 
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Something else here</a>
							</div>
						</li>
			    </ul>
			    
			    
  		      <c:if test="${memberLoggedIn ==null }">
			    <!-- 회원가입버튼 -->
			    <button type="button" class="btn btn-outline-success" data-toggle="modal"  data-target="#LoginModal" >로그인</button>
			    &nbsp;
			    <button type="button" class="btn btn-outline-success" onclick="location.href='${rootPath}/member/memberEnroll.do'">회원가입</button>
  		      </c:if>
		      <c:if test="${memberLoggedIn != null }">
		      	<a href="${rootPath }/member/memberView.do?userId=${memberLoggedIn.userId }">${memberLoggedIn.userName }</a> 님, 안녕하세요. 
		      	<button class="btn btn-outline-success" type="button" onclick="location.href='${rootPath}/member/memberLogout.do'">로그아웃</button>
		      </c:if>
			    
			    
			    
			 </div>
		</nav>
		<!-- Modal -->
		<div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">익순이 발가락 여섯개</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      
		      <form action="${rootPath}/member/memberLogin.do" method="POST">
		      <div class="modal-body">
        		<input type="text" name="userId" id="userId"  class="form-control" placeholder="아이디" required />
        		<br />
        		<input type="password" name="password" id="password" class="form-control" placeholder="비밀번호" required />
		      </div>
		      

		      <div class="modal-footer">
		        <button type="submit" class="btn btn-outline-success" >로그인</button>
		        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
		      </div>

		      </form>
		    </div>
		  </div>
		</div>
	</header>
	<section id="content">