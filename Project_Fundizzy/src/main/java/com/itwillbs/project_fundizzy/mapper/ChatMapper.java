package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.ChatMessage;
import com.itwillbs.project_fundizzy.vo.ChatRoom;

@Mapper
public interface ChatMapper {
	// 채팅방 리스트 조회
	List<ChatRoom> selectChatRoomList(String sender_email);
	
	// 최근 채팅멤버리스트 조회
	List<Map<String, String>> selectRecentlyChatMemberList(String sender_email);
	
	// 내가 참여한 프로젝트의 메이커, 찜한 메이커, 팔로잉한 메이커의 정보 조회 
	List<Map<String, String>> selectMyMakerInfo(String sender_email);
	
	// 내 프로젝트를 참여 및 지지선언한 서포터의 정보 조회
	List<Map<String, String>> selectMySupportInfo(String sender_email);
	
	// 상대방과의 채팅방 정보 조회
	ChatRoom selectChatRoom(ChatMessage chatMessage);
	
	// 채팅방의 채팅내역 조회
	List<ChatMessage> selectChatMessageList(String room_id);
	
	// 새로운 채팅방 생성
	int insertNewChatRoom(ChatRoom room);
	
	// 전송된 채팅 디비에 저장
	void insertChatMessage(ChatMessage chatMessage);
	
	// 채팅방 마지막 접근 시간 업데이트
	void updateLastAccessTime(ChatMessage chatMessage);
	
	// 읽지않은 메세지 수 조회
	List<Map<String, Integer>> selectUnReadCountList(String sender_email);
}
