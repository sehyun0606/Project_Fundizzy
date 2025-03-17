package com.itwillbs.project_fundizzy.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.FundMapper;
import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;
import com.itwillbs.project_fundizzy.vo.ProjectStoryVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Service
public class FundService {
	@Autowired
	private FundMapper mapper;
	
	//펀딩 리스트 출력 ( 펀딩+ 메인페이지 )
	public List<Map<String, Object>> getFundList() {
		// TODO Auto-generated method stub
		return mapper.selectFundList();
	}
	//프로젝트 대표사진 및 상세사진 가져오기 
	public List<ProjectStoryVO> getProjectStory(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectProjectStory(project_code);
	}

	//프로젝트 board 출력
	public Map<String, Object> getFundBoard(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectFundBoard(project_code);
	}
	
	//프로젝트 board 출력 - 리워드 테이블 가져오기 
	public List<Map<String, Object>> getReward(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectReward(project_code);
	}
	
	//프로젝트 board 출력 - 찜 테이블 가져오기 
	public Map<String, String> getKeep(String email, String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectKeep(email, project_code);
	}
	
	//찜 등록 
	public int registKeep(String email, String project_code) {
		// TODO Auto-generated method stub
		return mapper.insertKeep(email, project_code);
	}
	
	//찜 삭제
	public void removeKeep(String email, String project_code) {
		// TODO Auto-generated method stub
		 mapper.deleteKeep(email, project_code);
	}
	
	//새소식 가져오기 
	public List<Map<String, Object>> getNews(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectNews(project_code);
	}
	
	//지지서명 목록 출력 
	public List<Map<String, Object>> getSupportList(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectSupportList(project_code);
	}
	//지지서명 등록
	public int getSupportSignature(String project_code, String email, String supportContent, String supportKeyword) {
		// TODO Auto-generated method stub
		return mapper.insertSupportSignature(project_code, email, supportContent, supportKeyword);
	}
	//지지서명 댓글 출력
	public List<Map<String, Object>> getReplyList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.selectReplyList(map);
	}
	//지지서명 댓글 등록
	public int registSupportReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertSupportReply(map);
	}
	//지지서명 댓글 삭제 
	public int updateSupportReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.updateSupportReply(map);
	}
	//지지서명 댓글 작성자 ip가져오기
	public Object getReplyWriter(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.selectReplyWriter(map);
	}
	
	//펀딩 내역 테이블 가져오기
	public List<Map<String, Object>> getFundHistory(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectFundHistory(project_code);
	}
	//-------------------------------------------------오른쪽 부분 --------------------------------------
	//리워드 가져오기 
	public List<Map<String, Object>> getPaymentReward(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectPaymentReward(project_code);
	}
	//선택한 리워드 가져오기 
	public RewardVO getPaymentSelectedReward(String project_code, String reward_code) {
		// TODO Auto-generated method stub
		return mapper.selectPaymentSelectedReward(project_code, reward_code);
	}
	
	public Map<String, Object> getPaymentPayMember(String email) {
		// TODO Auto-generated method stub
		return mapper.selectPaymentPayMember(email);
	}
	
	
	
//	//페이로 결제한 내역 계산 
//	public int registPaymentPay(Map<String, Object> map) {
//		// TODO Auto-generated method stub
//		return mapper.insertPaymentPay(map);
//	}
//	
//	//펀딩내역 input 
//	public int registFundHistory(Map<String, Object> map, Map<String, Object> paramMap) {
//		// TODO Auto-generated method stub
//		return mapper.insertFundHistory(map, paramMap);
//	}
//	//결제내역(payment테이블) input 
//	public int registPayment(Map<String, Object> map) {
//		// TODO Auto-generated method stub
//		return mapper.insertPayment(map);
//	}
//	
//	
//	//배송내역(shipment테이블) input 
//	public int registShipMent(Map<String, Object> map) {
//		// TODO Auto-generated method stub
//		return mapper.insertShipment(map);
//	}
	
	// 결제진행시 insert 작업 진행
//	@Transactional
	public Boolean insertForPayment(Map<String, String> map) {
		// 전화번호 형식 변환(- 제거)
		map.put("phone_num", ((String)map.get("phone_num")).replace("-", ""));
		System.out.println("map" + map);
		// 1. 결제 정보 저장 성공
		// 1단계 - 결제 작업
		int result1 = mapper.insertPaymentPay(map);
		if(result1 > 0) {
		    System.out.println("1단계 성공");
		}else {
		    System.out.println("1단계 실패");
		}

		// 2단계 - 결제 완료 후 내역 insert
		int result2 = mapper.insertPayment(map);
		if(result2 > 0) {
		    System.out.println("2단계 성공");
		}else {
		    System.out.println("2단계 실패");
		}

		// 3단계 - 배송지 입력
		int result3 = mapper.insertShipment(map);
		if(result3 > 0) {
		    System.out.println("3단계 성공");
		}else {
		    System.out.println("3단계 실패");
		}
		
		// 디비 반복작업을위해 전달할 객체
	    List<Map<String, String>> sendList = new ArrayList<Map<String, String>>();
	    
	    // 리워드 등록가능 개수 5, 선택한 리워드 개수가 랜덤으로 넘어와서 반복문으로 판별
	    for(int i = 1; i < 6; i ++) {
	    	if(map.get("rewardCount" + i) != null && !map.get("rewardCount" + i).equals("0")) {
	    		Map<String, String> reward = new HashMap<String, String>();
	    		reward.put("reward_code", map.get("reward" + i));
	    		reward.put("product_count", map.get("rewardCount" + i));
	    		reward.putAll(map);
	    		sendList.add(reward);
	    	}
	    }
	    System.out.println("sendList ===== " + sendList);
		// 4단계 - 펀딩내역(fund-history) 입력
		int result4 = mapper.insertFundHistory(sendList, map);
		if(result4 > 0) {
		    System.out.println("4단계 성공");
		}else {
		    System.out.println("4단계 실패");
		}

		// 총합을 체크하여 모든 단계가 성공했는지 확인
		if(result1 <= 0 || result2 <= 0 || result3 <= 0 || result4 <= 0) {
		    // 하나라도 실패한 경우
		    System.out.println("어떤 단계에서 실패했습니다.");
		    return false;  
		}
		return true;
	}

	public List<Map<String, Object>> getResultList(String pay_tran_id) {
		// TODO Auto-generated method stub
		return mapper.selectResultList(pay_tran_id);
	}
// 구매자 수 출력
	public int getFundHistoryCount(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectFundHistoryCount(project_code);
	}
	
	//배송비 출력을 위한 project_info 테이블 가져오기
	public Map<String, Object> getProjectInfo(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectProjectInfo(project_code);
	}




}
