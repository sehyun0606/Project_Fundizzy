package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NotificationController {
	
	// 마이페이지 알림설정 페이지로 이동
	@GetMapping("NotificationSetPage")
	public String notificationSetPage() {
		return "service/notification/my_notification_set";
	}
	
	// 나의 알림 페이지로 이동
	@GetMapping("NotificationBoard")
	public String notificationBoard() {
		return "service/notification/my_notification_board";
	}
}
