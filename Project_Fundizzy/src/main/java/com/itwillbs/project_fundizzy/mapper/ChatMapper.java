package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.ChatRoom;

@Mapper
public interface ChatMapper {
	// 채팅방 리스트 조회
	List<ChatRoom> selectChatRoomList(String sender_email);
	
	// 내가 참여한 프로젝트의 메이커, 찜한 메이커, 팔로잉한 메이커의 정보 조회 
	List<Map<String, String>> selectMyMakerInfo(String sender_email);
	
	// 내 프로젝트를 참여 및 지지선언한 서포터의 정보 조회
	List<Map<String, String>> selectMySupportInfo(String sender_email);

}
