package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.ChatMapper;
import com.itwillbs.project_fundizzy.vo.ChatMessage;
import com.itwillbs.project_fundizzy.vo.ChatRoom;

@Service
public class ChatService {
	@Autowired
	private ChatMapper chatMapper;
	
	// 채팅방 리스트 조회
	public List<ChatRoom> getChatRoomList(String sender_email) {
		return chatMapper.selectChatRoomList(sender_email);
	}
	
	// 최근 채팅 멤버 조회
	public List<Map<String, String>> getRecentlyChatMemberList(String sender_email) {
		return chatMapper.selectRecentlyChatMemberList(sender_email);
	}
	
	// 내가 참여한 프로젝트의 메이커, 찜한 메이커, 팔로잉한 메이커의 정보 조회
	public List<Map<String, String>> getMyMakerInfo(String sender_email) {
		return chatMapper.selectMyMakerInfo(sender_email);
	}
	
	// 내 프로젝트를 참여 및 지지선언한 서포터의 정보 조회
	public List<Map<String, String>> getMySupportInfo(String sender_email) {
		return chatMapper.selectMySupportInfo(sender_email);
	}
	
	// 채팅방 정보 조회
	public ChatRoom getChatRoomInfo(ChatMessage chatMessage) {
		return chatMapper.selectChatRoom(chatMessage);
	}
	
	// 채팅 내역 조회
	public List<ChatMessage> getChatMessageList(String room_id) {
		return chatMapper.selectChatMessageList(room_id);
	}
	
	// 채팅방 생성
	public int addChatRoomForStart(ChatRoom room) {
		return chatMapper.insertNewChatRoom(room);
	}
	
	// DB에 채팅내용 저장
	@Transactional
	public void addChatMessage(ChatMessage chatMessage) {
		// 채팅내용 저장시 해당 채팅방의 last_access_time 업데이트
		chatMapper.updateLastAccessTime(chatMessage);
		// 채팅내용 채팅 테이블에 저장
		chatMapper.insertChatMessage(chatMessage);
	}
	
	// 안읽은 메세지 수 조회
	public int getTotalUnReadCount(String sender_email) {
		return chatMapper.selectTotalUnReadCount(sender_email);
	}
	
	// 메세지 읽음 처리
	public int changeMessageReadState(String room_id, String sender_email) {
		return chatMapper.updateMessageToRead(room_id, sender_email);
	}
}
