package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.FundMapper;
import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;

@Service
public class FundService {
	@Autowired
	private FundMapper mapper;
	
	
	//프로젝트 board 출력
	public Map<String, Object> getFundBoard(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectFundBoard(project_code);
	}
	//지지서명 목록 출력 
	public List<Map<String, Object>> getSupportList() {
		// TODO Auto-generated method stub
		return mapper.selectSupportList();
	}
	//지지서명 등록
	public int getSupportSignature(int project_code, String email, String supportContent, String supportKeyword) {
		// TODO Auto-generated method stub
		return mapper.insertSupportSignature(project_code, email, supportContent, supportKeyword);
	}
	//지지서명 댓글 출력
	public List<Map<String, Object>> getReplyList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.selectReplyList(map);
	}
	//지지서명 댓글 등록
	public int registSupportReply(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertSupportReply(map);
	}
	//지지서명 댓글 삭제
	public int removeSupportReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.deleteSupportReply(map);
	}
	//지지서명 댓글 작성자 ip가져오기
	public Object getReplyWriter(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.selectReplyWriter(map);
	}
	//-------------------------------------------------오른쪽 부분 --------------------------------------
	//리워드 가져오기 
	public Map<String, Object> getPaymentReward(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectPaymentReward(project_code);
	}
	public Map<String, Object> getPaymentPayMember(String email) {
		// TODO Auto-generated method stub
		return mapper.selectPaymentPayMember(email);
	}
	
	//페이로 결제한 내역 계산 
	public int registPaymentPay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertPaymentPay(map);
	}
//	//페이 잔액 업데이트 
////	public FundizzyPay registBalancePay(Map<String, Object> map) {
//		// TODO Auto-generated method stub
//		return mapper.updateBalancePay(map);
//	}
	
	//펀딩내역 input 
	public int registFundHistory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertFundHistory(map);
	}
	//결제내역(payment테이블) input 
	public int registPayment(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertPayment(map);
	}
	
	
	//배송내역(shipment테이블) input 
	public int registShipMent(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertShipment(map);
	}

	
	
	

}
