package com.itwillbs.project_fundizzy.service;

import java.util.List;

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
}
