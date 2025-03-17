const TYPE_INIT_LIST = "TYPE_INIT_LIST"; // 채팅창 초기화
const TYPE_TALK = "TYPE_TALK"; // 채팅
const TYPE_SYSTEM = "TYPE_SYSTEM"; // 시스템메시지
const TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM"; // 채팅방 초기화
const TYPE_LEAVE = "TYPE_LEAVE"; // 채팅방 퇴장
const TYPE_CHANGE_ROOMNAME = "TYPE_CHANGE_ROOMNAME"; // 채팅방 퇴장
const TYPE_FILE = "TYPE_FILE"; // 이미지 파일 전송

// 세션 아이디 저장
const sEmail = $("#sId", opener.document).val();

$(function() {
	// 해당 페이지 선택 표시를 위해 사이드바의 다른 페이지 아이콘 연하게 표시
	$("#people img").css("opacity", "0.3");
	
	// 로그인 안되어있을때 로그인 페이지로 이동, 챗 윈도우 클로즈
	if(!sEmail) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "Login";
		window.close();
	}
	
	$(".messageTotalCount").hide();
	
	window.onmessage = (e) => {
		// 전달받은 메세지 데이터 변수에 초기화
		let data = JSON.parse(e.data);
		console.log(data);
		
		// 타입이 TYPE_INIT_LIST인경우 채팅리스트 출력
		if(data.type == TYPE_INIT_LIST) {
			showChatList(data);
		// 타입이 TYPE_TALK인경우 채팅리스트의 정보 변경
		} else if(data.type == TYPE_TALK || data.type == TYPE_SYSTEM || data.type == TYPE_FILE) {
			updateChatList(data);
		// 타입이 TYPE_INIT_CHATROOM일 경우 해당 채팅방의
		// 읽지않은 메세지가 읽음 처리되므로 해당 방의 읽지않은
		// 메세지 수 초기화
		} else if(data.type == TYPE_INIT_CHATROOM) {
			// 채팅방을 열어서 읽음처리 된 채팅의 수
			let readCount = parseInt($(".chatRoom." + data.room_id).find(".messageCount").text());
			// 읽음 처리된 채팅 수 총 채팅 수에서 제거
			$(".messageTotalCount").text(parseInt($(".messageTotalCount").text()) - readCount).change();
			$(".chatRoom." + data.room_id).find(".messageCount").text(0).change();
		// 채팅방 퇴장시 해당채팅방 리스트에서 제거
		} else if(data.type == TYPE_LEAVE) {
			$(".chatRoom." + data.room_id).remove();
		} else if(data.type == TYPE_CHANGE_ROOMNAME) {
			$(".chatRoom." + data.room_id).find(".chatRoomTitle").text(data.message);
		}
	}
	
	initChatWindow();
	
	// 각 방의 메시지 카운트 체인지 이벤트 헨들링
	$(document).on("change", ".messageCount", function() {
	    if(parseInt($(this).text()) == 0) {
	        $(this).hide();
	    } else {
	        $(this).show();
		}
	});
	
	// 총 읽지않은 메시지 카운트 체인지 이벤트 헨들링
	$(".messageTotalCount").change(function() {
	    if(parseInt($(this).text()) == 0) {
	        $(this).hide();
	    } else {
	        $(this).show();
		}
	});
	
	// 채팅리스트의 닉네임 or 이메일 검색
	$("#memberSearchBox input").keyup(function() {
		// 입력한 검색값
		let inputKeyword = $(this).val();
		
		// 널스트링이거나 여백일경우 전체 표시
		if(inputKeyword.trim() == "") {
			$(".chatRoom").css("display", "flex");
			return;
		}
		
		// 각 사람 리스트 디브에 해당 키워드 존재하는지 판별후
		// 노출 및 숨김 처리
		$(".chatRoom").each(function() {
			if($(this).text().trim().includes(inputKeyword)) {
				$(this).css("display", "flex");
			} else {
				$(this).css("display", "none");
			}
		});
	});
	
});

// 채팅창 초기화 메서드
function initChatWindow() {
	let wsCheckInterval = setInterval(() => {
		// 부모창의 웹소켓 객체가 없거나 연결상태가 아닐경우 부모창의 연결 메서드 호출
		if(opener.ws == null || opener.ws.readyState != opener.ws.OPEN) {
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
	if(chatRoomList.length != 0) {
		for(let room of chatRoomList) {
			appendChatRoom(room);
		}
	}
}

// 채팅리스트 추가
function appendChatRoom(room) {
	
	// 채팅방의 상대방 정보
	let receiverInfo = JSON.parse(room.receiverInfo);
	
	// 마지막 메세지 존재 여부 판단 후 글자수 조절
	let last_message = formatLastMessage(room.last_message);
	
	let last_accessed_time = formatLastAccessedTime(room.last_accessed_time);
	
	// 이미지 주소저장할 변수
	let src;
	
	// 마이페이지 프로필 사진설정 유무 판별
	if(receiverInfo.profile) {
		src = "/resources/upload/" + receiverInfo.profile;
	} else {
		src = "/resources/images/chat/profileIcon.png";
	}
	
	let divRoom = 
		`<div class="chatRoom ${room.room_id}" ondblclick="openChatRoom('${room.receiver_email}')">
			<div class="receiverImg">
				<img src="${src}">
				<span class="messageCount">0</span>
			</div>
			<div class="chatRoomInfo">
				<div class="chatRoomTitle">
					${room.title}
				</div>
				<div class="chatLastContent">
					${last_message}
				</div>
				<div class="updateLastTime">
				 	${last_accessed_time}
				</div>
			</div>
		</div>`;
					
	// 최신순으로 채팅리스트 추가
	$("#chatListBoard").prepend(divRoom);
	
	
	// 읽지 않은 메세지 갯수 표시
	if(room.unread_count > 0) {
		$(".chatRoom." + room.room_id).find(".messageCount").text(room.unread_count).change();
	} else {
		$(".chatRoom." + room.room_id).find(".messageCount").hide();
	}
	
	// 총 읽지 않은 메세지 수 추가
	// 각 방의 목록을 추가하면서 각 방의 읽지않은 메세지 수 총 읽지 않은 메세지 수에 추가
	let totalCount = parseInt($(".messageTotalCount").text()) + room.unread_count;
	$(".messageTotalCount").text(totalCount).change();
}

// 채팅수신시 실시간 채팅리스트에 표시된 정보 변경
function updateChatList(data) {
	// 변경할 마지막메세지 저장할 변수
	let updateMessage;
	
	if(data.type == TYPE_FILE) {
		updateMessage = "(사진파일)";
	} else {
		updateMessage = formatLastMessage(data.message);
	}
	
	// 기존에 존재하지않고 새로 추가된 방일 경우 해당방의 정보 리스트에 추가
	if($(".chatRoom." + data.room_id).length == 0 && data.type != TYPE_SYSTEM && data.sender_email != sEmail) {
		// 이미지 주소저장할 변수
		let src;
		
		// 마이페이지 프로필 사진설정 유무 판별
		if(JSON.parse(data.myInfo).profile) {
			src = "/resources/upload/" + data.myInfo.profile;
		} else {
			src = "/resources/images/chat/profileIcon.png";
		}
		
		// 실시간으로 추가할 채팅방 div
		let divRoom = 
			`<div class="chatRoom ${data.room_id}" ondblclick="openChatRoom('${data.sender_email}')">
				<div class="receiverImg">
					<img src="${src}">
					<span class="messageCount">1</span>
				</div>
				<div class="chatRoomInfo">
					<div class="chatRoomTitle">
						${JSON.parse(data.myInfo).nickname}님과의 채팅방
					</div>
					<div class="chatLastContent">
						${updateMessage}
					</div>
					<div class="updateLastTime">
					 	${formatLastAccessedTime(data.send_time)}
					</div>
				</div>
			</div>`;
			
		$("#chatListBoard").prepend(divRoom);
	} else {
		// 마지막 메세지 정보변경
		$(".chatRoom." + data.room_id).find(".chatLastContent").text(updateMessage);
		
		// 마지막 채팅방 접속시간 변경
		let last_accessed_time = formatLastAccessedTime(data.send_time);
		$(".chatRoom." + data.room_id).find(".updateLastTime").text(last_accessed_time);
		
	}
	
	// 해당 채팅방이 열려있지않을 시에만 읽지 않은 메세지 수 변경
	if(!opener.chatRoomWindowObj[data.sender_email]) {
        // 읽지 않은 메세지수 변경
		if(data.sender_email != sEmail) {
			// 각 방의 읽지않은 메세지 수 변경
			let countSpan = $(".chatRoom." + data.room_id).find(".messageCount");
			let count = parseInt(countSpan.text());
			countSpan.text(count + 1).change();
			
			// 총 읽지 않은 메세지 수 변경
			$(".messageTotalCount").text(parseInt($(".messageTotalCount").text()) + 1).change();
		}
	}
	
	// 해당 메세지 방 디브 위치를 최상단으로 이동
	let updateRoom = $(".chatRoom." + data.room_id);
	updateRoom.remove();
	$("#chatListBoard").prepend(updateRoom);
}

// 채팅리스트 더블클릭시 해당 채팅방 뉴 윈도우로 오픈
function openChatRoom(receiver_email) {
	// 부모창의 뉴윈도우오픈 함수 실행
	opener.openChatRoomWindow(receiver_email);
}

// 마지막 메세지 존재 여부 판단 후 글자수 조절 메서드
function formatLastMessage(message) {
	
	if(!message) {
		last_message = "<br>";
	} else {
		last_message = message.length < 15 ? message : message.substring(0, 15) + "...";
	}
	
	return last_message
}

function formatLastAccessedTime(lastAccessedTime) {
	// 메세지 전송날짜시간
	let date = new Date(lastAccessedTime);
	
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
	
	last_accessed_time =  hour + ":" + date.getMinutes();
	
	// 올해의 오늘이 아닐 경우 날짜 추가
	// 추가로, 메세지 전송일자가 올해가 아니면 연도도 추가
	if(!(date.getFullYear() == now.getFullYear() && date.getMonth() == now.getMonth() && date.getDate() == now.getDate())) {
		last_accessed_time = date.getMonth() + 1 + "월 " + date.getDate() + "일 " + last_accessed_time; 
		
		if(date.getFullYear() != now.getFullYear()) { 
			last_accessed_time = date.getFullYear() + "년 " + last_accessed_time; 
		}
	}
	
	return last_accessed_time;
}
