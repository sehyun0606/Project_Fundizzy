const TYPE_INIT_MAIN = "TYPE_INIT_MAIN";
const TYPE_TALK = "TYPE_TALK";
const TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM";

var ws = opener.ws;
const sEmail = $("#sId", opener.document).val();

$(function() {
	// 로그인 안되어있을때 로그인 페이지로 이동, 챗 윈도우 클로즈
	if(!sEmail) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "Login";
		window.close();
	}
	
	$(".messageTotalCount").hide();
	
	initChatWindow();
	
	window.onmessage = (e) => {
		// 전달받은 메세지 데이터 변수에 초기화
		let data = JSON.parse(e.data);
		
		// 타입이 TYPE_INIT_MAIN인경우 회원정보 및 메이커, 서포터 정보 채팅창메인에 출력
		if(data.type == TYPE_INIT_MAIN) {
			// 메세지안의 정보들 변수에 저장
			let myInfo = JSON.parse(data.myInfo)
			let message = JSON.parse(data.message);
			let makerList = message.makerList;
			let supportList = message.supportList;
			let recentlyChatMemberList = message.recentlyChatMemberList;
			
			//회원정보 채팅메인창에 표시
			$("#myNickName").text(myInfo.nickname);
			$("#myEmail").text(myInfo.email);
			
			//채팅메인창 상단의 이미지 표시
			let src = myInfo.profile ? "/resources/upload/" + myInfo.profile : "/resources/images/chat/profileIcon.png";
			let imgTag = "<img src='" + src + "'>"
			$("#myProfileImg").append(imgTag);
			
			//채팅 회원목록 추가 메서드
			appendChatMember(makerList, supportList, recentlyChatMemberList);
			
			//채팅 회원목록 추가 완료 후 폴딩 펼침
			//(scrollHeight 측정을 위해 회원목록 추가 작업 완료 후 작업)
			$('.foldingBtn').each(function() {
			    const peopleList = $(this).parent().siblings(".peopleList");

			    peopleList.height(peopleList[0].scrollHeight);
			    $(this).text("▼");
			});
			
			// 초기화시 읽지않은 메세지 수 사이드바에 표시
			$(".messageTotalCount").text(data.read_state).change();
		} else if(data.type == TYPE_TALK) {
			// 총 읽지않은 메세지수 변경
			if(data.sender_email != sEmail) {
				// 총 읽지 않은 메세지 수 변경
				$(".messageTotalCount").text(parseInt($(".messageTotalCount").text()) + 1).change();
			}
		// 타입이 TYPE_INIT_CHATROOM일 경우 해당 채팅방의
		// 읽지않은 메세지가 읽음 처리되므로 해당 방의 읽지않은
		// 메세지 수 초기화
		} else if(data.type == TYPE_INIT_CHATROOM) {
			console.log(data.read_state + "ㅋㅋㅋㅋ");
			// 읽음 처리된 채팅 수 총 채팅 수에서 제거
			$(".messageTotalCount").text(parseInt($(".messageTotalCount").text()) - data.read_state).change();
		}
		
	}
	
	// 해당 페이지 선택 표시를 위해 사이드바의 다른 페이지 아이콘 연하게 표시
	$("#chatRoom img").css("opacity", "0.3");
	
	// 총 읽지않은 메시지 카운트 체인지 이벤트 헨들링
	$(".messageTotalCount").change(function() {
	    if(parseInt($(this).text()) == 0) {
	        $(this).hide();
	    } else {
	        $(this).show();
		}
	});
	
	// 채팅메인 페이지의 채팅상대리스트 폴딩 작업
	$('.foldingBtn').each(function() {
	    const peopleList = $(this).parent().siblings(".peopleList");

		// 버튼 토글형식으로 폴딩 작업 수행
	    $(this).on("click", function() {
			// 폴딩 열려있을때 버튼 클릭시 작업
	        if (!peopleList.hasClass("closed")) {
	            peopleList.height(0);
	            $(this).text("▲");
	            peopleList.addClass("closed");
			// 폴딩 닫혀있을때 버튼 클릭시 작업
	        } else {
	            peopleList.height(peopleList[0].scrollHeight);
	            $(this).text("▼");
	            peopleList.removeClass("closed");
	        }
	    });
	});
	

});

// 채팅창 초기화 메서드
function initChatWindow() {
	let wsCheckInterval = setInterval(() => {
		// 부모창의 웹소켓 객체가 없거나 연결상태가 아닐경우 부모창의 연결 메서드 호출
		if(ws == null || ws.readyState != ws.OPEN) {
			opener.connect();
		} else {
			// 부모창을 통해 메세지를 전송할 sendMessage()함수 호출
			sendMessage(TYPE_INIT_MAIN, "", "", "", "");
			
			clearInterval(wsCheckInterval);
		}
	}, 1000);
}

// 부모창의 sendMessage() 함수 호출하여 메세지 전송을 요청하는 함수
function sendMessage(type, sender_email, receiver_email, room_id, message, idx) {
	// 부모창의 sendMessage() 함수 호출
	opener.sendMessage(type, sender_email, receiver_email, room_id, message, idx);
}

// 채팅창메인에 채팅멤버 추가 메서드
function appendChatMember(makerList, supportList, recentlyChatMemberList) {
	// 최근 채팅 멤버중 5명 최근 채팅 목록에 추가
	for(let member of recentlyChatMemberList) {
		$("#recentPeople .peopleList").append(makeDivForAppendMember(member));
	}
	
	// 메이커 회원 목록 추가
	for(let maker of makerList) {
		$("#maker .peopleList").append(makeDivForAppendMember(maker));
	}
	
	// 서포터 회원 목록 추가
	for(let support of supportList) {
		$("#support .peopleList").append(makeDivForAppendMember(support));
	}
}

// 채팅멤버 추가시 필요한 div 생성 메서드
function makeDivForAppendMember(people) {
	// 회원의 프로필 이미지 주소
	let src = people.profile ? "/resources/upload/" + people.profile : "/resources/images/chat/profileIcon.png";
	
	let peopleDiv = `<div class="people" ondblclick="openChatRoom('${people.email}')">
						<div class="peopleImg"><img src="${src}"></div>
						<div class=peopleProfile>
							<div class="peopleNickName">${people.nickname}</div>
							<div class="peopleEmail">(${people.email})</div>
						</div>
					</div>`;
	return peopleDiv
}

function openChatRoom(receiver_email) {
	// 부모창의 채티방오픈 함수 호출
	opener.openChatRoomWindow(receiver_email);
}
