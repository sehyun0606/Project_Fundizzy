<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizzy</title>
    <style>
        .top-items {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            color: mediumpurple;
        }
        body {
            font-family: Arial, sans-serif;
        }
        .top-menu {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
            height: 60px;
        }
        .logo {
            font-size: 30px;
            font-weight: bold;
            color: mediumseagreen;
            cursor: pointer;
        }
        .auth-links {
            display: flex;
            gap: 10px;
            height: min-content;
        }
        .auth-links a {
            text-decoration: none;
            color: black;
        }
        .login-links {
		    font-size: large;
		    display: flex;
		    justify-content: flex-end;
		    gap: 10px;
		    margin-right: 20px;
		    align-items: center;
        }
    </style>
</head>
<body>
    <div class="top-menu top-items">
        <!-- 로고 div 왼쪽 끝 -->
        <div class="logo top-items" onclick="location.href='./'">Fundizzy</div>

        <!-- 로그인|회원가입 div 오른쪽 끝 -->
        <div class="login-links">
			<a class="login-item" >관리자</a> |
			<a class="login-item" >${sessionScope.adminId}님</a>
        </div>
    </div>
</body>
</html>
