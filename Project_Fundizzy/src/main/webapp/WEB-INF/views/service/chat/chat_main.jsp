<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Fundizzy Chat</title>
	<link rel="stylesheet" href="/resources/css/service/chat/chat.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/service/chat/chatSidebar.jsp"/>
	
	<div id="main">
		<div id="chatTop">
			<div id="chatTitle">
				Fundizzy Chat
			</div>
			<div id="memberTitle">
				<div id=myProfileImg></div>
				<div id=myProfile>
					<div id="myNickName"></div>
					<div id="myEmail"></div>
				</div>
			</div>
			<div id="memberSearchBox">
				<input type="text" placeholder="닉네임 또는 이메일을 입력해 주세요">
				<img src="resources/images/chat/searchIcon.png">
			</div>
		</div>
		<div id="chatBody">
			<div id="recentPeople">
				<div class="semiTitle">
					최근 채팅 멤버
					<span class="foldingBtn"></span>
				</div>
				<div class="peopleList">
				</div>
			</div>
			<div id="support">
				<div class="semiTitle">
					나의 서포터
					<span class="foldingBtn"></span>
					<div class="titleDescription">
						(내 프로젝트에 참여, 지지서명한 서포터)
					</div>
				</div>
				<div class="peopleList">
				</div>
			</div>
			<div id="maker">
				<div class="semiTitle">
					메이커
					<span class="foldingBtn"></span>
					<div class="titleDescription">
						(지지서명, 찜 및 참여한 프로젝트의 메이커)
					</div>
				</div>
				<div class="peopleList">
				</div>
			</div>
		</div>
	</div>
	<script src="/resources/js/jquery-3.7.1.js"></script>
	<script src="/resources/js/service/chat/chat_main.js"></script>
</body>
</html>
