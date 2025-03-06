<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이드 바</title>
</head>
<body>

	<div class="sidebar">
		<h2 onclick="location.href='adminHome'">관리자 홈</h2>
		<div class="menu">
			사용자 관리	
		</div>
		<ul class="submenu">
			<li onclick="location.href='memberManage'">회원 관리</li>
			<li onclick="location.href='adminManage'">관리자 관리</li>
		</ul>
		<div class="menu">
			프로젝트 관리
		</div>
		<ul class="submenu">
			<li>프로젝트 추가</li>
			<li>프로젝트 목록</li>
			<li>프로젝트 상태 관리</li>
		</ul>
		<div class="menu">
			결제 방법 관리
		</div>
		<ul class="submenu">
			<li>결제 수단 추가</li>
			<li>결제 내역</li>
		</ul>
		<div class="menu">
			커뮤니티 관리
		</div>
		<ul class="submenu">
			<li>게시물 관리</li>
			<li>댓글 관리</li>	
		</ul>
		<div class="menu" onclick="location.href='adminLogout'">
			로그아웃
		</div>
	</div>
	<!-- sidebar.js -->
	<script src="resources/js/admin/main/sidebar.js"></script>
</body>
</html>
