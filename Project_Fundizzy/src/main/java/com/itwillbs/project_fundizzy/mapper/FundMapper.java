package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;
import com.itwillbs.project_fundizzy.vo.RewardVO;
@Mapper
public interface FundMapper {
	//펀딩 리스트 출력
	List<Map<String, Object>> selectFundList();
	
	//프로젝트 board 출력
	Map<String, Object> selectFundBoard(String project_code);
	
	//프로젝트 board 출력 - 리워드 테이블 가져오기 
	List<Map<String, Object>> selectReward(String project_code);
	
	//프로젝트 board 출력 - 찜 테이블 가져오기 
	List<Map<String, Object>> selectKeep(@Param("email")String email, @Param("project_code")String project_code);
	
	//찜 등록
	int insertKeep(@Param("email")String email, @Param("project_code")String project_code);
	
	//찜 삭제
	void deleteKeep(@Param("email")String email, @Param("project_code")String project_code);
	
	// 새소식 가져오기 
	List<Map<String, Object>> selectNews(String project_code);
	
	//지지서명 글 목록 
	List<Map<String, Object>> selectSupportList(String project_code);
	
	//지지서명 글 등록
	int insertSupportSignature(@Param("project_code") String project_code, @Param("email")String email, 
			@Param("supportContent") String supportContent, @Param("supportKeyword") String supportKeyword);

	//지지서명 댓글 등록 
	int insertSupportReply(Map<String, Object> map);
	
	// 지지서명 댓글 가져오기
	List<Map<String, Object>> selectReplyList(Map<String, Object> map);
	
	// 지지서명 댓글 삭제
	int updateSupportReply(Map<String, Object> map);
	
	//지지서명 댓글 작성자 가져오기 
	Object selectReplyWriter(Map<String, Object> map);
	
	// 펀딩내역 테이블 가져오기 
	List<Map<String, Object>> selectFundHistory(String project_code);
	
	
	
	//---------------오른쪽 부분 ----------------------
	
	//리워드 가져오기 
	List<Map<String, Object>> selectPaymentReward(String project_code);
	
	//선택한 리워드 가져오기
	RewardVO selectPaymentSelectedReward(@Param("project_code") String project_code, @Param("reward_code") String reward_code);
	
	// 배송을 위한 맴버 가져오기 
	Map<String, Object> selectPaymentPayMember(String email);

	//페이로 결제한 내역 계산 
	int insertPaymentPay(Map<String, String> map);

	//결제내역 input - payment 테이블
	int insertPayment(Map<String, String> map);
	
	//배송내역 input - shipment
	int insertShipment(Map<String, String> map);
	
	//펀딩내역 input - fundHistory 테이블
	int insertFundHistory(@Param("sendList") List<Map<String, String>> sendList, @Param("map")Map<String, String> map);

	// 완료 페이지를 띄우기 위한 리스트 가져오기 
	List<Map<String, Object>> selectResultList(String pay_tran_id);

	//구매자 수 출력 
	int selectFundHistoryCount(String project_code);



	
	
	
	








	
}
