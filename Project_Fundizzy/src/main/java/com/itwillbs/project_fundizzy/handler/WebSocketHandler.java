package com.itwillbs.project_fundizzy.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.service.ChatService;
import com.itwillbs.project_fundizzy.service.MemberService;
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
	
	@Autowired
	private MemberService memberService;

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
		System.out.println("수신된 메세지 : " + chatMessage);
		
		String sender_email = getHttpSessionId(session);
		String receiver_email = chatMessage.getReceiver_email();
		
		// 내 정보 조회
		Map<String, String> myInfo = memberService.getMember(sender_email);
		chatMessage.setMyInfo(gson.toJson(myInfo));
		
		// 상대방 정보
		Map<String, String> otherInfo = null;
		
		// 상대방 정보 조회 
		if(!receiver_email.equals("")) {
			otherInfo = memberService.getMember(receiver_email);
			chatMessage.setOtherInfo(gson.toJson(otherInfo));
		}
		
		chatMessage.setSend_time(getSysDateTime());
		
		String type = chatMessage.getType();
		
		System.out.println("수신된 메세지 타입 : " + type);
		
		// 채팅창 메인 페이지 초기화 메시지
		if(type.equals(ChatMessage.TYPE_INIT_MAIN)) {
			// 최근 채팅 멤버 조회
			List<Map<String, String>> recentlyChatMemberList = chatService.getRecentlyChatMemberList(sender_email);
			
			// chat_main에 표시할 내가 팔로잉, 찜 및 참여한 프로젝트의 메이커의 정보 조회
			List<Map<String, String>> makerList = chatService.getMyMakerInfo(sender_email);
			
			// chat_main에 표시할 내 프로젝트 서포터정보 조회
			// 서포터 정보 => 내 프로젝트 참여 회원, 내 프로젝트 지지선언한 회원
			List<Map<String, String>> supportList = chatService.getMySupportInfo(sender_email);
			
			// 조회한 메이커, 서포터의 정보를 메세지로 전달하기위해 하나의 맵객체안에 속성값으로 저장
			Map<String, List<Map<String, String>>> memberList = new HashMap<String, List<Map<String,String>>>();
			memberList.put("recentlyChatMemberList", recentlyChatMemberList);
			memberList.put("makerList", makerList);
			memberList.put("supportList", supportList);
			
			// 메세지로 전달하기위해 JSON 형식으로 변환
			String jsonMemberList = gson.toJson(memberList);
			chatMessage.setMessage(jsonMemberList);
			
			sendMessasge(session, chatMessage);
			
		// 채팅 리스트 페이지 초기화 메시지
		} else if(type.equals(ChatMessage.TYPE_INIT_LIST)) {
			// 채팅방 리스트 조회
			List<ChatRoom> chatRoomList = chatService.getChatRoomList(sender_email);
			
			// 채팅리스트페이지에서 채팅방마다 상대방의 정보를 표시하기 위해 각 방의 수신자정보 조회
			for(ChatRoom room : chatRoomList) {
				// 조회된 상대방정보 ChatRoom의 멤버변수에 저장
				Map<String, String> receiverInfo = memberService.getMember(room.getReceiver_email());
				room.setReceiverInfo(gson.toJson(receiverInfo));
			}
			// 조회결과를 json타입으로 변환후 chatMessage의 message에 초기화
			String jsonChatRoomList = gson.toJson(chatRoomList);
			chatMessage.setMessage(jsonChatRoomList);
			// 메시지 전달
			sendMessasge(session, chatMessage);
			
		// 채팅방 초기화 메시지
		} else if (type.equals(ChatMessage.TYPE_INIT_CHATROOM)) {
			System.out.println("채팅방 초기화 완료");
			// 회원의 현재 상태 판별후 비활성화일때 에러메세지 전달
			if(!otherInfo.get("member_status").equals("1")) {
				chatMessage.setType(ChatMessage.TYPE_ERROR);
				chatMessage.setMessage("휴면회원이거나 탈퇴한 회원입니다.\n채팅을 종료합니다");
				sendMessasge(session, chatMessage);
				return;
			}
			
			// 상대방과의 채팅방 정보조회
			ChatRoom room = chatService.getChatRoomInfo(chatMessage);
			
			// 채팅방이 존재하면 채팅글 조회 및 채팅방 아이디 전달
			if(room != null)  {
				chatMessage.setRoom_id(room.getRoom_id());
				
				List<ChatMessage> chatMessageList = chatService.getChatMessageList(room.getRoom_id());
				chatMessage.setMessage(gson.toJson(chatMessageList));
			} 
			
			sendMessasge(session, chatMessage);
			
			// 채팅 메세지 전송
		} else if(type.equals(ChatMessage.TYPE_TALK)) {
			// 채팅방 아이디가 존재하지 않으면 새로 채팅방 생성
			if(chatMessage.getRoom_id() == null) {
				ChatRoom room = new ChatRoom();
				String Room_id = generateRoomId();
				room.setRoom_id(Room_id);
				room.setSender_email(sender_email);
				room.setReceiver_email(receiver_email);
				
				int insertResult = chatService.addChatRoomForStart(room);
				
				// 채팅방생성작업 성공 유무 판별
				if(insertResult == 0) {
					chatMessage.setType(ChatMessage.TYPE_ERROR);
					chatMessage.setMessage("채팅방 생성에 실패 하였습니다.\n다시 시도하여 주세요.");
					sendMessasge(session, chatMessage);
					return;
				}
				
				// 채팅 시작 메시지 전송
				ChatMessage startMessage = new ChatMessage();
				startMessage.setMessage("채팅이 시작되었습니다.");
				startMessage.setType(ChatMessage.TYPE_SYSTEM);
				startMessage.setSender_email(sender_email);
				startMessage.setReceiver_email(receiver_email);
				startMessage.setRoom_id(room.getRoom_id());
				startMessage.setSend_time(getSysDateTime());
				
				// 디비에 시스템 메세지 저장
				chatService.addChatMessage(startMessage);
				
				// 채팅창 실시간 표시를 위해 메세지 전송
				sendMessasge(session, startMessage);
				
				//전송된 메세지에도 위에 만들어진 채팅방아이디 초기화
				chatMessage.setRoom_id(Room_id);
				
				// 새로운 방생성일경우 첫 채팅과 채팅시작 시스템 채팅과 시간이 같아서 
				// 메세지 전송시간을 채팅방 생성 후 시간으로 설정하기위해 다시 변수에 초기화
				// 1초 대기
				try {
				    Thread.sleep(1000);
				} catch (InterruptedException e) {
				    e.printStackTrace();
				}
				
				chatMessage.setSend_time(getSysDateTime());
			}
			
			// 전송된 메세지 디비에 저장
			chatService.addChatMessage(chatMessage);
			
			// 채팅창 실시간 표시를 위해 메세지 전송
			// 수신자는 채팅 접속시에만 메세지 전송
			sendMessasge(session, chatMessage);
			sendMessageAfterSearchReceiver(receiver_email, chatMessage);
			
			// 회원의 읽지않은 메시지 수 조회
		} else if(type.equals(ChatMessage.TYPE_REQUEST_UNREADMESSAGE)) {
			List<Map<String, Integer>> unReadChatCountList = chatService.getUnReadCount(sender_email);
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
	
	// 수신자 아이디를 활용하여 수신자 세션 검색 후 수신자에게만 메세지를 전송하는 메서드
	private void sendMessageAfterSearchReceiver(String receiver_email, ChatMessage chatMessage) throws Exception {
		// 수신자 접속 여부 판별
		if(userList.get(receiver_email) != null) { 
			WebSocketSession receiver_session = userSessionList.get(userList.get(receiver_email));
			
			// sendMessage() 메서드 호출하여 채팅 메세지 전송
			sendMessasge(receiver_session, chatMessage);
		}
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
	
	// 채팅방번호(room_id)값 생성하는 메서드
	private String generateRoomId() {
		// UUID 클래스 활용하여 랜덤UUID 값 리턴
		return UUID.randomUUID().toString();
	}
	
}
