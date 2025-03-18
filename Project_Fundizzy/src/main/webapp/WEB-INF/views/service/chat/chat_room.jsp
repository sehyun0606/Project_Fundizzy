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
		<span id="rename"><img title="채팅방 이름 변경" src="/resources/images/chat/renameIcon.png"></span>
		<div id="exit">
			<img src="/resources/images/chat/outIcon.png">
			<span id="dropdownMenu" class="closed">
				<button id="closeChatRoom">닫기</button>
				<button id="outChatRoom">채팅<br>종료</button>
			</span>
		</div>
	</div>
	<div id="chatMessageArea">
		<input type="hidden" id="myLastSendTime" value="2000-01-01 00:00">
		<input type="hidden" id="otherLastSendTime" value="2000-01-01 00:00">
		<input type="hidden" id="lastSendMember" >
	</div>
	<div id="chatInputArea">
		<div id="menuBar">
			<label for="file"><img src="/resources/images/chat/clip.png"></label>
			<input type="file" id="file" accept="image/*" onchange="sendFilePreview()" multiple>
<!-- 			<img src="/resources/images/chat/transferIcon.png"> -->
			<input type="button" id="sendBtn" value="전송" onclick="sendInputMessage()">
		</div>
		<div id="chatInput">
			<textarea id="messageBox" maxlength="1000" placeholder="메시지를 입력하여 주세요" onkeyup="checkEnterKey(event)"></textarea>
		</div>
	</div>
	<div id="modalBackground">
		<div id="modalForChangeName">
			<div class="modalTitle">채팅방 이름 변경</div>
			<div>
				<input type="text" class="inputName" placeholder="변경할 채팅방 이름을 입력해주세요" maxlength="20">
				<div class="buttonGroup">
					<input type="button" class="changeBtn" value="변경">
					<input type="button" class="closeBtn" value="닫기">
				</div>
			</div>
		</div>
	</div>
	<script src="/resources/js/jquery-3.7.1.js"></script>
	<script src="/resources/js/service/chat/chat_room.js"></script>
</body>
</html>