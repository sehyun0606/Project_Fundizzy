package com.itwillbs.project_fundizzy.aop;

import java.util.HashMap;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.service.MailService;
import com.itwillbs.project_fundizzy.service.NotificationService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class NotificationAspect {
	// 알림 코드 상수
	private final String NOT_SITE_CODE = "NOT01";
	private final String NOT_FOLLOWING_CODE = "NOT02";
	private final String NOT_WISH_CODE = "NOT03";
	private final String NOT_MYPROJECT_CODE = "NOT04";
	private final String NOT_JOINPROJECT_CODE = "NOT05";
	
	// 알림 설정 상수
	private final String IS_RECV_NOT = "is_recv_notification";
	private final String IS_RECV_SITE = "is_recv_site";
	private final String IS_RECV_FOLLOW = "is_recv_following";
	private final String IS_RECV_WISH = "is_recv_wish";
	private final String IS_RECV_MY = "is_recv_myproject";
	private final String IS_RECV_JOIN = "is_recv_joinproject";
	
	
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private MailService mailService;
	
	// memberService의 회원가입 메서드 실행 완료 후 해당멤버의 알림여부선택 값 알림설정 테이블에 적용
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.MemberService.insertMember(..))")
	public void joinCheckAndSetNOT(JoinPoint joinPoint) {
		  Object[] args = joinPoint.getArgs();
		  
		  Map<String, String> map = (Map<String, String>)args[0];
		  
		  String email = map.get("email");
		  
		  // 회원가입시 선택한 알림정보 알림설정테이블에 입력
		  notificationService.registNOTSetInfo(map);
		  
		  // 전체알림 수신여부, 사이트알림 수신여부 판별 후 디비에 알림 등록
		  if(isReceiveThisNOT(email, IS_RECV_SITE)) {
			  // 알림테이블에 저장할 알림내용 작성
			  String notification_content = map.get("nickname") + "님 환영합니다!<br>회원가입이 성공적으로 완료되었습니다";
			  // 알림등록 메서드 호출
			  registNOTOnDB(email, NOT_SITE_CODE, notification_content);
		  }
		  
	}
	
	// 알림코드에 따른 메시지 수신 여부 판단 메서드
	private Boolean isReceiveThisNOT(String email, String notCode) {
		// 디비에 저장된 회원의 알림 옵션 정보 조회
		Map<String, Object> dbNOTOptionInfo = notificationService.getMemberNOTSetInfo(email);
		
		// 알림 수신 여부 - 전체적인 알림을 받을 것인가에 대한 판별
		// N일 경우 메서드 작업 종료
		if(((String)dbNOTOptionInfo.get(IS_RECV_NOT)).equals("N")) {
			return false;
			// 알림코드에 해당하는 알림 수신 여부 판별
		} else if(((String)dbNOTOptionInfo.get(notCode)).equals("N")) {
			return false;
		} else {
			return true;
		}
	}
	
	
	// 알림테이블에 알림등록 메서드
	private void registNOTOnDB(String email, String notCode, String notification_content) {
		// 알림등록을 위한 맵 객체
		Map<String, String> notificationMap = new HashMap<String, String>();
		
		notificationMap.put("member_email", email);
		notificationMap.put("common_code", notCode);
		notificationMap.put("notification_content", notification_content);
		
		// 알림등록
		notificationService.registNOTInfo(notificationMap);
	}
	
		
}
