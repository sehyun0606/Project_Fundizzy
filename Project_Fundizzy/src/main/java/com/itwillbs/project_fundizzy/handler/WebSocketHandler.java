package com.itwillbs.project_fundizzy.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketHandler extends TextWebSocketHandler {
	// 접속 회원에 대한 정보를 저장할 Map 객체
	private Map<String, WebSocketSession> userSessionList = new HashMap<String, WebSocketSession>();
	
	// 접속한 멤버의 session 아이디와 웹소켓 세션아이디 저장할 map 객체
	private Map<String, String> userList = new HashMap<String, String>();

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
		
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생! - handleTransportError");
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨! - afterConnectionClosed");
	}
	
	// 웹소켓 세션 객체에서 세션에 저장된 이메일 출력메서드
	private String getHttpSessionId(WebSocketSession session) {
		return (String)session.getAttributes().get("sId");
	}
}
