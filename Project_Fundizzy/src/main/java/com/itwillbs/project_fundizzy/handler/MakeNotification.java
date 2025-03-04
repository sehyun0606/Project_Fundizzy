package com.itwillbs.project_fundizzy.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
public class MakeNotification {
	// 알림 코드 상수 
	private final static String NOT_SITE_CODE = "NOT01";
	private final static String NOT_FOLLOWING_CODE = "NOT02";
	private final static String NOT_WISH_CODE = "NOT03";
	private final static String NOT_MYPROJECT_CODE = "NOT04";
	private final static String NOT_JOINPROJECT_CODE = "NOT05";
	
	// 사이트 알림등록을 위해 필요한 map 작성 메서드
	public Map<String, String> makeMapForNOTRegist(String email, String msg) {
		Map<String, String> notificationMap = new HashMap<String, String>();
		notificationMap.put("member_email", email);
		notificationMap.put("common_code", NOT_SITE_CODE);
		notificationMap.put("notification_content", msg);
		return notificationMap;
	}

}
