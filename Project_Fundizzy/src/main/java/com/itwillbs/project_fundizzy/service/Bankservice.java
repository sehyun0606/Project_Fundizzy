package com.itwillbs.project_fundizzy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.handler.BankApiClient;
import com.itwillbs.project_fundizzy.handler.BankValueGenerator;
import com.itwillbs.project_fundizzy.mapper.BankMapper;
import com.itwillbs.project_fundizzy.vo.BankAccount;
import com.itwillbs.project_fundizzy.vo.BankToken;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;
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
	public int registChargeResult(Map<String, Object> chargeResult) {
		//uuid 만들기 - 이체한거 들고오기 위해 
		chargeResult.put("tran_id", BankValueGenerator.getTranId());
		return mapper.insertChargeResult(chargeResult, "WI");
	}
	
	//페이 충전 후 잔액 계산 
	public int registPayAmtResult(Map<String, Object> chargeResult,String payBalance, String email) {
		// TODO Auto-generated method stub
		return mapper.updatePayAmtResult(chargeResult, payBalance, email);
	}

	
	//대표계좌 등록 
	@Transactional
	public void registBankAccount(Map<String, Object> bankAccount) {
		//사용자 일련번호가 없으면 insert 있으면 update
		if(mapper.selectDBAccountInfo((String) bankAccount.get("user_seq_no")) == null) {
			mapper.insertBankAccount(bankAccount);
		} else {
			mapper.updateBankAccount(bankAccount);
		}
		
		String email =  (String)bankAccount.get("email");
		String pay_tran_id = BankValueGenerator.getTranId();
		mapper.connectFundizzyPay(bankAccount, pay_tran_id);
	}
	
	//대표계좌 삭제
	public void removeBankAccount(Map<String, Object> bankAccount) {
		// TODO Auto-generated method stub
		mapper.deleteBankAccount(bankAccount);
	}
	
	// 페이 거래 내역 입력 메서드
	public int payTransaction(Map<String, String> mapForPay) {
		mapForPay.put("tran_id", BankValueGenerator.getTranId());
		
		return mapper.insertFundizzyPay(mapForPay);
	}
	
	//입금 요청
	public Map<String, Object> requestDeposit(Map<String, Object> map) {
		// 이용기관 토큰 조회
		BankToken adminToken = mapper.selectAdminToken("admin");
		
		//map에 이용기관 토큰 저장
		map.put("adminToken", adminToken);
		
		return bankApiClient.requestDeposit(map);
	}
	
	//db에 입금 결과 저장
	public void registTransferResult(Map<String, Object> transferResult) {
		// TODO Auto-generated method stub
		transferResult.put("tran_id", BankValueGenerator.getTranId());
		
		// BankMapper - selectRepresentAccount2() 메서드 호출하여 사용자 토큰 정보 조회
				// => 파라미터 : 사용자일련번호(BankToken 객체에서 꺼내기)
				//    리턴타입 : BankAccount(bankAccount)
		BankAccount bankAccount = mapper.selectBankAccount((String)transferResult.get("user_seq_no"));

		System.out.println("transferResult : " + transferResult);
		//DE = 입금 이체 
		mapper.insertTransferResult(transferResult, "DE");
	}
	
	//페이 정보 가져오기 
	public FundizzyPay getFundizzyPayInfo(String email) {
		// TODO Auto-generated method stub
		return mapper.selectFundizzyPayInfo(email);
	}
	
	//페이 입출금 거래내역 가져오기 
	public List<FundizzyPay> getFundizzyPay(String email) {
		// TODO Auto-generated method stub
		return mapper.selectFundizzyPay(email);
	}
	//결제할 페이 가져오기 
	public Map<String, Object> getFundizzyPayLast(String email) {
		// TODO Auto-generated method stub
		return mapper.selectFundizzyPayLast(email);
	}


	

	

}
