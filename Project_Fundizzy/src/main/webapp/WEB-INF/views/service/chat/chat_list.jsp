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
		<div id="chatListTop">
			<div id="chatListTitle">
				채팅 리스트
			</div>
			<div id="memberSearchBox">
				<input type="text" placeholder="닉네임 또는 이메일을 입력해 주세요">
				<img src="resources/images/chat/searchIcon.png">
			</div>
		</div>
		<div id="chatListBoard">
			<c:forEach begin="1" end="10">
				<div class="chatRoom">
					<div class="receiverImg">
						<img src="/resources/images/notification/followingIcon.png">
						<span class="messageCount">3</span>
					</div>
					<div class="chatRoomInfo">
						<div class=chatRoomTitle>
							"뽀로로"님과의 대화방
						</div>
						<div class="chatLastContent">
							마지막 채팅 내용 라라라
						</div>
						<div class="updateLastTime">
						 	2025-02-13 11:20
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<script src="/resources/js/jquery-3.7.1.js"></script>
	<script src="/resources/js/service/chat/chat_list.js"></script>
	<script src="/resources/js/service/chat/chat_window.js"></script>
</body>
</html>
