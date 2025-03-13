const TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM"; // 채팅방 초기화
const TYPE_START = "TYPE_START" // 채팅시작
const TYPE_TALK = "TYPE_TALK"; // 채팅
const TYPE_ERROR = "TYPE_ERROR" // 채팅 에러
const TYPE_SYSTEM = "TYPE_SYSTEM" // 채팅 시습템 메세지

// 채팅 메세지 정렬 위치 구분을 위한 상수 설정
const ALIGN_CENTER = "align_center";
const ALIGN_LEFT = "align_left";
const ALIGN_RIGHT = "align_right";

var ws = opener.ws
// 세션 아이디 저장
const sEmail = $("#sId", opener.document).val();
// 리시버 아이디 저장
const receiver_email = window.name;
// 채팅방 아이디 저장
let room_id;
let receiverInfo;

$(function() {
	// 로그인 안되어있을때 로그인 페이지로 이동, 챗 윈도우 클로즈
	if(!sEmail) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "Login";
		window.close();
	}
	
	window.onmessage = (e) => {
		// 전달받은 메세지 데이터 변수에 초기화
		let data = JSON.parse(e.data);
		console.log(data);
		
		// 처음 만들어진 채팅방인 경우 채팅방아이디 존재 안함 존재할 경우 room_id 변수에 저장
		if(data.room_id) {
			room_id = data.room_id
		}
		
		// 타입이 TYPE_INIT_CHATROOM인경우 채팅리스트 출력
		if(data.type == TYPE_INIT_CHATROOM) {
			// 상대방 정보
			receiverInfo = JSON.parse(data.otherInfo);
			
			// 채팅창에 상대방 정보 출력
			$("#roomTitle").text(receiverInfo.nickname + "님과의 대화방");
			$("#topProfileEmail").text("("+ receiverInfo.email +")");
			// 프로필 사진 저장되어있으면 해당 사진 표시
			if(receiverInfo.profile) {
				$("#topProfileImg").append("<img src='/resources/upload/" + receiverInfo.profile + "'>");
			} else {
				$("#topProfileImg").append('<img src="/resources/images/chat/profileIcon.png">');
			}
			
			// 기존 채팅내용 추가
			let messageList = JSON.parse(data.message);
			
			for(let message of messageList) {
				appendMesage(message);
			}
			
			// 타입이 에러일경우 에러메세지 출력후 윈도우 클로즈
		} else if(data.type == TYPE_ERROR) {
			alert(data.message);
			window.close();
		} else if(data.type == TYPE_SYSTEM || data.type == TYPE_TALK) {
			appendMesage(data);
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
			sendMessage(TYPE_INIT_CHATROOM, sEmail, receiver_email, "", "");
			
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
	let message = $("#message").val().trim();
	
	// 채팅이 입력되었을 때에만 메세지 전송
	if(message) {
		sendMessage(TYPE_TALK, sEmail, receiver_email, room_id, message);
	}
	
	$("#message").val("");
	$("#message").focus();
}

// 전송된 채팅 실시간 추가 함수
function appendMesage(data) {
	let messageDiv;
	
	// 시스템메시지
	if(data.type == TYPE_SYSTEM) {
		// 메세지내용 span
		let spanMessage = `<span class='messageContent'>&lt;${data.message}&gt;</span>`
		messageDiv = `<div class='message ${ALIGN_CENTER}'>${spanMessage}</div>`;
	} else {
		// 메세지내용 span
		let spanMessage = `<span class='messageContent'>${data.message}</span>`
		
		// 메세지 전송날짜시간
		let date = new Date(data.send_time);
		
		// 현재 시스템 날짜 및 시각 정보 기준으로 Date 객체 생성
		let now = new Date();
		
		// 기본적으로 시:분은 무조건 표시되도록 먼저 전송시각 변수에 저장
		sendTime = date.getHours() + "시 " + date.getMinutes() + "분";
		
		// 올해의 오늘이 아닐 경우 날짜 추가
		// 추가로, 메세지 전송일자가 올해가 아니면 연도도 추가
		if(!(date.getFullYear() == now.getFullYear() && date.getMonth() == now.getMonth() && date.getDate() == now.getDate())) {
			sendTime = date.getMonth() + 1 + "월 " + date.getDate() + "일 " + sendTime; 
			
			if(date.getFullYear() != now.getFullYear()) { 
				sendTime = date.getFullYear() + "년 " + sendTime; 
			}
		}
		
		let timeSpan = `<span class="sendTime">${sendTime}</span>`;
		
		// 수신자가 본인일 경우
		if(data.sender_email == sEmail) {
			messageDiv = `<div class='message ${ALIGN_RIGHT}'>${spanMessage}${timeSpan}</div>`;
		// 수신자가 상대방일 경우
		} else {
			// 이미지 주소
			let src;
			if(receiverInfo.profile) {
				src = "/resources/upload/" + receiverInfo.profile;
			} else {
				src = "/resources/images/chat/profileIcon.png";
			}
			let receiverProfileDiv = `<div class="receiverProfile">
										<span class="receiverImg">
											<img src="${src}">
										<span>
										<span class="receiverNickname">
											${receiverInfo.nickname}
										</span>
									</div>`;
			
			messageDiv = `<div class='message ${ALIGN_LEFT}'>${receiverProfileDiv}${spanMessage}${timeSpan}</div>`;
		}
	}
	
	$("#chatMessageArea").append(messageDiv);
}

