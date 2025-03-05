package com.itwillbs.project_fundizzy.aop;

import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.handler.NotificationHandler;
import com.itwillbs.project_fundizzy.service.NotificationService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class NotificationAspect {
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private NotificationHandler notHandler;
	
	// memberService의 회원가입 메서드 실행 완료 후 해당멤버의 알림여부선택 값 알림설정 테이블에 적용
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.MemberService.insertMember(..))")
	public void joinCheckAndSetNOT(JoinPoint joinPoint) {
		  Object[] args = joinPoint.getArgs();
		  
		  Map<String, String> map = (Map<String, String>)args[0];
		  
		  String email = map.get("email");
		  
		  // 회원가입시 선택한 알림정보 알림설정테이블에 입력
		  notificationService.registNOTSetInfo(map);
		  
		  // 전체알림 수신여부, 사이트알림 수신여부 판별 후 디비에 알림 등록
		  if(notHandler.isReceiveThisNOT(email, notHandler.IS_RECV_SITE)) {
			  // 알림테이블에 저장할 알림내용 작성
			  String notification_content = map.get("nickname") + "님 환영합니다!<br>회원가입이 성공적으로 완료되었습니다";
			  // 알림등록 메서드 호출
			  notHandler.registNOTOnDB(email, notHandler.NOT_SITE_CODE, notification_content);
		  }
		  
	}
	
		
}
