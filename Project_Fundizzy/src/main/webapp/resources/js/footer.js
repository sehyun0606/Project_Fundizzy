const TYPE_TALK = "TYPE_TALK";
const TYPE_FILE = "TYPE_FILE";
const TYPE_SYSTEM = "TYPE_SYSTEM";
const TYPE_INIT = "TYPE_INIT";
const TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM";
const REQUEST_NOTIFICATION_UNREAD = "REQUEST_NOTIFICATION_UNREAD"

// => 자식창에서도 접근 가능하도록 전역 변수로 선언하기 위해 var 로 변수 선언
var ws;

// 채팅창(새 창) window 객체를 저장할 변수 선언
var chatWindow;

// 채팅방(새 창) window 객체를 저장할 객체 선언
// 채팅창마다의 각각의 window 객체를 저장
var chatRoomWindowObj = {};

const sEmail = $("#sId").val();

$(function() {
	if(sEmail) {
		// 채팅방 입장을 위한 웹소켓 연결
		connect();
	}
	
	let wsCheckInterval = setInterval(() => {
		if(ws.readyState == ws.OPEN) {
			// ws연결되면 읽지않은 카운트 수 조회후 표시
			sendMessage(TYPE_INIT, "", "", "", "");
			sendMessage(REQUEST_NOTIFICATION_UNREAD,"", "", "", "");
			
			clearInterval(wsCheckInterval);
		}
	}, 1000);
	
	// 읽지않은 채팅수 표시 후 개수 판별후 해당span 감춤여부 판별
	$(".messageCount").change(function() {
		if(parseInt($(this).text()) == 0) {
	        $(this).hide();
	    } else {
	        $(this).css("display", "flex");
		}
	});
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
	
	// 메세지 전송시 채팅방열려있는지 판별후 해당 채팅방 닫겨있으면
	// 윈도우 객체 저장해놓은 객체에서 제거
	// - 수신자가 본인인 채팅방이 열려있을시에 메시지를 수신받으면
	//   해당 방의 읽지않은 메세지 카운트가 늘어나면 안되는데 
	//   다른 윈도우인 채팅창윈도우에 읽지않은 표시카운트가 늘어나는걸 방지
	//   (채팅 전송시 DB에 기본적으로 읽지않음으로 저장하고
	//	  TYPE_INIT_CHATROOM 타입일때 즉, 해당 채팅방에 접근할때에
	//    메시지 읽음 처리하고, 실시간으로 오는 채팅은 기존에 표시된 카운트의
	//    개수를 기준으로 더하고 빼기때문, 이 개수를 더하고 빼는 작업을할떄
	//    해당 채팅방 접속 유무를 판단하기위해 해당윈도우가 닫겨있으면 
	//    객체에서 제거)
	if(!chatRoomWindowObj[data.sender_email] || chatRoomWindowObj[data.sender_email].closed) {
		delete chatRoomWindowObj[data.sender_email]
	}
	
	// 윈도우 초기화시 읽지않은 메세지 수 표시
	if(data.type == TYPE_INIT) {
		$(".messageCount").text(data.read_state).change();
	} else if(data.type == TYPE_TALK || data.type == TYPE_SYSTEM || data.type == TYPE_FILE) {
		// 채팅송신자가 본인이아니고 해당 대화방이 열려있지 않을때
		// 총 읽지않은 메세지 수 변경(해당 방이 열려있으면 읽었다는 의미)
		if(data.sender_email != sEmail && !chatRoomWindowObj[data.sender_email]) {
			$(".messageCount").text(parseInt($(".messageCount").text()) + 1).change();
		}
		
	// 채팅방 입장시 해당 채팅방의 읽음처리된 메세지수 처리
	} else if(data.type == TYPE_INIT_CHATROOM) {
		$.ajax({
			type : "POST",
			url : "RequestUnreadCount"
		}).done(function(result) {
			if(data.sender_email == sEmail) {
				$(".messageCount").text(result).change();
			}
		})
	// ws객체 연결시 읽지않은 알림 수 조회
	} else if(data.type == REQUEST_NOTIFICATION_UNREAD) {
		if(".notificationCount" && data.read_state != 0) {
			$(".notificationCount").css("display", "flex");
			$(".notificationCount").text(data.read_state);
		}
	}
	
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
