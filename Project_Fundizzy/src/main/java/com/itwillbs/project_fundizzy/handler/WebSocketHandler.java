package com.itwillbs.project_fundizzy.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.service.ChatService;
import com.itwillbs.project_fundizzy.vo.ChatMessage;
import com.itwillbs.project_fundizzy.vo.ChatRoom;

public class WebSocketHandler extends TextWebSocketHandler {
	// 접속 회원에 대한 정보를 저장할 Map 객체
	private Map<String, WebSocketSession> userSessionList = new HashMap<String, WebSocketSession>();
	
	// 접속한 멤버의 session 아이디와 웹소켓 세션아이디 저장할 map 객체
	private Map<String, String> userList = new HashMap<String, String>();
	
	// JSON 데이터 파싱 작업을 처리할 Gson 객체 생성
	private final Gson gson = new Gson();
	
	@Autowired
	private ChatService chatService;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("웹소켓 연결됨! - afterConnectionEstablished");
		
		// 접속중인 사용자의 웹소켓 객체 맵에 저장
		userSessionList.put(session.getId(), session);
		userList.put(getHttpSessionId(session), session.getId());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 수신됨! - handleTextMessage");
		
		// 전달된 메세지를 Chatmessage 타입으로 변환
		ChatMessage chatMessage = jsonToMessage(message.getPayload());
		
		String sender_email = getHttpSessionId(session);
		String receiver_email = chatMessage.getReceiver_email();
		
		chatMessage.setSend_time(getSysDateTime());
		
		String type = chatMessage.getType();
		
		System.out.println("수신된 메서드 타입 : " + type);
		
		// 채팅 리스트 페이지 채팅창 초기화 메시지
		if(type.equals(ChatMessage.TYPE_INIT_LIST)) {
			System.out.println(sender_email);
			// 채팅방 리스트 조회
			List<ChatRoom> chatRoomList = chatService.getChatRoomList(sender_email);
			// 조회결과를 json타입으로 변환후 chatMessage의 message에 초기화
			String jsonChatRoomList = gson.toJson(chatRoomList);
			chatMessage.setMessage(jsonChatRoomList);
			// 메시지 전달
			sendMessasge(session, chatMessage);
		}
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생! - handleTransportError");
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨! - afterConnectionClosed");
	}
	
	// --------------------------------- 메서드	 -------------------------------------------
	// 웹소켓 세션 객체에서 세션에 저장된 이메일 출력메서드
	private String getHttpSessionId(WebSocketSession session) {
		return (String)session.getAttributes().get("sId");
	}
	
	// json문자열을 ChatMessage 타입으로 변환
	private ChatMessage jsonToMessage(String jsonMessage) {
		return gson.fromJson(jsonMessage, ChatMessage.class);
	}
	
	// 현재 날짜시간 문자열로 리턴 메서드
	private String getSysDateTime() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		return LocalDateTime.now().format(formatter);
	}
	
	// ChatMessage를 json 형태로 변환 메서드
	private String messageToJson(ChatMessage chatMessage) {
		return gson.toJson(chatMessage);
	}
	
	// 각 웹소켓 세션에게 메세지 전송하는 메서드
	private void sendMessasge(WebSocketSession session, ChatMessage chatMessage) throws Exception {
		session.sendMessage(new TextMessage(messageToJson(chatMessage)));
	}
}
