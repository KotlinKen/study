<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<script>
	// 삭제버튼
	function deleteLecture(){
		location.href="${pageContext.request.contextPath}/lecture/deleteLecture.do?sno=" + ${lecture.SNO};
	}
	
	//참여신청 버튼 클릭 이벤트
	function lectureApply(){
		var sno = ${lecture.SNO};
	   //세션에서 멤버의 mno 받아옴 로그인 안한상태에 대해서도 분기 처리.
	   //이미 신청을 했으면 return;하게 만들어야 함. 
	   //임시로 confirm. 계획은 부트스트랩 모달창에 주요 정보 나열 후 확인버튼누르면 아작스 실행.
	   if(confirm("신청하시겠습니까")) {
	      $.ajax({
	         url:"applyLecture.do",
	         data:{
	        	    sno : sno,
	        	 	mno : 2
	         },
	         success:function(data){
	         	if( data == 1 ){
	         		alert("강의 신청이 완료되었습니다.");
	         	}
	         	else{
	         		alert("이미 신청하신 강의입니다.");
	         	}
	         }
	      });
	   }
	}
	
	//찜하기 버튼 클릭 이벤트
	function lectureWish(){
		var sno = ${lecture.SNO};
	   //세션에서 멤버의 mno 받아옴 로그인 안한상태에 대해서도 분기 처리.
	   //찜하기를 이미 선택했다면 다시 누르면 찜하기에서 삭제됨.
	   $.ajax({
	      url:"wishLecture.do",
	      data:{
	    	  sno : sno,
	    	  mno : 2
	      },
	      success:function(data){
	         console.log("찜했다");
	         //신청 완료 후 button에 스타일 주어서 이미 신청했음을 표시하게 한다.
	      }
	   });
	}
	
	$(function(){   
	   $("button.editLecture").click(function(){
	      location.href="lectureUpdate.do?sno="+${lecture.SNO};	      
	   });   
	});
</script>
</head>
<body>
	<div id="study-detail">
	 	<!-- 팀장일때만 나타날 것임. -->
		<button type="button" class="editLecture">강의 수정</button>	
		<button type="button" onclick="deleteLecture();">강의 삭제</button>

		<span>LEVEL : ${lecture.DNAME }</span>
		<span>${lecture.LNAME }-${lecture.TNAME }</span>
		<span>${lecture.TITLE }</span>
		<span>스터디 소개 : ${lecture.CONTENT }</span>
	
		<div id="detail">
			<span>지역 : ${lecture.LNAME } ${lecture.TNAME }</span>
			<span>인원 : ${lecture.RECRUIT }명</span><br />
			<span>${lecture.FREQ }</span>
			<span>${lecture.TIME }</span><br />
			<span>신청기간 : ${lecture.LDATE }까지</span>
			<span>수업 기간 : ${lecture.SDATE }~${lecture.EDATE }</span>
			<span>협의비 : ${lecture.PRICE }</span>
			
			<hr />
			
			<label for="">리더 소개</label>
			<span>${lecture.COVER }</span>	
		</div>	
	
		<!-- 팀장에 대한 후기 -->	
		<div id="review">
		
		</div>	
	</div>
	
	<!-- 오른쪽 fix창 -->
	<div id="side-info"> 
		<span>${lecture.SUBNAME } : ${lecture.KNAME }</span>
		<span>${lecture.TITLE }</span><br />
		<span>${lecture.SDATE }~${study.EDATE }</span>
		<button type="button" onclick="lectureApply();">참여 신청하기</button>
		<button type="button" onclick="lectureWish();">찜하기</button>		
	</div>
</body>
</html>