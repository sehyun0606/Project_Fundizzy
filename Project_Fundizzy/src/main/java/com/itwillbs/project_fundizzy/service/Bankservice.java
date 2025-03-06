package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.handler.BankApiClient;
import com.itwillbs.project_fundizzy.handler.BankValueGenerator;
import com.itwillbs.project_fundizzy.mapper.BankMapper;
import com.itwillbs.project_fundizzy.vo.BankAccount;
import com.itwillbs.project_fundizzy.vo.BankToken;
@Service
public class Bankservice {
	@Autowired
	private BankApiClient bankApiClient;
	
	@Autowired
	private BankMapper mapper;
	//토큰 가져오기 
	public BankToken getAccessToken(Map<String, String> authResponse) {
		return bankApiClient.requestAccessToken(authResponse);
	}
//db에 token 저장 
	public void registAccessToken(Map<String, Object> map) {
		//토큰 가져오기
		String access_token = mapper.selectAccessToken(map);
		//토큰이 null이면 insert
		if(access_token == null) {
			mapper.insertAccessToken(map);
		//그렇지 않으면 update
		} else {
			mapper.updateAccessToken(map);
		}
		 
	}
	
	// 토큰 조회
	public BankToken getBankAccessTokenInfo(String email) {
		return mapper.selectTokenInfo(email);
	}
	//은행 정보 조회 
	public Map<String, Object> getBankUserInfo(BankToken bankToken) {
		// TODO Auto-generated method stub
		return bankApiClient.requestBankUserInfo(bankToken);
	}
	//계좌 정보 조회
	public Map<String, String> getAccountDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return bankApiClient.reqeustAccountDetail(map);
	}
	
	//---------------------- MyPageController랑 연결된 부분 ------------------------------------- 
	//출금결과 db에 저장 
	public Map<String, Object> getDBTransactionResult(String bank_tran_id) {
		// TODO Auto-generated method stub
		return mapper.selectDBTransactionResult(bank_tran_id);
	}
	//등록된 계좌정보 조회
	public BankAccount getDBAccountInfo(String user_seq_no) {
		// TODO Auto-generated method stub
		return mapper.selectDBAccountInfo(user_seq_no);
	}
	//출금이체 요청을 리턴
	public Map<String, Object> requestCharge(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return bankApiClient.requestCharge(map);
	}
	
	//이체결과 저장 
	public void registChargeResult(Map<String, Object> chargeResult) {
		// TODO Auto-generated method stub
		chargeResult.put("tran_id", BankValueGenerator.getTranId());
		mapper.insertChargeResult(chargeResult, "WI");
	}
	

}
