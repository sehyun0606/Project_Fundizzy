package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.vo.BankAccount;
import com.itwillbs.project_fundizzy.vo.BankToken;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;

@Mapper
public interface BankMapper {
	//엑세스 토큰 조회
	String selectAccessToken(Map<String, Object> map);
	//토큰 정보 입력
	void insertAccessToken(Map<String, Object> map);
	//토큰 정보 갱신 
	void updateAccessToken(Map<String, Object> map);
	//토큰 정보 조회
	BankToken selectTokenInfo(String email);
	
	//------------MyPageController와 연관된 코드 -----------
	
	//거래결과를 db에 저장 (입,출금)
	Map<String, Object> selectDBTransactionResult(String bank_tran_id);
	
	//등록된 계좌정보 조회
	BankAccount selectDBAccountInfo(String user_seq_no);
	
	//이체결과 저장 
	void insertChargeResult(@Param("chargeResult") Map<String, Object> chargeResult, @Param("transactionType")String transactionType);
	// 대표계좌 등록
	void insertBankAccount(Map<String, Object> bankAccount);
	// 대표계좌가 있을경우 update 
	void updateBankAccount(Map<String, Object> bankAccount);
	// 대표계좌 삭제 
	void deleteBankAccount(Map<String, Object> bankAccount);
	
	// 첫 계좌 연동시 페이연결 정보 입력
	void connectFundizzyPay(@Param("bankAccount") Map<String, Object> bankAccount, @Param("pay_tran_id")String pay_tran_id);
	
	//페이 충전결과 페이지 
	Map<String, Object> insertFundizzyPay(Map<String, String> mapForPay);

	// 이용기관 토큰 조회
	BankToken selectAdminToken(String id);
	
	//db에 입금 결과 저장 - 사용자 토큰 정보 조회
	BankAccount selectBankAccount(String user_seq_no);
	
	//db에 입금 결과 저장
	void insertTransferResult(@Param("transferResult") Map<String, Object> transferResult, @Param("transactionType") String transactionType);
	
	//펀디지 페이 가져오기 
	FundizzyPay selectFundizzyPay(String email);
	

}
