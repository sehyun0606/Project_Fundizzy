package com.itwillbs.project_fundizzy.handler;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.service.NotificationService;

@Component
public class NotificationHandler {
    // 알림 코드 상수
    public final String NOT_SITE_CODE = "NOT01"; // 사이트 알림
    public final String NOT_SUPPORT = "NOT02"; // 지지서명한프로젝트 알림
    public final String NOT_WISH_CODE = "NOT03"; // 찜한 프로젝트 알림
    public final String NOT_MYPROJECT_CODE = "NOT04"; // 내 프로젝트 알림
    public final String NOT_JOINPROJECT_CODE = "NOT05"; // 내가 참여한 프로젝트 알림
    
    // 알림 설정 상수
    public final String IS_RECV_NOT = "is_recv_notification"; // 알림 수신 여부(전체 알림수신여부)
    public final String IS_RECV_EMAIL = "is_recv_by_email"; // 이메일 수신 여부
    public final String IS_RECV_SMS = "is_recv_by_sms"; // SMS 알림 수신 여부
    public final String IS_RECV_SITE = "is_recv_site"; // 사이트의 알림 수신 여부
    public final String IS_RECV_SUPPORT = "is_recv_support"; // 지지서명한 메이커에 대한 알림 수신 여부
    public final String IS_RECV_WISH = "is_recv_wish"; // 찜한 프로젝트에 대한 알림 수신 여부
    public final String IS_RECV_MY = "is_recv_myproject"; // 내 프로젝트에 대한 알림 수신 여부
    public final String IS_RECV_JOIN = "is_recv_joinproject"; // 내가 참여한 프로젝트에 대한 알림 수신 여부
    
    @Autowired
    private NotificationService notificationService;
    
    // 스케줄러사용을 위한 의존성주입
    @Autowired
    private TaskScheduler scheduler;
    
    @Autowired
    private MailClient mailClient;
	    
    // 알림코드에 따른 메시지 수신 여부 판단 메서드
	public Boolean isReceiveThisNOT(String email, String is_recv) {
		// 디비에 저장된 회원의 알림 옵션 정보 조회
		Map<String, Object> dbNOTOptionInfo = notificationService.getMemberNOTSetInfo(email);
		
		// 알림 수신 여부 - 전체적인 알림을 받을 것인가에 대한 판별
		// N일 경우 메서드 작업 종료
		if(((String)dbNOTOptionInfo.get(IS_RECV_NOT)).equals("N")) {
			return false;
			// 알림코드에 해당하는 알림 수신 여부 판별
		} else if(((String)dbNOTOptionInfo.get(is_recv)).equals("N")) {
			return false;
		} else {
			return true;
		}
	}
	
	// 해당회원의 메일 수신 여부 판별
	public Boolean isReceiveMail(String email) {
		// 디비에 저장된 회원의 알림 옵션 정보 조회
		Map<String, Object> dbNOTOptionInfo = notificationService.getMemberNOTSetInfo(email);
		
		// 알림 수신 여부 - 전체적인 알림을 받을 것인가에 대한 판별
		// N일 경우 메서드 작업 종료
		if(((String)dbNOTOptionInfo.get(IS_RECV_NOT)).equals("N")) {
			return false;
			// 알림코드에 해당하는 알림 수신 여부 판별
		} else if(((String)dbNOTOptionInfo.get(IS_RECV_EMAIL)).equals("N")) {
			return false;
		} else {
			return true;
		}
	}
	
	// 알림테이블에 알림등록 메서드
	public void registNOTOnDB(String email, String project_code, String not_code, String notification_content) {
		// 알림등록을 위한 맵 객체
		Map<String, String> notificationMap = new HashMap<String, String>();
		
		notificationMap.put("member_email", email);
		notificationMap.put("common_code", not_code);
		notificationMap.put("notification_content", notification_content);
		notificationMap.put("project_code", project_code);
		
		// 알림등록
		notificationService.registNOTInfo(notificationMap);
	}
	
	// 프로젝트메이커에게 알림 전송
	public void sendNotToMaker(String email, String project_code, String is_recv, String not_code,  String content) {
		// 해당알림코드 전송여부 판별
		if(isReceiveThisNOT(email, is_recv)) {
			// 알림등록 메서드 호출
			registNOTOnDB(email, project_code, not_code, content);
		}
		
		// 알림 이메일 수신 여부판별후 이메일 전송
		if(isReceiveMail(email)) {
			// 알림내용안의 <a>태그 주소 변경
			String newContent = content.replace("<a href='", "<a href='http://c5d2409t1p2.itwillbs.com/");
			
			mailClient.sendMail(email, "Fundizzy 알림", newContent);
		}
	}
	
	// 프로젝트 찜한 전체 회원에게 알림 전송
	public void sendNotToKeepMember(String project_code, String is_recv, String not_code,  String content) {
		// 해당프로젝트 찜한 멤버 이메일 조회
		List<String> keepMember = notificationService.getKeepMemberEmail(project_code);
		
		if(keepMember.size() > 0) {
			for(String email : keepMember) {
				if(isReceiveThisNOT(email, is_recv)) {
					// 알림등록 메서드 호출
					registNOTOnDB(email, project_code, not_code, content);
				}
				
				// 알림 이메일 수신 여부판별후 이메일 전송
				if(isReceiveMail(email)) {
					// 알림내용안의 <a>태그 주소 변경
					String newContent = content.replace("<a href='", "<a href='http://c5d2409t1p2.itwillbs.com/");
					
					mailClient.sendMail(email, "Fundizzy 알림", newContent);
				}
			}
		}
		
	}
	
	// 프로젝트 지지서명한 전체 회원에게 알림전송
	public void sendNotToSupportMember(String project_code, String is_recv, String not_code, String content) {
		// 해당프로젝트 지지서명한 멤버 이메일 조회
		List<String> supportMember = notificationService.getSupportMemberEmail(project_code);
		
		if(supportMember.size() > 0) {
			for(String email : supportMember) {
				if(isReceiveThisNOT(email, is_recv)) {
					// 알림등록 메서드 호출
					registNOTOnDB(email, project_code, not_code, content);
				}
				
				// 알림 이메일 수신 여부판별후 이메일 전송
				if(isReceiveMail(email)) {
					// 알림내용안의 <a>태그 주소 변경
					String newContent = content.replace("<a href='", "<a href='http://c5d2409t1p2.itwillbs.com/");
					
					mailClient.sendMail(email, "Fundizzy 알림", newContent);
				}
			}
		}
	}
	
	// 프로젝트 참여한 전체 회원에게 알림전송
	public void sendNotToJoinMember(String project_code, String is_recv, String not_code, String content) {
		// 해당프로젝트 지지서명한 멤버 이메일 조회
		List<String> joinMember = notificationService.getJoinMemberEmail(project_code);
		
		if(joinMember.size() > 0) {
			for(String email : joinMember) {
				if(isReceiveThisNOT(email, is_recv)) {
					// 알림등록 메서드 호출
					registNOTOnDB(email, project_code, not_code, content);
				}
				
				// 알림 이메일 수신 여부판별후 이메일 전송
				if(isReceiveMail(email)) {
					// 알림내용안의 <a>태그 주소 변경
					String newContent = content.replace("<a href='", "<a href='http://c5d2409t1p2.itwillbs.com/");
					
					mailClient.sendMail(email, "Fundizzy 알림", newContent);
				}
			}
		}
	}
	
	// 프로젝트 시작 알림 스케줄링 메서드
    public void scheduleStartNotification(java.util.Date startTime, String projectCode) {
    	scheduler.schedule(() -> {
    		// 프로젝트 정보 조회
    		Map<String, String> projectInfo = notificationService.getProjectInfo(projectCode);
    		
    		// 메이커에게 알림 전송
    		sendNotToJoinMember(projectCode, IS_RECV_MY, NOT_MYPROJECT_CODE,
    				"프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
							+ projectInfo.get("project_title") + "</a>가 시작되었습니다.");
    		
    		// 동시에 인설트되는걸 방지하기위해 1초 타이머설정
	        try {
	            Thread.sleep(1000);
	        } catch (InterruptedException e) {
	            e.printStackTrace();
	        }
    		
    		//찜한 서포터에게 알림 전송
    		sendNotToKeepMember(projectCode, IS_RECV_WISH, NOT_WISH_CODE, "회원님이 찜한 프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
							+ projectInfo.get("project_title") + "</a>가 시작되었습니다.");
    	
    		// 동시에 인설트되는걸 방지하기위해 1초 타이머설정
    		try {
    			Thread.sleep(1000);
    		} catch (InterruptedException e) {
    			e.printStackTrace();
    		}
    		
    		//지지서명한 서포터에게 알림 전송
    		sendNotToSupportMember(projectCode, IS_RECV_SUPPORT, NOT_SUPPORT, "회원님이 지지서명한 프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
							+ projectInfo.get("project_title") + "</a>가 시작되었습니다.");
        }, startTime);
    }

    // 프로젝트 종료 알림 스케줄링 메서드
    public void scheduleEndNotification(java.util.Date endTime, String projectCode) {
    	scheduler.schedule(() -> {
    		// 프로젝트 정보 조회
    		Map<String, String> projectInfo = notificationService.getProjectInfo(projectCode);
    		
    		// 메이커에게 알림 전송
    		sendNotToJoinMember(projectCode, IS_RECV_MY, NOT_MYPROJECT_CODE,
    				"프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
    						+ projectInfo.get("project_title") + "</a>가 종료되었습니다.");
    		
    		// 동시에 인설트되는걸 방지하기위해 1초 타이머설정
    		try {
    			Thread.sleep(1000);
    		} catch (InterruptedException e) {
    			e.printStackTrace();
    		}
    		
    		//찜한 서포터에게 알림 전송
    		sendNotToKeepMember(projectCode, IS_RECV_WISH, NOT_WISH_CODE, "회원님이 찜한 프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
    				+ projectInfo.get("project_title") + "</a>가 종료되었습니다.");
    		
    		// 동시에 인설트되는걸 방지하기위해 1초 타이머설정
    		try {
    			Thread.sleep(1000);
    		} catch (InterruptedException e) {
    			e.printStackTrace();
    		}
    		
    		//지지서명한 서포터에게 알림 전송
    		sendNotToSupportMember(projectCode, IS_RECV_SUPPORT, NOT_SUPPORT, "회원님이 지지서명한 프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
    				+ projectInfo.get("project_title") + "</a>가 종료되었습니다.");
    		
    		// 동시에 인설트되는걸 방지하기위해 1초 타이머설정
    		try {
    			Thread.sleep(1000);
    		} catch (InterruptedException e) {
    			e.printStackTrace();
    		}
    		
    		//프로젝트 참가한 서포터에게 알림 전송
    		sendNotToJoinMember(projectCode, IS_RECV_JOIN, NOT_JOINPROJECT_CODE, "회원님이 참가한 프로젝트 <a href='FundBoardStory?projectject_code=" + projectCode + "'>"
    				+ projectInfo.get("project_title") + "</a>가 종료되었습니다.");
        }, endTime);
    }
}
