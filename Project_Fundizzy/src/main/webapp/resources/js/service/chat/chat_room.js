const TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM"; // 채팅방 초기화
const TYPE_TALK = "TYPE_TALK"; // 채팅
const TYPE_ERROR = "TYPE_ERROR" // 채팅 에러
var ws = opener.ws
// 세션 아이디 저장
const sender_email = $("#sId", opener.document).val();
// 리시버 아이디 저장
const room_id = window.name;

$(function() {
	// 로그인 안되어있을때 로그인 페이지로 이동, 챗 윈도우 클로즈
	if(!sender_email) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "Login";
		window.close();
	}
	
	window.onmessage = (e) => {
		// 전달받은 메세지 데이터 변수에 초기화
		let data = JSON.parse(e.data);
		console.log(data);
		
		// 타입이 TYPE_INIT_LIST인경우 채팅리스트 출력
		if(data.type == TYPE_ERROR) {
			alert(data.message);
		}
	}
	
	initChatWindow();
	
	// 버튼 토글형식으로 폴딩 작업 수행
    $("#exit").on("click", function() {
		// 폴딩 열려있을때 버튼 클릭시 작업
        if (!$("#dropdownMenu").hasClass("closed")) {
            $("#dropdownMenu").height(0);
            $("#dropdownMenu").addClass("closed");
		// 폴딩 닫혀있을때 버튼 클릭시 작업
        } else {
            $("#dropdownMenu").height($("#dropdownMenu")[0].scrollHeight);
            $("#dropdownMenu").removeClass("closed");
        }
    });
	
	// 나가기 버튼 클릭시 채팅방 윈도우 닫기
	$("#closeChatRoom").click(function() {
		window.close();
	});
	
	
	// 채팅종료 ~~~~~~~~
	$("#outChatRoom").click(function() {
		if(confirm("채팅을 종료하시면 현재 채팅방의 채팅 내역이 사라집니다.\n채팅을 종료하시겠습니까?")) {
			
		}
	});
	
});

// ------------------------------------------- 함수 ------------------------------------------

// 채팅창 초기화 함수
function initChatWindow() {
	let wsCheckInterval = setInterval(() => {
		// 부모창의 웹소켓 객체가 없거나 연결상태가 아닐경우 부모창의 연결 함수 호출
		if(ws == null || ws.readyState != ws.OPEN) {
			opener.connect();
		} else {
			// 부모창을 통해 메세지를 전송할 sendMessage()함수 호출
			sendMessage(TYPE_INIT_CHATROOM, sender_email, "", room_id, "");
			
			clearInterval(wsCheckInterval);
		}
	}, 1000);
}

// 부모창의 sendMessage() 함수 호출하여 메세지 전송을 요청하는 함수
function sendMessage(type, sender_email, receiver_email, room_id, message, idx) {
	// 부모창의 sendMessage() 함수 호출
	opener.sendMessage(type, sender_email, receiver_email, room_id, message, idx);
}

// 채팅입력창의 엔터키 입력 시 메세지 전달
function checkEnterKey(event) {
	let keyCode = event.keyCode;
		
	if(keyCode == 13) {
		sendInputMessage();
	}
}

// 입력한 채팅 전달
function sendInputMessage() {
	console.log("메시지 전송")
	let message = $("#message").val();
	console.log(message);
//	sendMessage(TYPE_TALK, sender_email, receiver_email, room_id, messsage);
}

