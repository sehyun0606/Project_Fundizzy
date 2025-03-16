package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	
	// 메세지 읽음 처리
	int updateMessageToRead(@Param("room_id") String room_id, @Param("sender_email") String sender_email);
	
	// 읽지않은 메세지 총 수 조회
	int selectTotalUnReadCount(String sender_email);
	
	// 채팅방의 상태값 조회
	int selectRoomStatus(ChatMessage chatMessage);
	
	// 나의 채팅방 상태값 변경
	void updateChatRoomstatus(ChatMessage chatMessage);
	
	// 상대방 채팅방 상태값 변경
	int updateChatRoomstatus2(ChatMessage chatMessage);
	
	// 해당 채팅방의 메세지 삭제
	void deleteChatMessage(ChatMessage chatMessage);
	
	// 채팅방 삭제
	int deleteChatRoom(ChatMessage chatMessage);
	
	// 채팅방 이름 변경
	void updateChatRoomName(ChatMessage chatMessage);


}
