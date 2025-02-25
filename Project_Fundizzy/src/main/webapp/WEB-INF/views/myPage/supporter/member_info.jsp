<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기본 정보 설정</title>
  	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/member_info.css">	
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="main">
	   <div class="container">
	       <h1>기본 정보 설정</h1>
	
	       <form>
	           <input type="text" placeholder="회원가입한 이름" class="input-box">
	           
	           <div class="input-group">
	               <input type="email" placeholder="example@gmail.com" class="input-box" disabled>
	               <button class="btn">변경</button>
	           </div>
	
	           <div class="input-group">
	               <input type="text" placeholder="010-0000-0000" class="input-box" disabled>
	               <button class="btn">변경</button>
	           </div>
	
	
	           <button class="confirm-btn">확인</button>
	       </form>
	   </div>
	</div>
</body>
</html>
