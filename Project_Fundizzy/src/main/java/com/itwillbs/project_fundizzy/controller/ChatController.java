package com.itwillbs.project_fundizzy.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ChatController {
	@Autowired
	
	// 채팅 아이콘 클릭시 채팅메인 페이지로 이동
	@GetMapping("ChatMain")
	public String chatMain() {
		return "service/chat/chat_main";
	}
	
	// 채팅 리스트 페이지로 이동
	@GetMapping("ChatList")
	public String chatList() {
		return "service/chat/chat_list";
	}
	
	// 채팅방으로 이동
	@GetMapping("ChatRoom")
	public String chatRoom() {
		return "service/chat/chat_room";
	}
}
