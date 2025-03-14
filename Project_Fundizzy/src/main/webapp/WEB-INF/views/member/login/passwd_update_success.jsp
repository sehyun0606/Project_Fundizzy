<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff;
        }
        .container {
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 30px;
            color: mediumpurple;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: mediumpurple;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #6a5acd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">Fundizzy</div>

            <button class="btn" onclick="location.href='Login'">로그인 하러가기</button>
            <button class="btn" onclick="location.href='./'">홈</button>
    </div>
</body>
</html>
