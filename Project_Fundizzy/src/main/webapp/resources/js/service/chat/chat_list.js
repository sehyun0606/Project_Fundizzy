const TYPE_INIT_LIST = "TYPE_INIT_LIST"; // 채팅창 초기화

var ws = opener.ws

// 세션 아이디 저장
const sender_email = $("#sId", opener.document).val();

$(function() {
	// 해당 페이지 선택 표시를 위해 사이드바의 다른 페이지 아이콘 연하게 표시
	$("#people img").css("opacity", "0.3");
	
	
	// 로그인 안되어있을때 로그인 페이지로 이동, 챗 윈도우 클로즈
	if(!sender_email) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "Login";
		window.close();
	}
	
	window.onmessage = (e) => {
		// 전달받은 메세지 데이터 변수에 초기화
		let data = JSON.parse(e.data);
		
		// 타입이 TYPE_INIT_LIST인경우 채팅리스트 출력
		if(data.type == TYPE_INIT_LIST) {
			showChatList(data);
		}
	}
	
	initChatWindow();
	
});

// 채팅창 초기화 메서드
function initChatWindow() {
	let wsCheckInterval = setInterval(() => {
		// 부모창의 웹소켓 객체가 없거나 연결상태가 아닐경우 부모창의 연결 메서드 호출
		if(ws == null || ws.readyState != ws.OPEN) {
			opener.connect();
		} else {
			// 부모창을 통해 메세지를 전송할 sendMessage()함수 호출
			sendMessage(TYPE_INIT_LIST, "", "", "", "");
			
			clearInterval(wsCheckInterval);
		}
	}, 1000);
}

// 부모창의 sendMessage() 함수 호출하여 메세지 전송을 요청하는 함수
function sendMessage(type, sender_email, receiver_email, room_id, message, idx) {
	// 부모창의 sendMessage() 함수 호출
	opener.sendMessage(type, sender_email, receiver_email, room_id, message, idx);
}

// 채팅리스트 출력 메서드
function showChatList(data) {
	// 채팅리스트 출력 영역 초기화
	$("#chatListBoard").empty();
	// 메시지 안의 chatRoomList 파싱
	let chatRoomList = JSON.parse(data.message);
	// 채팅리스트 수 판별 후 표시
	if(chatRoomList.length == 0) {
		
	} else {
		for(let room of chatRoomList) {
			appendChatRoom(room);
		}
	}
}

// 채팅리스트 추가
function appendChatRoom(room) {
	let last_message;
	
	// 마지막 메세지 존재 여부 판단 후 글자수 조절
	if(!room.last_message) {
		last_message = "<br>";
	} else {
		last_message = room.last_message.substring(0, 15) + "...";
	}
	
	let divRoom = 
		`<div class="chatRoom ${room.room_id}">
			<input type="hidden" class="receiver_email" value=${room.receiver_email}>
			<div class="receiverImg">
				<img src="/resources/images/notification/followingIcon.png">
				<span class="messageCount"></span>
			</div>
			<div class="chatRoomInfo">
				<div class="chatRoomTitle">
					${room.title}
				</div>
				<div class="chatLastContent">
					${last_message}
				</div>
				<div class="updateLastTime">
				 	${room.last_accessed_time}
				</div>
			</div>
		</div>`;
					
	// 최신순으로 채팅리스트 추가
	$("#chatListBoard").prepend(divRoom);
	
	// 읽지 않은 메세지 갯수 표시
	if(room.unread_count > 0) {
		$(".chatRoom." + room.room_id).find(".messageCount").text(room.unread_count);
	} else {
		$(".chatRoom." + room.room_id).find(".messageCount").hide();
	}
	
	// 채팅리스트 더블클릭시 해당 채팅방 뉴 윈도우로 오픈
	$(".chatRoom." + room.room_id).on("dblclick", function() {
		// 더블클릭시 부모창의 채팅방 오픈 메서드 호출
		opener.openChatRoomWindow($(this).find(".receiver_email").val());
	});

}
