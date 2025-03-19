package com.itwillbs.project_fundizzy.aop;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Component;

import com.itwillbs.project_fundizzy.handler.NotificationHandler;
import com.itwillbs.project_fundizzy.service.FundService;
import com.itwillbs.project_fundizzy.service.MemberService;
import com.itwillbs.project_fundizzy.service.NotificationService;
import com.itwillbs.project_fundizzy.service.ProjectStateService;
import com.itwillbs.project_fundizzy.vo.ProjectDateVO;

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
	
	@Autowired
	private FundService fundService;
	
	// 갱신전 달성률 저장을 위한 멤버변수
	private int progressBefore = 0;
	
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
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.AdminProjectService.project*(..))")
	public void projectAcceptAndDeny(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		
		String project_code = (String)joinPoint.getArgs()[0];
		
		// 상태 업데이트 작업 완료된지 파악
		Map<String, String> dbData = notificationService.getProjectInfo(project_code);
		String makerEmail = dbData.get("member_email");
		
		// 승인, 거절전 상태 before
		if(!dbData.get("approve_stat").equals("before")) {
			//프로젝트 승인 알림 
			if(methodName.equals("projectAccept")) {
				// 프로젝트 메이커에 알림
				notHandler.sendNotToMaker(makerEmail, project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
						"고객님의 프로젝트<br><a href='FundBoardStory?project_code=" + project_code + "'>"
				+ dbData.get("project_title") + "</a><br>이(가) 승인되었습니다.<br><a href='SupportPage'>프로젝트 관리 페이지</a>에서 날짜를 설정 해 주세요!");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToKeepMember(project_code, notHandler.IS_RECV_WISH, notHandler.NOT_WISH_CODE,
						"회원님이 찜한<br><a href='FundBoardStory?project_code=" + project_code + "'>"
				+ dbData.get("project_title") + "</a><br>이(가) 승인되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToSupportMember(project_code, notHandler.IS_RECV_SUPPORT, notHandler.NOT_SUPPORT,
						"회원님이 지지서명한<br><a href='FundBoardStory?project_code=" + project_code + "'>"
				+ dbData.get("project_title") + "</a><br>이(가) 승인되었습니다.");
			
			// 프로젝트 거절 알림
			} else if(methodName.equals("projectDeny") || methodName.equals("insertNaverUser")) {
				// 프로젝트 메이커에 알림
				notHandler.sendNotToMaker(makerEmail, project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
						"고객님의 프로젝트<br><a href='FundBoardStory?project_code=" + project_code + "'>"
				+ dbData.get("project_title") + "</a><br>이(가) 거절되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToKeepMember(project_code, notHandler.IS_RECV_WISH, notHandler.NOT_WISH_CODE,
						"회원님이 찜한<br><a href='FundBoardStory?project_code=" + project_code + "'>"
				+ dbData.get("project_title") + "</a><br>이(가)  거절되었습니다.");
				// 해당프로젝트의 찜 회원에게 알림
				notHandler.sendNotToSupportMember(project_code, notHandler.IS_RECV_SUPPORT, notHandler.NOT_SUPPORT,
						"회원님이 지지서명한<br><a href='FundBoardStory?project_code=" + project_code + "'>"
				+ dbData.get("project_title") + "</a><br>이(가) 거절되었습니다.");
			}
		}
		
	}
	
	// 프로젝트 정산신청(선정산, 최종정산) 알림(확인 필요!)
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.AdminSettlementService.registSettlementPay(..))")
	public void projectSettlementNot(JoinPoint joinPoint, int result) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		Map<String, Object> map = (Map<String, Object>)args[0];
		String project_code = (String)map.get("project_code");
		String email = (String)map.get("email");
		
		// joinpoin의 리턴값이 0이면 실행 실패이므로 알림 작업 안함
		if(result == 0) {
			return;
		}
		
		// 상태 업데이트 작업 완료된지 파악(joinpoint에 리턴값이 void라 디비로 판별)
		Map<String, String> dbData = notificationService.getProjectInfo(project_code);
		
		// 해당 프로젝트의 정산상태값 조회후 알림 전송
		String settlement_status = notificationService.getSettlementStatus(project_code);
		
		// 선정산 완료 알림
		if(settlement_status.equals("SET04")) {
			notHandler.sendNotToMaker(email, project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
					"회원님의 프로젝트<br><a href='FundBoardStory?project_code=" + project_code + "'>"
			+ dbData.get("project_title") + "</a><br>의 선정산이 완료되었습니다.");
		// 최종정산 완료 알림
		} else if(settlement_status.equals("SET07")) {
			notHandler.sendNotToMaker(email, project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
					"회원님의 프로젝트<br><a href='FundBoardStory?project_code=" + project_code + "'>"
			+ dbData.get("project_title") + "</a><br>의 최종정산 완료되었습니다.");
		}
	}
	
	// 대표계좌등록 완료 알림
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.Bankservice.registBankAccount(..))")
	public void registBankAccountNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		Map<String, Object> map = (Map<String, Object>)args[0];
		//회원 정보조회
		String email = (String)map.get("email");
		
		if(notHandler.isReceiveThisNOT(email, notHandler.IS_RECV_SITE)) {
			notHandler.registNOTOnDB(email, "", notHandler.NOT_SITE_CODE, "회원님의 대표계좌가 설정되었습니다.<br>펀디지 페이사용이 가능합니다.<br>"
				+ "한층 향상된 크라우드펀딩 경험을 즐겨보세요!<br><a href='PayPage'>페이로 이동</a>");
		}
	}
	
	// 프로젝트 찜 알림
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.FundService.registKeep(..))")
	public void registKeepNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		String email = (String)args[0];
		String project_code = (String)args[1];
		
		//프로젝트 정보 조회
		Map<String, String> projectInfo = notificationService.getProjectInfo(project_code);
		
		
		if(notHandler.isReceiveThisNOT(email, notHandler.IS_RECV_WISH)) {
			notHandler.registNOTOnDB(email, project_code, notHandler.NOT_WISH_CODE, "프로젝트 - <a href='FundBoardStory?project_code=" + project_code + "'>"
					+ projectInfo.get("project_title") + "</a> 찜!<br>앞으로 이 프로젝트의 최신정보가 알림으로 전송됩니다.");
		}
	}
	
	// 지지서명 등록 알림
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.FundService.getSupportSignature(..))")
	public void registSupportNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		String email = (String)args[1];
		String project_code = (String)args[0];
		String supportContent = (String)args[2];
		//지지서명 키워드
		String supportKeyword = (String)args[3];
		
		//프로젝트 정보 조회
		Map<String, String> projectInfo = notificationService.getProjectInfo(project_code);
		//메이커 정보 조회
		Map<String, String> makerInfo = memberservice.getMember(projectInfo.get("member_email"));
		//지지서명한 서포터 저보조회
		Map<String, String> supportInfo = memberservice.getMember(email);
		
		notHandler.sendNotToMaker(makerInfo.get("email"), project_code, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
				supportInfo.get("nickname") + " 님이 회원님의 프로젝트 <a href='FundBoardStory?project_code=" + project_code + "'>"
						+ projectInfo.get("project_title")
						+ "</a>에 지지서명하였습니다.<span class='keyword'></span><input type='hidden' value='" + supportKeyword + "'>");
		
		if(notHandler.isReceiveThisNOT(email, notHandler.IS_RECV_SUPPORT)) {
			notHandler.registNOTOnDB(email, project_code, notHandler.NOT_SUPPORT, " <a href='FundBoardStory?project_code=" + project_code + "'>"
					+ projectInfo.get("project_title")
					+ "</a>에 지지서명 꽝!!<span class='keyword'></span><input type='hidden' value='" + supportKeyword + "'>");
		}
		
	}
	
	// 회원이 프로젝트 참가시 10% 달성시마다 알림보내고 100%달성시 펀딩 성공 알림을위해 이전 달성률조회
	@Before("execution(* com.itwillbs.project_fundizzy.service.FundService.insertForPayment*(..))")
	public void progressProjectBefore(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		Map<String, String> map = (Map<String, String>)args[0];
		String project_code = map.get("project_code");
		
		// 이전 달성률 조회
		progressBefore = fundService.getProgressOfProject(project_code);
	}
	
	// 프로젝트의 시작, 끝 알림
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.ProjectMakerService.setProjectDate*(..))")
	public void projectStartEndNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		
		//메이커가 등록한 프로젝트 시간 vo
		ProjectDateVO date = (ProjectDateVO)args[0];
		
		//프로젝트 코드
		String project_code = (String)args[1];
		
		// 프로젝트 시작 날짜
		Date project_start_date = date.getProject_start_date();
		// 스케줄러사용을 위해 util.Date 사용
        java.util.Date start_date = new java.util.Date(project_start_date.getTime());
        
        // 프로젝트 끝 날짜
        Date project_end_date = date.getProject_end_date();
        java.util.Date end_date = new java.util.Date(project_start_date.getTime());
        
        System.err.println(project_start_date);
        System.err.println(project_end_date);
        
        // 현재 시간 가져오기
        Calendar calendar = Calendar.getInstance();

        // 1분 추가
        calendar.add(Calendar.MINUTE, 1);
        
        // 현재 시간 가져오기
        Calendar calendar2 = Calendar.getInstance();
        
        // 1분 추가
        calendar2.add(Calendar.MINUTE, 2);

        // java.util.Date 객체로 변환
        java.util.Date oneMinuteLater = calendar.getTime();
        // java.util.Date 객체로 변환
        java.util.Date oneMinuteLater2 = calendar2.getTime();
        
        // 스케줄 시작 알림
        notHandler.scheduleStartNotification(oneMinuteLater, project_code);
        
        // 스케줄 종료 알림
        notHandler.scheduleEndNotification(oneMinuteLater2, project_code);

	}
	
	// 회원이 프로젝트 참가시 10% 달성시마다 알림보내고 100%달성시 펀딩 성공 알림
	// 회원이 프로젝트 참가할때마다 알림이가면 너무 많은 알림이가므로 달성률만 표시
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.FundService.insertForPayment*(..))")
	public void progressProjectNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		Map<String, String> map = (Map<String, String>)args[0];
		String project_code = map.get("project_code");
		
		//프로젝트 정보 조회
		Map<String, String> projectInfo = notificationService.getProjectInfo(project_code);
		//메이커 정보 조회
		Map<String, String> makerInfo = memberservice.getMember(projectInfo.get("member_email"));
		//지지서명한 서포터 저보조회
		Map<String, String> supportInfo = memberservice.getMember(map.get("email"));
		
		// 달성률 계산
		int progress = fundService.getProgressOfProject(project_code);
		
		// 10으로나눈 몫이 다를경우 10%단위 달성률이 변했다는 의미
		if(progress / 10 != progressBefore / 10) {
			if(progress > 100 && progress < 110) {
				notHandler.sendNotToMaker(makerInfo.get("email"), project_code
						, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
						"프로젝트 <a href='FundBoardStory?project_code=" + project_code + "'>"
								+ projectInfo.get("project_title") + "</a>100% 달성!<br> 프로젝트 성공하였습니다.");
			} else {
				notHandler.sendNotToMaker(makerInfo.get("email"), project_code
						, notHandler.IS_RECV_MY, notHandler.NOT_MYPROJECT_CODE,
						"프로젝트 <a href='FundBoardStory?project_code=" + project_code + "'>"
								+ projectInfo.get("project_title") + "</a>에" + supportInfo.get("nickname") + "님 참여!(달성률 - " + progress + "%)");
				
			}
		}
	}
	
	// 메이커가 프로젝트에 새소식 등록 알림
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.ProjectStateService.registNewsBoard(..))")
	public void addNewsBoardNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		Map<String, String> map = (Map<String, String>)args[0];
		String project_code = map.get("project_code");
		
		//프로젝트 정보 조회
		Map<String, String> projectInfo = notificationService.getProjectInfo(project_code);
		
		notHandler.sendNotToJoinMember(project_code, notHandler.IS_RECV_JOIN, notHandler.NOT_JOINPROJECT_CODE,
				"프로젝트 <a href='FundBoardNew?project_code=" + project_code + "'>"
						+ projectInfo.get("project_title") + "</a>에 새소식이 등록되었습니다.");
	}
	
	// 메이커가 프로젝트에 발송정보 입력시 해당 회원에게 발송정보 입력 알림
	@AfterReturning("execution(* com.itwillbs.project_fundizzy.service.ProjectStateService.modifyShipmentStatus(..))")
	public void registShipmentInfoNot(JoinPoint joinPoint) {
		// 파라미터
		Object[] args = joinPoint.getArgs();
		Map<String, String> map = (Map<String, String>)args[0];
		String payment_code = map.get("payment_code");
		
		// 페이먼트 코드로 해당 회원 구매상품 조회
		List<Map<String, String>> rewardList = notificationService.getRewardListFromPaymentCode(payment_code);
		String project_code = rewardList.get(0).get("project_code");
		
		// 알림 전달할 리워드스트링
		String rewardStr = "";
		
		int count = 1;
		
		for(Map<String, String> reward : rewardList) {
			if(rewardList.size() == count) {
				rewardStr += reward.get("product_name");
				break;
			}
			rewardStr += reward.get("product_name") + "<br>";
			count++;
		}
		
		// 구매한 상품 배송 시작됨 알림 
		notHandler.sendNotToJoinMember(project_code, notHandler.IS_RECV_JOIN, notHandler.NOT_JOINPROJECT_CODE,
				"회원님의 리워드가 배송시작 되었습니다.<br>배송조회가 가능합니다<a href='FundHistory'>"
				+ "(이동하기)</a><br> - 리워드상품 - <br>" + rewardStr);
	}
}
