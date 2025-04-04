const TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM"; // 채팅방 초기화
const TYPE_START = "TYPE_START" // 채팅시작
const TYPE_TALK = "TYPE_TALK"; // 채팅
const TYPE_ERROR = "TYPE_ERROR" // 채팅 에러
const TYPE_SYSTEM = "TYPE_SYSTEM" // 채팅 시습템 메세지
const TYPE_LEAVE = "TYPE_LEAVE"; // 채팅방 떠남
const TYPE_CHANGE_ROOMNAME = "TYPE_CHANGE_ROOMNAME"; // 채팅방 이름 변경
const TYPE_FILE = "TYPE_FILE"; // 이미지파일 전송


// 채팅 메세지 정렬 위치 구분을 위한 상수 설정
const ALIGN_CENTER = "align_center";
const ALIGN_LEFT = "align_left";
const ALIGN_RIGHT = "align_right";

// 세션 아이디 저장
const sEmail = $("#sId", opener.document).val();
// 리시버 아이디 저장
const receiver_email = window.name;
// 채팅방 아이디 저장
let room_id;
let receiverInfo;

// 파일 저장배열
let fileArray = [];

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
			
			// 상대방이 나간 방인 경우 채팅방 비활성화
			if(parseInt(data.room_status) == 2) {
				$("#menuBar").css("display", "none");
				$("#messageBox").val("해당 채팅방은 비활성화 되었습니다.\n채팅방 내용 읽기만 가능합니다.").prop("readOnly", true);
				
			} 
		// 타입이 에러일경우 에러메세지 출력후 윈도우 클로즈
		} else if(data.type == TYPE_ERROR) {
			alert(data.message);
			window.close();
		// 타입이 시스템 or 타입이 토크인경우 메세지 표시
		} else if(data.type == TYPE_SYSTEM || data.type == TYPE_TALK || data.type == TYPE_FILE) {
			appendMesage(data);
		} else if(data.type == TYPE_CHANGE_ROOMNAME) {
			$("#roomTitle").text(data.message);
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
	
	// 채팅방 이름변경 모달 오픈
	$("#rename img").click(function() {
		$("#modalBackground").css("display", "block");
		$("#modalForChangeName").css("display", "block");
	});
	
	// 채팅방 이름변경 모달 닫기
	$(".closeBtn").click(function() {
		closeReNameModal();
	});
	
	// 채팅방 이름변경
	$(".changeBtn").click(function() {
		if($(".inputName").val() == "") {
			alert("채팅방 이름을 입력해주세요!");
			return;
		}
		
		if(confirm("<" + $(".inputName").val() + ">로\n채팅방 이름이 변경됩니다")) {
			sendMessage(TYPE_CHANGE_ROOMNAME, sEmail, receiver_email, room_id, $(".inputName").val());
		}
		
		closeReNameModal();
	});
	
	// 나가기 버튼 클릭시 채팅방 윈도우 닫기
	$("#closeChatRoom").click(function() {
		window.close();
	});
	
	// 채팅종료
	$("#outChatRoom").click(function() {
		if(confirm("채팅을 종료하시면 현재 채팅방의 채팅 내역이 사라집니다.\n채팅을 종료하시겠습니까?")) {
			sendMessage(TYPE_LEAVE, sEmail, receiver_email, room_id, "");
			window.close();
		}
	});
	
	// preview이미지 버튼 클릭시 해당 이미지 preview에서 삭제
	$(document).on("click", ".deleteImg", function () {
	    let index = $(this).data("index");
	    removeImgInPreview(index);
	});

	// 채팅메시지의 이미지 사진 클릭시 새창으로 확대
	$(document).on("click", ".chat_img img", function () {
		url = $(this).attr("class");
	    window.open(url, url, "width=600, height=600, top=100, left=750");
	});
	
});

// ------------------------------------------- 함수 ------------------------------------------

// 채팅창 초기화 함수
function initChatWindow() {
	let wsCheckInterval = setInterval(() => {
		// 부모창의 웹소켓 객체가 없거나 연결상태가 아닐경우 부모창의 연결 함수 호출
		if(opener.ws == null || opener.ws.readyState != opener.ws.OPEN) {
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
		// 마지막메세지 송신자
		lastSender = $("#lastSendMember").val();
		
		let spanMessage;
		// 채팅 메시지
		if(data.type == TYPE_TALK) {
			// 메세지내용 span
			spanMessage = `<span class='messageContent'>${data.message}</span><br>`
		// 이미지 파일전송
		} else {
			let hrefUrl = "/resources/upload/" + data.message.split(":")[0]; // 원본 이미지 경로
			let imgUrl = "/resources/upload/" + data.message.split(":")[1]; // 썸네일 이미지 경로
			
			spanMessage = "<span class='chat_img'><img src='" + imgUrl + "' class='" + hrefUrl +"'><a href='" + hrefUrl + "' download>다운로드</a></span>";
		}
		
		// 마지막 메세지와 같은 시간:분인지 체크후 같은 시간이면 다음에 메시지 스팬만 추가
		// 시간span은 추가하지 않음
		// 단, 마지막 메세지 송신자와 전달할 메세지 송신자와 같을때에만 작업
		if(data.sender_email == sEmail && isSameTime(data.send_time, true) && lastSender == data.sender_email) {
			$(".message.align_right").last().find(".sendTime").before(spanMessage);
			
			// 메세지 추가작업후 마지막 메세지 전송자 이메일 input[type=hidden]에저장
			afterSendMesage(data.sender_email);
			return;
		} else if(data.sender_email != sEmail && isSameTime(data.send_time) && lastSender == data.sender_email) {
			$(".message.align_left").last().find(".sendTime").before(spanMessage);
			afterSendMesage(data.sender_email);
			return;
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
	
	afterSendMesage(data.sender_email);
}

// 메시지가 같은시간인지 판별을 위해 "yyyy-MM-dd HH:mm" 패턴으로 input[type=hidde]에 저장
function inputLastSendTime(send_time, isMyMessage) {
	if(isMyMessage) {
		$("#myLastSendTime").val(send_time.substring(0, 16));
	} else {
		$("#otherLastSendTime").val(send_time.substring(0, 16));
	}
}

function isSameTime(send_time, isMyMessage) {
	let sendTime = new Date(send_time.substring(0, 16)).getTime();
	
	// 내가 보낸 메세지 일때
	if(isMyMessage) {
		let lastTime = new Date($("#myLastSendTime").val()).getTime();;
		
		if(sendTime == lastTime) {
			return true;
		}
		return "";
	}
	
	// 상대방이 보낸 메세지 일때
	let lastTime = new Date($("#otherLastSendTime").val()).getTime();;
	
	if(sendTime == lastTime) {
		return true;
	}
	
	return "";
}

// 메세지영역에 메세지 추가후 공통적으로 할 작업
function afterSendMesage(sender_email) {
	// 메세지 추가작업후 마지막 메세지 전송자 이메일 input[type=hidden]에저장
	$("#lastSendMember").val(sender_email);
	
	// 메시지표시영역 스크롤바 항상 맨 밑으로 유지
	$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
}

function closeReNameModal() {
	$("#modalBackground").css("display", "none");
	$("#modalForChangeName").css("display", "none");
	$("#modalBackground .inputName").val("");
}

function sendFilePreview() {
	// 대기중인 파일 전송이 있을경우 기존의 디브 삭제후 재생성
	if($("#filePreview").length != 0) {
		alert("대기중인 파일전송은 취소됩니다.");
		removePreview();
	}
	
	// 선택한 파일 저장할 배열
	fileArray = Array.from($("#file")[0].files);
	
	// 메세지 표시 영역에 프리뷰 디브 추가
	$("#chatMessageArea").append(`
									<div id="filePreview">
										<div id="previewTitle">선택된 사진을 전송 하시겠습니까?</div>
										<div id="sendFileList"></div>
										<div id="previewBtnGroup">
											<input type="button" value="전송" onclick="sendFile()">
											<input type="button" value="취소" onclick="removePreview()">
										</div>
									</div>
	`);
	
	
	// 반복문통해 해당 이미지 span 추가
	fileArray.forEach((file, index) => {
		let reader = new FileReader();
		reader.onload = (e) => {
			let imgTag = file.type.startsWith('image/')
            ? `<img src="${e.target.result}">`
            : '이미지 파일이 아닙니다';

			$("#sendFileList").append(
				`<span class="img">
					${imgTag}
					<button type="button" class="deleteImg" data-index="${index}">
						X
					</button>
				</span>`);
		}

        // 파일 읽기
        reader.readAsDataURL(file);
		
	});			
	
	$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
}

// 프리뷰 디브 삭제
function removePreview() {
	$("#filePreview").remove();
	$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
}

// 프리뷰 사진 삭제
function removeImgInPreview(index) {
    // 배열에서 데이터삭제
    fileArray.splice(index, 1);

    // preview에서 이미지삭제
    $(`button[data-index='${index}']`).closest(".img").remove();

    // 나머지 이미지 index 재설정
    $("#sendFileList span").each(function (i, element) {
        $(element).find("button").attr("data-index", i);
    });

	$("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
	
	if(fileArray.length == 0) {
		$("#filePreview").remove();
	}
}

// 사진전송 메서드
function sendFile() {
	// 멀티파일가능
	let formData = new FormData();
	
	// 각 파일을 fromdata에 추가
	for (let i = 0; i < fileArray.length; i++) {
	    formData.append("files", fileArray[i]); 
	}
	
	$.ajax({
		type : "POST",
		url : "ChatFileUpload",
		data : formData,
		dataType : "JSON",
		processData : false,
		contentType : false
	}).done((response) => {
		// 파일업로드 실패시 해당 파일 이름을 alert창으로 보여주기위한 변수
		let failFileName = "";
		
		for(let file of response) {
			// 파일 처리를 수행하지 못한 경우(이미지 파일 아님 등) 오류 메세지 출력 처리
			if(file.result == "fail") { 
				failFileName += "<" + file.orginalName + ">\n";
				continue;
			}
			
			sendMessage(TYPE_FILE, sEmail, receiver_email, room_id, file.fileName + ":" + file.thumbnailFileName);
		}
		
		// ""일경우 모든 파일 전송 성공
		if(failFileName != "") {
			alert(failFileName + "파일 전송 실패\n다시 시도해 주세요");
		}

	}).fail(() => {
		alert("파일 전송 오류 발생!\n다시 시도해 주세요!");
	});
	
	 removePreview();
}
