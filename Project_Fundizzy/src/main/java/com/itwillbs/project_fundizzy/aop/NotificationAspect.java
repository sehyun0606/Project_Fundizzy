package com.itwillbs.project_fundizzy.aop;

import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.service.NotificationService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class NotificationAspect {
	
	@Autowired
	private NotificationService notificationService;
	
	
	// memberService의 회원가입 메서드 실행 완료 후 해당멤버의 알림여부선택 값 알림설정 테이블에 적용
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.MemberService.insertMember(..))")
	public void joinCheckAndSetNOT(JoinPoint joinPoint) {
		  Object[] args = joinPoint.getArgs();
		  
		  Map<String, String> map = (Map<String, String>)args[0];
		  
		  // 회원가입시 선택한 알림정보 알림설정테이블에 입력
		  notificationService.rigistNOTSetInfo(map);
		  
		  
	}
}
