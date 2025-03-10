// 채팅 메세지 타입 구분을 위한 상수 설정
const TYPE_ENTER = "TYPE_ENTER"; // 입장
const TYPE_LEAVE = "TYPE_LEAVE"; // 퇴장
const TYPE_TALK = "TYPE_TALK"; // 대화
const TYPE_INIT = "TYPE_INIT"; // 채팅창 초기화
const TYPE_INIT_COMPLETE = "TYPE_INIT_COMPLETE"; // 채팅창 초기화 완료
const TYPE_ERROR = "TYPE_ERROR"; // 채팅 관련 에러
const TYPE_START = "TYPE_START"; // 채팅 시작
const TYPE_REQUEST_CHAT_LIST = "TYPE_REQUEST_CHAT_LIST"; // 지난 대화내역 조회 요청
const TYPE_FILE = "TYPE_FILE"; // 파일 전송
const TYPE_READ_MESSAGE = "TYPE_READ_MESSAGE"; // 메세지 읽음

// 채팅 메세지 정렬 위치 구분을 위한 상수 설정
const ALIGN_CENTER = "align_center";
const ALIGN_LEFT = "align_left";
const ALIGN_RIGHT = "align_right";

var ws;
var sId;

$(function() {
	// 세션 아이디 저장
	sId = $("#sId", opener.document).val();
	
	// 로그인 안되어있을때 로그인 페이지로 이동, 챗 윈도우 클로즈
	if(!sId) {
		alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.")
		opener.location.href = "Login";
		window.close();
	}
	
	initChatWindow();
});

 
// 부모창의 sendMessage() 함수 호출하여 메세지 전송을 요청하는 함수
function sendMessage(type, sender_id, receiver_id, room_id, message, idx) {
	// 부모창의 sendMessage() 함수 호출
	opener.sendMessage(type, sender_id, receiver_id, room_id, message, idx);
}