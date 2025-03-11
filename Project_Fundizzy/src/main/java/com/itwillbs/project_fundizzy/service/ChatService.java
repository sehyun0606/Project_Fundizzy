package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ChatMapper;
import com.itwillbs.project_fundizzy.vo.ChatRoom;

@Service
public class ChatService {
	@Autowired
	private ChatMapper chatMapper;
	
	// 채팅방 리스트 조회
	public List<ChatRoom> getChatRoomList(String sender_email) {
		return chatMapper.selectChatRoomList(sender_email);
	}
	
	// 내가 참여한 프로젝트의 메이커, 찜한 메이커, 팔로잉한 메이커의 정보 조회
	public List<Map<String, String>> getMyMakerInfo(String sender_email) {
		return chatMapper.selectMyMakerInfo(sender_email);
	}
	
	// 내 프로젝트를 참여 및 지지선언한 서포터의 정보 조회
	public List<Map<String, String>> getMySupportInfo(String sender_email) {
		return chatMapper.selectMySupportInfo(sender_email);
	}
}
