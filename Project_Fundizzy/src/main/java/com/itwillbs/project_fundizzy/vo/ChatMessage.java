package com.itwillbs.project_fundizzy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
	private String myInfo; // 내 정보
	private String otherInfo; // 상대방 정보
	
	// 메세지 타입으로 사용할 값을 상수로 생성
	public static final String TYPE_ENTER = "TYPE_ENTER";
	public static final String TYPE_LEAVE = "TYPE_LEAVE";
	public static final String TYPE_TALK = "TYPE_TALK"; // 대화 메세지
	public static final String TYPE_SYSTEM = "TYPE_SYSTEM"; // 시스템 메세지
	public static final String TYPE_INIT_MAIN = "TYPE_INIT_MAIN"; // 채팅창 초기화 요청(메인페이지)
	public static final String TYPE_INIT_LIST = "TYPE_INIT_LIST"; // 채팅창 초기화 요청(채팅리스트페이지)
	public static final String TYPE_INIT_CHATROOM = "TYPE_INIT_CHATROOM"; // 채팅방 초기화 요청(채팅방페이지)
	public static final String TYPE_ERROR = "TYPE_ERROR"; // 채팅 관련 에러
	public static final String TYPE_FILE = "TYPE_FILE"; // 파일 전송
	public static final String TYPE_READ_MESSAGE = "TYPE_READ_MESSAGE"; // 메세지 읽음
	public static final String TYPE_REQUEST_UNREADMESSAGE = "TYPE_REQUEST_UNREADMESSAGE"; // 읽지 않은 메세지 수 요청
}