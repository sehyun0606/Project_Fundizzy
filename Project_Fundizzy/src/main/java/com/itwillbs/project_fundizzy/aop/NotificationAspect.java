package com.itwillbs.project_fundizzy.aop;

import java.util.HashMap;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.handler.MakeNotification;
import com.itwillbs.project_fundizzy.service.NotificationService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class NotificationAspect {
	
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private MakeNotification makeNotification;
	
	
	// memberService의 회원가입 메서드 실행 완료 후 해당멤버의 알림여부선택 값 알림설정 테이블에 적용
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.MemberService.insertMember(..))")
	public void joinCheckAndSetNOT(JoinPoint joinPoint) {
		  Object[] args = joinPoint.getArgs();
		  
		  Map<String, String> map = (Map<String, String>)args[0];
		  
		  // 회원가입시 선택한 알림정보 알림설정테이블에 입력
		  notificationService.registNOTSetInfo(map);
		  
		  // 알림테이블에 저장할 알림내용 작성
		  String msg = map.get("nickname") + "님 환영합니다! 회원가입이 성공적으로 완료되었습니다";
		  
		  // 알림테이블 인설트를 위한 맵객체 생성
		  Map<String, String> notMap = makeNotification.makeMapForNOTRegist(map.get("email"), msg);
		  
		  // 회원가입 알림 알림테이블에 등록
		  notificationService.registNOTInfo(notMap);
		  
	}
	
	
}
