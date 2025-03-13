<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="/resources/css/service/chat/chat_room.css" />
</head>
<body>
	<div id="topBar">
		<div id="topProfileImg">
		</div>
		<div id="titleDiv">
			<div id="roomTitle"></div>
			<div id="topProfileEmail"></div>
		</div>
		<div id="exit">
			<img src="/resources/images/chat/outIcon.png">
			<span id="dropdownMenu" class="closed">
				<button id="closeChatRoom">닫기</button>
				<button id="outChatRoom">채팅<br>종료</button>
			</span>
		</div>
	</div>
	<div id="chatMessageArea">
	</div>
	<div id="chatInputArea">
		<div id="menuBar">
			<label for="file"><img src="/resources/images/chat/clip.png"></label>
			<input type="file" id="file" accept="image/*" onchange="sendFile()">
			<img src="/resources/images/chat/transferIcon.png">
			<input type="button" id="sendBtn" value="전송" onclick="sendInputMessage()">
		</div>
		<div id="chatInput">
			<textarea id="message" maxlength="1000" placeholder="메시지를 입력하여 주세요" onkeyup="checkEnterKey(event)"></textarea>
		</div>
	</div>
	<script src="/resources/js/jquery-3.7.1.js"></script>
	<script src="/resources/js/service/chat/chat_room.js"></script>
</body>
</html>