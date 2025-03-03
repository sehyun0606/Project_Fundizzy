<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizy 로그인</title>
    <!-- 카카오 API SDK -->
<!--     <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js"  -->
<!--     integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script> -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <!-- Jquery -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="resources/css/login/login.css">
</head>
<body>

	<h1 class="logo" onclick="location.href='./'">Fundizy</h1>
	
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
		        <a href="YOUR_KAKAO_LOGIN_URL">
		            <img src="${pageContext.request.contextPath}/resources/images/login/kakao_login_custom.png" alt="카카오 로그인 버튼" class="kakao" onclick="loginWithKakao()">
		        </a>
		        <a href="YOUR_NAVER_LOGIN_URL">
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
	    <a href="#">아이디/비밀번호 찾기</a> | <a href="SignUp">회원가입</a>
	</div>

 	<script>
	    // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
		    Kakao.init('df4ce7d2973e2870da833f67f5c93e0e');
	    // SDK 초기화 여부를 판단합니다.
		    console.log(Kakao.isInitialized());
	    
	    function loginWithKakao() {
            Kakao.Auth.login({
                success: function(authObj) {
                    console.log(authObj);
                    // 로그인 성공 후 사용자 정보 요청
                    getUserInfo();
                },
                fail: function(err) {
                    console.error(err);
                },
            });
        }

        function getUserInfo() {
            Kakao.API.request({
                url: 'callback',
                success: function(response) {
                    console.log(response);
                    // 사용자 정보를 백엔드로 전송
                    sendUserInfo(response);
                },
                fail: function(error) {
                    console.error(error);
                },
            });
        }

        function sendUserInfo(user) {
            fetch('/api/user/kakao', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(user)
            })
            .then(response => response.json())
            .then(data => {
                console.log('사용자 정보 저장 완료:', data);
                alert('로그인 성공! 사용자 정보가 저장되었습니다.');
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
  	</script>
	
</body>
</html>
