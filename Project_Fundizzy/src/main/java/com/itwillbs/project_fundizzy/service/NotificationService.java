package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.NotificationMapper;

@Service
public class NotificationService {
	@Autowired
	private NotificationMapper notificationMapper;
	
	// 회원가입시 선택한 알림정보를 알림설정테이블에 입력
	public void rigistNOTSetInfo(Map<String, String> map) {
		notificationMapper.insertNOTSetInfo(map);
	}
	
	// 해당 회원의 알림설정정보 조회
	public Map<String, Object> getMemberNOTSetInfo(String email) {
		return notificationMapper.selectMemberNOTSetInfo(email);
	}
	
	// 알림설정 옵션 변경
	public int changeNOTSetOption(Map<String, String> optionMap) {
		return notificationMapper.updateNOTSetOption(optionMap);
	}
	
}
