<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizzy 로그인</title>
    <!-- 카카오 API SDK -->
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js" 
    integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <!-- JS -->
    <script src="resources/js/jquery-3.7.1.js"></script>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="resources/css/login/login.css">
</head>
<body>

	<h1 class="logo" onclick="location.href='./'">Fundizzy</h1>
	
	<form action="LoginSuccess" method="post">
		<div class="login-options">
		<!--     <input type="checkbox" id="remember-me"> -->
		    <input type="checkbox" id="remember-me" name="rememberId" class="form-check-input" <c:if test="${not empty cookie.rememberId.value}">checked</c:if>>
		    <label for="remember-me">이메일 기억하기</label>
		</div>
		
		<div class="login-container">
		        <input type="email" name="email" placeholder="이메일 입력" required value="${cookie.rememberId.value}"><br>
		        <input type="password" name="password" placeholder="비밀번호 입력" required><br>
		        <button type="submit" class="login-btn email-login">이메일로 로그인하기</button>
		
		    <div class="social-login">
		        <a href="javascript:loginWithKakao()">
		            <img src="${pageContext.request.contextPath}/resources/images/login/kakao_login_custom.png" alt="카카오 로그인 버튼" class="kakao" >
		        </a>
		        <a href="javascript:loginWithNaver()">
		            <img src="${pageContext.request.contextPath}/resources/images/login/naver_login_custom.png" alt="네이버 로그인 버튼" class="naver">
		        </a>
		    </div>
		    
			<div class="social-icons">
		        <img src="${pageContext.request.contextPath}/resources/images/login/google_icon.png" alt="Google 로그인" onclick="location.href='google'">
		        <img src="${pageContext.request.contextPath}/resources/images/login/facebook_login.png" alt="Facebook 로그인">
		        <img src="${pageContext.request.contextPath}/resources/images/login/apple_login.png" alt="Apple 로그인">
		    </div>
		</div>
	</form>
	
	<div class="link-container">
	    <a href="FindEmail">아이디/비밀번호 찾기</a> | <a href="SignUp">회원가입</a>
	</div>
    <script src="${pageContext.request.contextPath}/resources/js/login/social_login.js"></script>
    <script>
	    window.config = {
  			kakaoClientId: "${kakaoClientId}", // Spring Model 값을 window 객체에 저장
  			kakaoRedirectUrl: "${kakaoRedirectUrl}", // Spring Model 값을 window 객체에 저장
  			naverClientId: "${naverClientId}", // Spring Model 값을 window 객체에 저장
  			naverClientSecret: "${naverClientSecret}", // Spring Model 값을 window 객체에 저장
  			naverRedirectUrl: "${naverRedirectUrl}" // Spring Model 값을 window 객체에 저장
	    };
	    var messageFromJSP = "${state}";
	</script>
<%--     			kakaoRedirectUrl: "${kakaoRedirectUrl}" // Spring Model 값을 window 객체에 저장 --%>
<%--    				naverClientId: "${naverClientId}" // Spring Model 값을 window 객체에 저장 --%>
<%-- 				naverClientSecret: "${naverClientSecret}" // Spring Model 값을 window 객체에 저장 --%>
<%-- 				naverRedirectUrl: "${naverRedirectUrl}" // Spring Model 값을 window 객체에 저장 --%>

</body>
</html>
