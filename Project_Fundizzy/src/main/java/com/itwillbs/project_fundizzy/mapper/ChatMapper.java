package com.itwillbs.project_fundizzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.ChatRoom;

@Mapper
public interface ChatMapper {
	// 채팅방 리스트 조회
	List<ChatRoom> selectChatRoomList(String sender_email);

}
