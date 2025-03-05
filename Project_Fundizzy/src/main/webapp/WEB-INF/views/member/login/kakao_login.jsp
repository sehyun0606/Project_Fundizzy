<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오 로그인</title>
</head>
<body>
	카카오 로그인 : 응답<br>
	엑세스 토큰 :${kakaoToken.access_token}<br>
	토큰 타입 : ${kakaoToken.token_type}<br>
	리프레쉬 토큰 : ${kakaoToken.refresh_token}<br>
	익스피레스 : ${kakaoToken.expires_in}<br>
	스코프 : ${kakaoToken.scope}<br>
	토큰 익스프레스 : ${kakaoToken.refresh_token_expires_in}<br>
	
	ID : ${id }
	닉네임 : ${nickname }
	최근 접속 : ${connectedAt }
	
	
	
</body>
</html>
