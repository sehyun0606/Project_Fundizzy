package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;
@Mapper
public interface FundMapper {
	//펀딩 리스트 출력
	List<Map<String, Object>> selectFundList();
	
	//프로젝트 board 출력
	Map<String, Object> selectFundBoard(String project_code);
	
	//지지서명 글 목록 
	List<Map<String, Object>> selectSupportList();
	
	//지지서명 글 등록
	int insertSupportSignature(@Param("project_code") int project_code, @Param("email")String email, 
			@Param("supportContent") String supportContent, @Param("supportKeyword") String supportKeyword);

	//지지서명 댓글 등록 
	int insertSupportReply(Map<String, String> map);
	
	// 지지서명 댓글 가져오기
	List<Map<String, Object>> selectReplyList(Map<String, Object> map);
	
	// 지지서명 댓글 삭제
	int deleteSupportReply(Map<String, Object> map);
	
	//지지서명 댓글 작성자 가져오기 
	Object selectReplyWriter(Map<String, Object> map);
	//---------------오른쪽 부분 ----------------------
	
	//리워드 가져오기 
	Map<String, Object> selectPaymentReward(String project_code);
	
	// 배송을 위한 맴버 가져오기 
	Map<String, Object> selectPaymentPayMember(String email);

	//페이로 결제한 내역 계산 
	int insertPaymentPay(Map<String, Object> map);
	
//	//페이 잔액 업데이트 
//	FundizzyPay updateBalancePay(Map<String, Object> map);

	//펀딩내역 input - fundHistory 테이블
	int insertFundHistory(Map<String, Object> map);

	//결제내역 input - payment 테이블
	int insertPayment(Map<String, Object> map);

	//배송내역 input - shipment
	int insertShipment(Map<String, Object> map);




	
}
