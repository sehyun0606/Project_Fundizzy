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
}


