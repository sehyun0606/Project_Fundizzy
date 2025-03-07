package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.vo.BankAccount;
import com.itwillbs.project_fundizzy.vo.BankToken;

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
	
	//출금결과를 db에 저장 
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

}
