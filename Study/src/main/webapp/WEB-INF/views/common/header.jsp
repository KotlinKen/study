<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${param.pageTitle}</title>
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
	integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
	crossorigin="anonymous"></script>
</head>
<body>
	<div>
		<header> <c:if test="${memberLoggedIn == null }">
			<button type="button" class="btn btn-outline-success"
				data-toggle="modal" data-target="#loginModal">로그인</button>
			<!-- 회원가입 버튼 시작 -->
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/member/memberAgreement.do'">회원가입</button>
			<!-- 회원가입 버튼 끝 -->
		</c:if> <c:if test="${memberLoggedIn != null }">
			<p>
				<a href="${pageContext.request.contextPath }/member/memberView.do">${memberLoggedIn.mname }</a>님
			</p>
			<button type="button" class="btn btn-outline-success"
				onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.do'">로그아웃</button>

		</c:if> </header>
		<section> <!-- 로그인 Modal 시작 -->
		<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form
						action="${pageContext.request.contextPath }/member/memberLogin.do"
						method="post">
						<div class="modal-body">
							<input type="text" class="form-control" name="userId" id="userId"
								placeholder="아이디" required /> <br /> <input type="password"
								class="form-control" name="pwd" id="password" placeholder="비밀번호"
								required /> <a
								href="${pageContext.request.contextPath }/member/memberFindPage.do?findType=아이디">아이디/</a>
							<a
								href="${pageContext.request.contextPath }/member/memberFindPage.do?findType=비밀번호">비밀번호
								찾기</a>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-outline-success">로그인</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 로그인 Modal 끝 -->