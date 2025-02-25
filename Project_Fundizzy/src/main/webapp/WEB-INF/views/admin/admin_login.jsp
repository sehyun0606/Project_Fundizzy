<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizy 로그인</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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
            font-size: 50px;
            font-weight: bold;
            margin-bottom: 0px;
            color: mediumpurple;
            cursor: pointer;
            margin-top: 0px;
        }
        .logo2 {
            font-size: 30px;
            margin-top: 0px;
            margin-bottom: 20px;
            color: purple;
            cursor: pointer;
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
        
    </style>
</head>
<body>

<h1 class="logo" onclick="location.href='./'">Fundizy</h1>
<h2 class="logo2" >Admin</h2>

<form action="adminLoginAction" method="post">
	<div class="login-container">
	    <input type="text" name="admin_id" placeholder="이메일 입력" required><br>
	    <input type="password" name="admin_passwd" placeholder="비밀번호 입력" required><br>
	    <button type="submit" class="login-btn email-login">관리자 로그인하기</button>
	</div>
</form>


</body>
</html>
