<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script>
	$(document).ready(function(){
	    $(".tabmenu").each(function(){
	        var tab = $(this).children("ul");
	        var tabBtn = tab.children("li").children("a");
	        var content = tabBtn.nextAll();
	         
	        // 탭버튼을 클릭했을때
	        tabBtn.click(function(){
	            // 이미 on 상태면 pass
	            if( $(this).hasClass("on") ) 
	            	return;
	
	            // 모든 컨텐츠 부분을 안보이게 한뒤
	            content.hide();
	
	            // 클릭한 tab 버튼(a태그) 옆의 모든 태그들은 보이도록
	            $(this).nextAll().show();
	             
	            // 모든탭 버튼에 있던 on 클래스를 빼고
	            // 현재 클릭한 탭메뉴 버튼에 on 클래스 추가
	            tabBtn.removeClass("on");
	            $(this).addClass("on");
	            $(this).attr("background")
	        });
	         
	        // 맨첫번째 탭버튼 클릭처리
	        tabBtn.eq(0).click();
	    });
	});
</script>

<style>
	*{
		margin: 0 auto;
	}
	#tab-container{
		width: 100%;
		text-align: center;
	}
    .tabmenu {
    	position:relative; 
    	width:100%; 
    	height:200px;
        font-family:dotum,"",verdana;
        line-height:17px;
        font-size:12px;
        color:#555;
     }
    .tabmenu img {
    	border:none;
    	vertical-align:top;
    }
    .tabmenu ul {
    	margin:0px;
    	padding:0px;
    	list-style:none;
    	margin-top: 15px;
        background: gray;
    }
    .tabmenu ul li {
    	float:left
    }
    .tabmenu .tabcontent {
    	display:none; 
    	width:100%;
    	height:125px;
    	position:absolute; 
    	left:0px;
    	top:60px 
    }
</style>
</head>
<body>
	<div id="tab-container">
		<div class="tabmenu">
		    <h2>첫번째 탭메뉴</h2> 
		 
		    <ul>
		        <li><a href="#link">회원 관리</a>
		            <ul class="tabcontent">
		                <li><a href="#">1 제목이 나오는부분.....</a></li>
		                <li><a href="#">2 제목이 나오는부분.....</a></li>
		            </ul>
		        </li>
		        <li><a href="#link">강사 관리</a>
		            <ul class="tabcontent">
		                <li><a href="#">무우우우우우우우.....</a></li>
		                <li><a href="#">5무우우우우우우우ㄴ.....</a></li>
		            </ul>
		        </li>
		            <li><a href="#link">스터디 관리</a>
		            <ul class="tabcontent">  
		                <li><a href="#">요농이 요느마</a></li>
		                <li><a href="#">요농이 요느마</a></li>
		            </ul>  
		        </li>
		        <li><a href="#link">강의 관리</a>
		            <ul class="tabcontent">
		                <li><a href="#">ㄷㄹㄴㄹㄴㄹㄴㄷㄹㄴㄹ</a></li>
		                <li><a href="#">ㄷㄹㄴㄹㄴㄹㄴㄷㄹㄴㄹ</a></li>
		            </ul>
		        </li>
		    </ul>
		</div>
	</div>
</body>
</html>