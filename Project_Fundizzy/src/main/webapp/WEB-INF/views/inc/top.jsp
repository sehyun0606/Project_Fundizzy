<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            font-size: 20px;
            font-weight: bold;
        }
        .nav-links {
            display: flex;
            gap: 15px;
        }
        .nav-links a {
            text-decoration: none;
            color: black;
        }
        .nav-links a.active {
            color: mediumpurple;
        }
        .search-bar {
            border: 1px solid mediumpurple;
            padding: 5px 10px;
            border-radius: 15px;
            width: 300px;
        }
        .auth-links {
            display: flex;
            gap: 10px;
            height: min-content;
        }
        .create-project {
            background-color: mediumpurple;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
        }
        .nav{
        	margin-left: 15%;
        	display: flex;
        	width: 23%;
        	justify-content: space-between;
        	font-size: large;
        }
        .log-in{
        	display: flex;
        	width: 15%;
        	justify-content: space-between;
        	margin-right: 15%;
        	align-items: center;
        }
        .auth-links a{
        	text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="top-menu top-items">
    	<div class="nav top-items">
	        <div class="logo top-items">Fundizzy</div>
	        <div class="nav-links top-items">
	            <b><a href="#" class="active top-items">오픈예정</a></b>
	            <b><a href="#" class="top-items">펀딩</a></b>
	            <b><a href="#" class="top-items">프리오더</a></b>
	            <b><a href="#" class="top-items">도움말센터</a></b>
	        </div>
    	</div>
        <input type="text" class="search-bar  top-items"  placeholder="검색">
        <div class="log-in top-items">
	        <div class="auth-links top-items">
	            <a href="Login" class="top-items">로그인</a>
	            <a href="SignUp" class="top-items">회원가입</a>
	        </div>
	        <a href="#" class="create-project top-items">프로젝트 만들기</a>
        </div>
    </div>
</body>
</html>
