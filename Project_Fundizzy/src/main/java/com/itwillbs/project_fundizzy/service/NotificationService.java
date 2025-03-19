package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.NotificationMapper;

@Service
public class NotificationService {
	@Autowired
	private NotificationMapper notificationMapper;
	
	// 회원가입시 선택한 알림정보를 알림설정테이블에 입력
	public void registNOTSetInfo(String email) {
		notificationMapper.insertNOTSetInfo(email);
	}
	
	// 해당 회원의 알림설정정보 조회
	public Map<String, Object> getMemberNOTSetInfo(String email) {
		return notificationMapper.selectMemberNOTSetInfo(email);
	}
	
	// 알림설정 옵션 변경
	public int changeNOTSetOption(Map<String, String> optionMap) {
		return notificationMapper.updateNOTSetOption(optionMap);
	}
	
	// 회원가입 알림 알림테이블에 등록
	public void registNOTInfo(Map<String, String> map) {
		notificationMapper.insertNOTInfo(map);
	}
	
	// 내 알림 리스트 조회
	public List<Map<String, Object>> getMyNOTList(String email) {
		return notificationMapper.selectMyNOTList(email);
	}
	
	// 해당프로젝트를 찜한 멤버조회
	public List<String> getKeepMemberEmail(String project_code) {
		return notificationMapper.selectKeepMember(project_code);
	}
	
	// 해당프로젝트를 지지서명한 멤버조회
	public List<String> getSupportMemberEmail(String project_code) {
		return notificationMapper.selectSupprotMember(project_code);
	}
	
	// 해당프로젝트 참여한 모든 멤버 조회
	public List<String> getJoinMemberEmail(String project_code) {
		return notificationMapper.selectJoinMember(project_code);
	}
	
	// 프로젝트 정보조회
	public Map<String, String> getProjectInfo(String project_code) {
		return notificationMapper.selectProjectInfo(project_code);
	}
	
	// 알림페이지 접근시 현재까지 받은 알림 읽음처리
	public void changeNotStatus(String email) {
		notificationMapper.updateNotStatus(email);
	}
	
	// 읽지않은 알림 수 조회
	public int getUnReadNOTCount(String email) {
		return notificationMapper.selectUnReadCount(email);
	}
	
	// 알림 삭제
	public int removeNotFromDB(String[] codeArr) {
		return notificationMapper.deleteNotFromDB(codeArr);
	}
	
	// 정산상태 조회
	public String getSettlementStatus(String project_code) {
		return notificationMapper.selectSettlementStatus(project_code);
	}
	
	// 페이먼트 코드로 해당 회원의 정보, 구매상품 조회
	public List<Map<String, String>> getRewardListFromPaymentCode(String payment_code) {
		return notificationMapper.selectRewardList(payment_code);
	}
	
	
}
