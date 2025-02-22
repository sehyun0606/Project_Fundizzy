<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizy 로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #fff;
            margin: 0;
        }
        .logo {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 30px;
            color: mediumpurple;
            cursor: pointer;
        }
        .login-options {
            width: 380px;
            display: flex;
            align-items: center;
            font-size: 15px;
            margin-bottom: 10px;
            justify-content: flex-end;
            color: gray;
        }
        .login-options input {
            margin-right: 5px;
        }
        .login-container {
            text-align: center;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 380px;
            border: 1px solid #ddd;
        }
        .login-container input {
            width: 90%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s; /* 부드러운 전환 효과 추가 */
        }
        .email-login {
            background-color: mediumpurple;
            color: white;
        }
        .email-login:hover {
            background-color: #6a5acd; /* 호버 시 색상 변경 */
            transform: scale(1.02); /* 약간의 확대 효과 */
        }
        .social-login {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            margin-top: 15px;
        }
        .social-login img {
            width: 380px;
            height: auto;
            cursor: pointer;
            transition: transform 0.2s; /* 부드러운 전환 효과 추가 */
        }
        .social-login img:hover {
            transform: scale(1.05); /* 약간의 확대 효과 */
        }
        .social-icons {
            margin-top: 15px;
            display: flex;
            justify-content: center;
        }
        .social-icons img {
            width: 40px;
            height: 40px;
            margin: 0 8px;
            cursor: pointer;
            transition: transform 0.2s; /* 부드러운 전환 효과 추가 */
        }
        .social-icons img:hover {
            transform: scale(1.1); /* 약간의 확대 효과 */
        }
        .link-container {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
        }
        .link-container a {
            text-decoration: none;
            color: gray;
            margin: 0 5px;
            transition: color 0.3s ease; /* 색상 전환 효과 추가 */
        }
        .link-container a:hover {
		    color: mediumpurple; /* 호버 시 색상 변경 */
		}
        
    </style>
</head>
<body>

<h1 class="logo" onclick="location.href='./'">Fundizy</h1>

<div class="login-options">
<!--     <input type="checkbox" id="remember-me"> -->
    <input type="checkbox" id="remember-me" name="rememberId" class="form-check-input" <c:if test="${not empty cookie.rememberId.value}">checked</c:if>>
    <label for="remember-me">로그인 유지</label>
</div>

<div class="login-container">
    <form action="LoginSuccess" method="post">
        <input type="email" name="email" placeholder="이메일 입력" required><br>
        <input type="password" name="password" placeholder="비밀번호 입력" required><br>
        <button type="submit" class="login-btn email-login">이메일로 로그인하기</button>
    </form>

    <div class="social-login">
        <a href="YOUR_KAKAO_LOGIN_URL">
            <img src="${pageContext.request.contextPath}/resources/images/login/kakao_login_custom.png" alt="카카오 로그인 버튼" class="kakao">
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

<div class="link-container">
    <a href="#">아이디/비밀번호 찾기</a> | <a href="SignUp">회원가입</a>
</div>

</body>
</html>
