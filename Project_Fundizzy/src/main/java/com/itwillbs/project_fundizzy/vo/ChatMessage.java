package com.itwillbs.project_fundizzy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
[ 채팅 메세지를 저장할 chat_message 테이블 정의 ]
idx - INT PK AI
room_id - 50글자 NN
sender_id - 16글자 NN
receiver_id - 16글자 NN
message - 2000글자 NN
type - 20글자 NN
send_time - 날짜 및 시각(DATETIME) NN
read_state - 메세지 읽음(1)/읽지않음(0) 여부
--------------------------------------
CREATE TABLE chat_message (
	idx INT PRIMARY KEY AUTO_INCREMENT,
	room_id VARCHAR(50) NOT NULL,
	sender_id VARCHAR(16) NOT NULL,
	receiver_id VARCHAR(16) NOT NULL,
	message VARCHAR(2000) NOT NULL,
	type VARCHAR(20) NOT NULL,
	send_time DATETIME NOT NULL,
	read_state INT NOT NULL
);
*/
// 웹소켓 채팅 메세지를 자동으로 파싱하기 위한 클래스
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessage {
	private int idx;
	private String type; // 메세지 타입
	private String sender_email; // 메세지 송신자
	private String receiver_email; // 메세지 수신자
	private String room_id; // 채팅방 아이디
	private String message; // 메세지 내용
	private String send_time; // 메세지 전송 시각
	private int read_state; // 메세지 읽음 여부
	
	// 메세지 타입으로 사용할 값을 상수로 생성
	public static final String TYPE_ENTER = "TYPE_ENTER";
	public static final String TYPE_LEAVE = "TYPE_LEAVE";
	public static final String TYPE_TALK = "TYPE_TALK"; // 대화 메세지
	public static final String TYPE_INIT_MAIN = "TYPE_INIT_MAIN"; // 채팅창 초기화 요청(메인페이지)
	public static final String TYPE_INIT_LIST = "TYPE_INIT_LIST"; // 채팅창 초기화 요청(채팅리스트페이지)
	public static final String TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM"; // 채팅창 초기화 요청(채팅방페이지)
	public static final String TYPE_INIT_COMPLETE = "TYPE_INIT_COMPLETE"; // 채팅창 초기화 완료
	public static final String TYPE_ERROR = "TYPE_ERROR"; // 채팅 관련 에러
	public static final String TYPE_START = "TYPE_START"; // 채팅 시작
	public static final String TYPE_REQUEST_CHAT_LIST = "TYPE_REQUEST_CHAT_LIST"; // 지난 대화내역 조회 요청
	public static final String TYPE_FILE = "TYPE_FILE"; // 파일 전송
	public static final String TYPE_READ_MESSAGE = "TYPE_READ_MESSAGE"; // 메세지 읽음
}