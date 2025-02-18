<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizzy 로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f8f8;
        }
        .login-container {
            text-align: center;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 350px;
        }
        .login-container h1 {
            font-size: 32px;
            color: #a34db3;
            margin-bottom: 20px;
        }
        .login-container input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
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
        }
        .email-login { background-color: #e99bd2; color: white; }
        .kakao-login { background-color: #fee500; color: black; }
        .naver-login { background-color: #2db400; color: white; }
        .link-container {
            margin-top: 15px;
            font-size: 13px;
            text-align: center;
        }
        .link-container a {
            text-decoration: none;
            color: gray;
            margin: 0 5px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h1>Fundizzy</h1>
    <form action="loginProcess.jsp" method="post">
        <input type="email" name="email" placeholder="이메일 입력" required><br>
        <input type="password" name="password" placeholder="비밀번호 입력" required><br>
        <button type="submit" class="login-btn email-login">이메일로 로그인 하기</button>
    </form>
    <button class="login-btn kakao-login">카카오로 시작하기</button>
    <button class="login-btn naver-login">네이버로 시작하기</button>
</div>

<div class="link-container">
    <a href="#">아이디 / 비밀번호 찾기</a> | <a href="#">회원가입</a>
</div>

</body>
</html>
