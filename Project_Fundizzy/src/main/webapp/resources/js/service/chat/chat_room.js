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
	let message = $("#messageBox").val().trim();
	
	// 채팅이 입력되었을 때에만 메세지 전송
	if(message) {
		sendMessage(TYPE_TALK, sEmail, receiver_email, room_id, message);
	}
	
	$("#messageBox").val("");
	$("#messageBox").focus();
}

// 전송된 채팅 실시간 추가 함수
function appendMesage(data) {
	let messageDiv;
	
	// 시스템메시지
	if(data.type == TYPE_SYSTEM) {
		// 메세지내용 span
		let spanMessage = `<span class='messageContent'>${data.message}</span>`
		messageDiv = `<div class='message ${ALIGN_CENTER}'>${spanMessage}</div>`;
	} else {
		// 메세지내용 span
		let spanMessage = `<span class='messageContent'>${data.message}</span><br>`
		
		// 마지막 메세지와 같은 시간:분인지 체크후 같은 시간이면 다음에 메시지 스팬만 추가
		// 시간span은 추가하지 않음
		if(data.sender_email == sEmail && isSameTime(data.send_time, isMyMessage)) {
			
		} else if(data.sender_email != sEmail && isSameTime(data.send_time)) {
			
		}
		
		// 메세지 전송날짜시간
		let date = new Date(data.send_time);
		
		// 현재 시스템 날짜 및 시각 정보 기준으로 Date 객체 생성
		let now = new Date();
		
		// 기본적으로 시:분은 무조건 표시되도록 먼저 전송시각 변수에 저장
		let hour = date.getHours();
		
		// 시간 오전 오후 판별
		if(hour > 12) {
			hour = "오후 " + (hour - 12);
		} else if(hour == 12) {
			hour = "오후 " + hour;
		} else {
			hour = "오전 " + hour;
		}
		
		sendTime =  hour + ":" + date.getMinutes();
		
		// 올해의 오늘이 아닐 경우 날짜 추가
		// 추가로, 메세지 전송일자가 올해가 아니면 연도도 추가
		if(!(date.getFullYear() == now.getFullYear() && date.getMonth() == now.getMonth() && date.getDate() == now.getDate())) {
			sendTime = date.getMonth() + 1 + "월 " + date.getDate() + "일 " + sendTime; 
			
			if(date.getFullYear() != now.getFullYear()) { 
				sendTime = date.getFullYear() + "년 " + sendTime; 
			}
		}
		
		let timeSpan = `<span class="sendTime">${sendTime}</span>`;
		
		// 송신자가 본인일 경우
		if(data.sender_email == sEmail) {
			let lastTime = $("#myLastSendTime").val();
			// 현재 추가할 메세지의 send_time과 마지막 메시지의 send_time과
			// 비교하여 같은 분(시간)이면 메시지 내용만 추가
			messageDiv = `<div class='message ${ALIGN_RIGHT}'><div class="messageDiv3">${spanMessage}${timeSpan}</div></div>`;
			
			// 나의 마지막 메세지 전달 시간 input[type=hidden]에 저장 메서드
			inputLastSendTime(data.send_time, true);
		// 송신자가 상대방일 경우
		} else {
			// 이미지 주소저장할 변수
			let src;
			
			// 마이페이지 프로필 사진설정 유무 판별
			if(receiverInfo.profile) {
				src = "/resources/upload/" + receiverInfo.profile;
			} else {
				src = "/resources/images/chat/profileIcon.png";
			}
			
			// 상대방 프로필 이미지 span
			let receiverImgSpan = `<span class="receiverImg">
										<img src="${src}">
									</span>`;
									
			let receiverNickSpan = `<span class="receiverNickname">
										${receiverInfo.nickname}
									</span><br>`
			
			// 메세지 div
			messageDiv = `<div class='message ${ALIGN_LEFT}'>
								<div class="messageDiv1">
									${receiverImgSpan}
								</div>
								<div class="messageDiv2">
									${receiverNickSpan}
									${spanMessage}
									${timeSpan}
								</div>
							</div>`;
		}
		
		// 상대의 마지막 메세지 전달 시간 input[type=hidden]에 저장 메서드
		inputLastSendTime(data.send_time);
	}
	
	$("#chatMessageArea").append(messageDiv);
	
	// 메시지표시영역 스크롤바 항상 맨 밑으로 유지
	$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
}

// 메시지가 같은시간인지 판별을 위해 "yyyy-MM-dd HH:mm" 패턴으로 input[type=hidde]에 저장
function inputLastSendTime(send_time, isMyMessage) {
	if(isMyMessage) {
		$("#myLastSendTime").val(send_time.substring(0, 16));
	} else {
		$("#otherLastSendTiem").val(send_time.substring(0, 16));
	}
}

function isSameTime(send_time, isMyMessage) {
//	Date sendTime = new Date(send_time.substring(0, 16));
	
	if(isMyMessage) {
		
	}
}