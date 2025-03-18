package com.itwillbs.project_fundizzy.aop;

import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.handler.NotificationHandler;
import com.itwillbs.project_fundizzy.service.MemberService;
import com.itwillbs.project_fundizzy.service.NotificationService;
import com.itwillbs.project_fundizzy.service.ProjectStateService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class NotificationAspect {
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private NotificationHandler notHandler;
	
	@Autowired
	private MemberService memberservice;
	
	// memberService의 회원가입 메서드 실행 완료 후 해당멤버의 알림여부선택 값 알림설정 테이블에 적용
	@After("execution(* com.itwillbs.project_fundizzy.service.MemberService.insert*(..))")
	public void joinCheckAndSetNOT(JoinPoint joinPoint) {
		// 메서드이름 저장
		String methodName = joinPoint.getSignature().getName();
		Object[] args = joinPoint.getArgs();
		
		String email = "";
		
		// 알림테이블에 저장할 알림내용
		String notification_content = "";
		
		// 메서드 종류에따라 판별
		if(methodName.equals("insertMember")) {
			// 메서드 파라미터
			Map<String, Object> map = (Map<String, Object>)args[0];
			
			email = (String)map.get("email");
			notification_content = map.get("nickname") + "님 환영합니다!<br>회원가입이 성공적으로 완료되었습니다";
			
		// 파라미터가 Sring 타입으로 넘어옴
		} else if(methodName.equals("insertKakaoUser") || methodName.equals("insertNaverUser")) {
			email = (String)args[1];
			notification_content = (String)args[0] + "님 환영합니다!<br>회원가입이 성공적으로 완료되었습니다";
		}
		
		// insert 작업 완료된지 파악(joinpoint에 리턴값이 void라 디비로 판별)
		Map<String, String> dbData = memberservice.getMember(email);
		
		if(dbData != null) {
			// 회원가입시 선택한 알림정보 알림설정테이블에 입력
			notificationService.registNOTSetInfo(email);
			
			// 전체알림 수신여부, 사이트알림 수신여부 판별 후 디비에 알림 등록
			if(notHandler.isReceiveThisNOT(email, notHandler.IS_RECV_SITE)) {
				// 알림등록 메서드 호출
				notHandler.registNOTOnDB(email, "", notHandler.NOT_SITE_CODE, notification_content);
			}
		}
	}
	
	// 프로젝트 승인, 거절 알림
	@After("execution(* com.itwillbs.project_fundizzy.service.AdminProjectService.project*(..))")
	public void projectAcceptAndDeny(JoinPoint joinPoint) {
		System.err.println("프로젝트승인알림 시작됨 ");
		String methodName = joinPoint.getSignature().getName();
		
		String project_code = (String)joinPoint.getArgs()[0];
		
		// 상태 업데이트 작업 완료된지 파악(joinpoint에 리턴값이 void라 디비로 판별)
		Map<String, String> dbData = notificationService.getProjectInfo(project_code);
		String makerEmail = dbData.get("member_email");
		
		// 승인, 거절전 상태 before
		if(!dbData.get("approve_stat").equals("before")) {
			// 프로젝트 승인 알림 
			if(methodName.equals("projectAccept")) {
				// 프로젝트 메이커에 알림
				notHandler.sendNotToMaker(makerEmail, project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE, "고객님의 프로젝트<br><a href='FundBoardStory?porject_code=" + project_code + "'>" + dbData.get("project_title") + "</a><br> 이 승인되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToKeepMember(project_code, notHandler.IS_RECV_WISH, notHandler.NOT_WISH_CODE, "회원님이 찜한<br><a href='FundBoardStory?porject_code=" + project_code + "'>" + dbData.get("project_title") + "</a><br> 이 승인되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToSupportMember(project_code, notHandler.IS_RECV_SUPPORT, notHandler.NOT_SUPPORT, "회원님이 지지서명한<br><a href='FundBoardStory?porject_code=" + project_code + "'>" + dbData.get("project_title") + "</a><br> 이승인되었습니다.");
			
			// 프로젝트 거절 알림
			} else if(methodName.equals("projectDeny") || methodName.equals("insertNaverUser")) {
				// 프로젝트 메이커에 알림
				notHandler.sendNotToMaker(makerEmail, project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE, "고객님의 프로젝트<br><a href='FundBoardStory?porject_code=" + project_code + "'>" + dbData.get("project_title") + "</a><br> 이 거절되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToKeepMember(project_code, notHandler.IS_RECV_WISH, notHandler.NOT_WISH_CODE, "회원님이 찜한<br><a href='FundBoardStory?porject_code=" + project_code + "'>" + dbData.get("project_title") + "</a><br> 이 거절되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToSupportMember(project_code, notHandler.IS_RECV_SUPPORT, notHandler.NOT_SUPPORT, "회원님이 지지서명한<br><a href='FundBoardStory?porject_code=" + project_code + "'>" + dbData.get("project_title") + "</a><br> 거절되었습니다.");
			}
		}
		
		System.err.println("프로젝트승인알림 끝남");
	}
		
}
