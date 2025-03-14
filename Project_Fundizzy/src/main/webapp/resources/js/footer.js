// => 자식창에서도 접근 가능하도록 전역 변수로 선언하기 위해 var 로 변수 선언
var ws;

// 채팅창(새 창) window 객체를 저장할 변수 선언
var chatWindow;

// 채팅방(새 창) window 객체를 저장할 객체 선언
// 채팅창마다의 각각의 window 객체를 저장
var chatRoomWindowObj = {};

const TYPE_REQUEST_UNREADMESSAGE = "TYPE_REQUEST_UNREADMESSAGE"; // 읽지 않은 채팅 메시지 수 조회


$(function() {
	// 채팅방 입장을 위한 웹소켓 연결
	connect();
});

// --------------------------함수-----------------------------------------------------------
// 채팅창 오픈 함수
function openChatWindow() {
	chatWindow = window.open('/ChatMain', 'chatWindow',
		'width=400, height=600, top=200, left=1450, status=no, location=no, menubar=no, toolbar=no');
}

// 채팅방 오픈 함수
// 채팅상대방의 이름으로 윈도우 네임설정
function openChatRoomWindow(receiver_email) {
	// 임시로 채팅방 최소화시 다시 열기위해 윈도우 제거후 다시 생성 
	if(chatRoomWindowObj[receiver_email]) {
		chatRoomWindowObj[receiver_email].close();
	}
	
	chatRoomWindowObj[receiver_email] = window.open('/ChatRoom', receiver_email,
		'width=400, height=600, top=180, left=1300, status=no, location=no, menubar=no, toolbar=no');
}

function connect() {
	// 웹소켓 요청 주소 생성
	ws = new WebSocket("/echo")
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
}

function onOpen() {
	console.log("onOpen")
}

function onMessage(event) {
	// 전달된 메시지 파싱
	let data = JSON.parse(event.data);
	console.log(data);
	
	 //안읽은 채팅을 항시 업데이트하기 위해 읽지않은 채팅 수 조회
	 //단, 전달받은 메시지의 타입이 TYPE_REQUEST_UNREADMESSAGE이 아닐경우에만 실행
	 //TYPE_REQUEST_UNREADMESSAGE일경우 계속 반복
//	if(data.type != TYPE_REQUEST_UNREADMESSAGE) {
//		sendMessage(TYPE_REQUEST_UNREADMESSAGE, sEmail, "", "", "", "");
//	} else {
//		// TYPE_REQUEST_UNREADMESSAGE일 경우 읽지않은 메시지 수 표시
//	}
	
	// 채팅창이 연결 되어있을 경우 postMessage()로 전송
	if(chatWindow) {
		chatWindow.postMessage(event.data);
	}
	
	// 해당 채팅방이 열려있으면 메세지 전달
	if(chatRoomWindowObj[data.receiver_email]) {
		chatRoomWindowObj[data.receiver_email].postMessage(event.data);
		// 상대방과의 채팅방 윈도우의 이름이 상대방의 이메일이므로
		// 상대방이 송신한 채팅을 수신하기위해 sender_email도 윈도우객체의 속성명과 비교하여
		// 메시지 전달
	} else if(chatRoomWindowObj[data.sender_email]) {
		chatRoomWindowObj[data.sender_email].postMessage(event.data);
	}
	
}

function onClose() {
	console.log("onClose");
}

function onError() {
	console.log("onError");
}

// 전달받은 데이터를 하나의 json객체 문자열로 변환
function toJsonString(type, sender_email, receiver_email, room_id, message, idx) {
	let data = {type, sender_email, receiver_email, room_id, message, idx}
	return JSON.stringify(data);
}

// 전달받은 메세지를 웹소켓 서버측으로 전송하는 sendMessage() 함수
function sendMessage(type, sender_email, receiver_email, room_id, message, idx) {
	// 웹소켓 객체(ws)의 send() 메서드 호출하여 서버측으로 웹소켓 메세지 전송
	ws.send(toJsonString(type, sender_email, receiver_email, room_id, message, idx));
}
