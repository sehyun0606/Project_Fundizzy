package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_fundizzy.service.NotificationService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class NotificationController {
	@Autowired
	private NotificationService notificationService;
	
	// 마이페이지 알림설정 페이지로 이동
	@GetMapping("NotificationSetPage")
	public String notificationSetPage(HttpSession session, Model model) {
		// 로그인된 email
		String email = (String)session.getAttribute("sId");
		
		//디비에 저장된 회원의 알림설정 정보 조회
		Map<String, Object> memberNOTSetInfo = notificationService.getMemberNOTSetInfo(email);
		model.addAttribute("memberNOTSetInfo", memberNOTSetInfo);
		
		return "service/notification/my_notification_set";
	}
	
	// 나의 알림 페이지로 이동
	@GetMapping("NotificationBoard")
	public String notificationBoard(HttpSession session, Model model) {
		String email = (String)session.getAttribute("sId");
		
		// 내 알림리스트 조회
		List<Map<String, Object>> myNOTList = notificationService.getMyNOTList(email);
		model.addAttribute("myNOTList", myNOTList);
		
		return "service/notification/my_notification_board";
	}
	
	// 마이페이지 알림설정의 옵션변경정보 저장
	@ResponseBody
	@PostMapping("ChangeNOTSetInfo")
	public String changeNOTSetInfo(@RequestParam Map<String, String> optionMap, HttpSession session) {
		optionMap.put("member_email", (String)session.getAttribute("sId"));
		
		// 알림설정 테이블의 옵션 정보 변경
		int updateResult = notificationService.changeNOTSetOption(optionMap);
		// 업데이트 판별 후 메세지 전송(실패할겨우에만 알림창 출력예정)
		if(updateResult > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 마이페이지 알림설정의 옵션정보 조회
	@ResponseBody
	@GetMapping("SearchNOTOptionInfo")
	public Map<String, Object> searchNOTOptionInfo(HttpSession session) {
		// 로그인된 email
		String email = (String)session.getAttribute("sId");
		
		//디비에 저장된 회원의 알림설정 정보 조회
		return notificationService.getMemberNOTSetInfo(email);
	}
}
