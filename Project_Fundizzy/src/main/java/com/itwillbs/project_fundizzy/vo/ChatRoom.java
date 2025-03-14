package com.itwillbs.project_fundizzy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatRoom {
	private String room_id;
	private String title;
	private String sender_email;
	private String receiver_email;
	private int status;
	private String last_accessed_time;
	private int unread_count;
	private String last_message;
	private String receiverInfo; // 채팅리스트에 상대방 정보를 보여주기 위한 변수
}


