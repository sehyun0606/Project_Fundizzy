// 채팅 메세지 타입 구분을 위한 상수 설정
const TYPE_ENTER = "TYPE_ENTER"; // 입장
const TYPE_LEAVE = "TYPE_LEAVE"; // 퇴장
const TYPE_TALK = "TYPE_TALK"; // 대화

// 채팅 메세지 정렬 위치 구분을 위한 상수 설정
const ALIGN_CENTER = "align_center";
const ALIGN_LEFT = "align_left";
const ALIGN_RIGHT = "align_right";

// => 자식창에서도 접근 가능하도록 전역 변수로 선언하기 위해 var 로 변수 선언
var ws;

// 채팅창(새 창) window 객체를 저장할 변수 선언
var chatWindow;

// 수신자 아이디를 저장할 변수 선언(상대방과 채팅하기 클릭 시)
var receiver_id;

// --------------------------------------------------------------------

$(function() {
	// 채팅방 입장을 위한 웹소켓 연결
	connect();
});

// --------------------------메서드-----------------------------------------------------------
// 채팅창 오픈 메서드
function openChatWindow(receiver_id) {
	chatWindow = window.open('/ChatMain', 'chatWindow',
		'width=400, height=600, top=200, left=1500, status=no, location=no, menubar=no, toolbar=no');
	
	this.receiver_id = receiver_id; 
}

function connect() {
	// 웹소켓 요청 주소 생성
	let ws_base_url = "ws://localhost:8081";
//	let ws_base_url = "ws://c5d2409t1p2.itwillbs.com";
	ws = new WebSocket(ws_base_url + "/echo")
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
}

function onOpen() {
	console.log("onOpen")
}

function onMessage(event) {
	console.log("onMessage");
	
	// 자식창이 연결 되어있을 경우 ponstMessage()로 전송
	if(chatWindow) {
		chatWindow.postMessage(event.data);
	} else {
		// 추후 작업;
	}
}

function onClose() {
	console.log("onClose");
}

function onError() {
	console.log("onError");
}

// 전달받은 데이터를 하나의 json객체 문자열로 변환
function toJsonString(type, sender_id, receiver_id, room_id, message, idx) {
	let data = {type, sender_id, receiver_id, room_id, message, idx}
	return JSON.stringify(data);
}

// 전달받은 메세지를 웹소켓 서버측으로 전송하는 sendMessage() 함수
function sendMessage(type, sender_id, receiver_id, room_id, message, idx) {
	// 웹소켓 객체(ws)의 send() 메서드 호출하여 서버측으로 웹소켓 메세지 전송
	ws.send(toJsonString(type, sender_id, receiver_id, room_id, message, idx));
}

