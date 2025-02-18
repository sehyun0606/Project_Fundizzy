<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wadiz Registration</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff;
            text-align: center;
            margin-top: 0;
            margin-bottom: 100px;
        }
        .container {
            width: 100%;
            max-width: 600px; /* 전체 너비 줄이기 */
            margin: 0 auto;
            padding-top: 0px; /* 상단 여백 줄이기 */
        }
        h1 {
            font-size: 20px;
            color: #000;
            cursor: pointer;
        }
        h2 {
        	font-size: 15px;
        	text-align: left;
			margin-left: 100px;
        }
        .social-login {
            margin-top: 0px;
            margin-bottom: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: px;
        }
        .social-login img {
            width: 400px;
            height: auto;
            cursor: pointer;
            transition: transform 0.2s; /* 부드러운 전환 효과 추가 */
        }
        .social-login img:hover {
            transform: scale(1.05); /* 약간의 확대 효과 */
        }
        .social-login button {
            width: 80%;
            max-width: 400px;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        .kakao-login {
            background-color: #FEE500;
            color: #000;
        }
        .naver-login {
            background-color: #03C75A;
            color: #fff;
        }
        .social-icons {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }
        .social-icons img {
            width: 40px;
            height: 40px;
            margin: 0 10px;
            cursor: pointer;
        }
        .email-signup {
            text-align: left;
            width: 80%;
            max-width: 400px;
            margin: 0 auto;
        }
        .email-signup h3 {
            font-size: 15px;
            margin-bottom: 0px;
            margin-top: auto;
        }
        .email-signup .nickname {
			margin-bottom: 20px;			        
        }
        .email-signup input {
            width: calc(100% - 0px);
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .email-signup .auth-btn {
			width: 80px;
		    height: 42px;
		    padding: 10px;
		    background-color: mediumpurple;
		    border: none;
		    color: white;
		    border-radius: 5px;
		    cursor: pointer;
		    margin-top: 8px;
            margin-left: 10px; 
	        font-size: 10px;
        }
        .email-signup .auth-btn:hover {
        	background-color: #8e44ad;
        }
        .email-signup .submit-btn {
            width: 100%;
            padding: 15px;
            background-color: mediumpurple;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        .email-signup .submit-btn:hover {
            background-color: #8e44ad;
        }
        .email-signup .password-input {
            display: flex;
            justify-content: space-between;
        }
        .email-signup .password-input input {
            width: calc(100% - 80px);
        }
        .email-signup .auth-input {
            display: flex;
            justify-content: space-between;
            margin-top: 0px;
            margin-bottom: 10px;
        }
        .email-signup .auth-input input {
            width: calc(100% - 80px);
        }
        .email-signup .password-input2 {
            display: flex;
            justify-content: space-between;
        }
        .email-signup .password-input input2 {
            width: calc(100% - 0px);
        }
        .email-signup .eye-btn {
            width: 40px;
            background-color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        
/* ---------------------------------------------------------------------- */
.auth-container {
	 display: flex;
	 flex-direction: column;
	 width: 400px;
}
.auth-sections {
	display: flex;
	flex-direction: column;
	width: 400px;
	margin-bottom: 20px;
}
.auth-label {
  font-size: 16px;
  margin-bottom: 0px;
  margin-top: auto;
}

.email-wrapper {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}

.email-input {
  width: 75%;
  padding: 10px;
  border: 1px solid #dcdcdc;
  border-radius: 4px;
/*   background-color: #f2f8ff; /* 연한 파란색 배경 */ */
  color: #333;
}

.edit-btn {
	background-color: mediumpurple;
    color: white;
    border: none;
    border-radius: 4px;
    margin-left: 10px;
    cursor: pointer;
    height: 42px;
    width: 70px;
    font-size: 10px;
}

.edit-btn:hover {
  background-color: #8e44ad;
}

.auth-input-wrapper {
  display: flex;
  align-items: center;
  position: relative;
  margin-bottom: 5px;
}

.auth-code-input {
  width: 70%;
  padding: 10px;
  border: 1px solid #dcdcdc;
  border-radius: 4px;
  padding-right: 50px; /* 타이머를 위한 여백 */
}

.timer {
  position: absolute;
  right: 80px;
  color: red;
  font-size: 12px;
}

.confirm-btn {
 	background-color: mediumpurple;
    color: white;
    border: none;
    border-radius: 4px;
    margin-left: 10px;
    cursor: pointer;
    height: 42px;
    width: 70px;
}

.confirm-btn:hover {
  background-color: #8e44ad;
}

small {
   color: #888;
   margin-top: auto;
}

.resend-link {
	font-size: 10px;
	color: #555;
	margin-top: 0px;
	text-decoration: underline;
	cursor: pointer;
	margin-bottom: 20px;
	margin-left: 120px;
}

.resend-link:hover {
  color: #333;
}

        
        
        
    </style>
</head>
<body>

<div class="container">
    <h1 style="color: mediumpurple;" onclick="location.href='./'">Fundizy</h1>
    <hr style="border: 0; height: 1px; background-color: #dcdcdc;">
	<h2 style="color: gray;">간편가입</h2>
    <!-- Social Login -->
    <div class="social-login">
        <a href="YOUR_KAKAO_LOGIN_URL">
            <img src="${pageContext.request.contextPath}/resources/images/login/kakao_login_custom.png" alt="카카오 로그인 버튼">
        </a>
        <a href="YOUR_NAVER_LOGIN_URL">
            <img src="${pageContext.request.contextPath}/resources/images/login/naver_login_custom.png" alt="네이버 로그인 버튼">
        </a>

        <div class="social-icons">
            <img src="${pageContext.request.contextPath}/resources/images/login/google_icon.png" alt="Google">
            <img src="${pageContext.request.contextPath}/resources/images/login/facebook_login.png" alt="Facebook">
            <img src="${pageContext.request.contextPath}/resources/images/login/apple_login.png" alt="Apple">
        </div>
    </div>
	<hr style="border: 0; height: 1px; background-color: #dcdcdc;">
    <!-- Email Sign-Up -->
    <form action="SignUP" method="get">
	    <div class="email-signup">
		    <div class="auth-container">
				<label for="email" class="auth-label" style="color: gray;"><b>이메일</b></label>
				<div class="email-wrapper">
				  <input type="email" id="email" class="email-input" placeholder="이메일을 입력하세요" required>
				  <button type="button" class="edit-btn" onclick="showAuthInput()">인증하기</button>
				</div>
			</div>
			<div class="auth-sections" id="auth-section" style="display: none;">
				<label for="auth-code" class="auth-label">인증번호</label>
				<div class="auth-input-wrapper">
				  <input type="text" id="auth-code" placeholder="인증번호 입력" class="auth-code-input">
				  <span class="timer">2:32</span>
				  <button class="confirm-btn">확인</button>
				</div>
				<small>인증번호 6자리를 입력하세요.</small>
				<a href="#" class="resend-link">인증번호 다시 보내기</a>
			</div>

<!-- ----------------------------------------------------------------------------------------------------------------- -->
<!-- 	        <h3 style="color: gray;">이메일 간편가입</h3> -->
<!-- 	        <div class="password-input"> -->
<!-- 	            <input type="email" id="email" placeholder="이메일 계정" required /> -->
<!-- 	            <button type="button" class="auth-btn" onclick="showAuthInput()">인증하기</button><br> -->
<!-- 	        </div> -->
	        
<!-- 	        <div id="auth-section" style="display: none;"> -->
<!-- 		        <h3 style="color: gray;">인증번호</h3> -->
<!-- 		        <div class="auth-input"> -->
<!-- 		            <input type="email" id="email" placeholder="인증번호 입력" required /> -->
<!-- 		            <button class="auth-btn" >확인</button><br> -->
<!-- <!-- 		            <small>인증번호 6자리를 입력하세요.</small> -->
<!-- 		        </div> -->
<!-- 			</div> -->
<!-- ----------------------------------------------------------------------------------------------------------------- -->
			
	        <h3 style="color: gray;">닉네임</h3>
	        <input type="text" class="nickname" placeholder="닉네임 입력" required />
	
	        <h3 style="color: gray;">비밀번호</h3>
	        <div class="password-input2">
	            <input type="password" id="password" placeholder="비밀번호 입력" required disabled />
	        </div>
	        <div class="password-input2">
	            <input type="password" id="confirm-password" placeholder="비밀번호 확인" required disabled />
	        </div>
	        <input type="submit" class="submit-btn" value="약관 동의 후 가입 완료하기">
<!-- 	        <button class="submit-btn">약관 동의 후 가입 완료하기</button> -->
	    </div>
    </form>
</div>

<script type="text/javascript">
	function showAuthInput() {
	    document.getElementById('auth-section').style.display = 'block';
	    document.getElementById('password').disabled = false;
        document.getElementById('confirm-password').disabled = false;
	}
</script>
</body>
</html>