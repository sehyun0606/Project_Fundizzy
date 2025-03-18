package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.NewsVO;
import com.itwillbs.project_fundizzy.vo.ProjectDateVO;
import com.itwillbs.project_fundizzy.vo.RefundVO;
import com.itwillbs.project_fundizzy.vo.ShipmentVO;

@Mapper
public interface ProjectStateMapper {

	// ================================== 프로젝트 현황 ==================================
	List<Map<String, Object>> selectPaymentCountList(String project_code);
	
	List<Map<String, Object>> selectDailyPaymentList(String project_code);
	
	List<Map<String, Object>> selectCumulativePaymentList(String project_code);
	
	int selectProjectRemainDate(String project_code);
	
	int selectSupportCount(String project_code);
	
	
	// ================================== 새소식 ==================================
	int insertNewsBoard(Map<String, String> map);

	List<NewsVO> selectNewsList(@Param("project_code")String project_code, @Param("startRow")int startRow, @Param("listLimit")int listLimit);

	int selectNewsListCount(String project_code);

	NewsVO getNews(int news_code);

	int deleteNews(int news_code);

	int updateNewsBoard(Map<String, String> map);
	
	int insertSaveNewsBoard(Map<String, String> map);

	int updateSaveNewsBoard(Map<String, String> map);
	
	

	// ================================== 발송 및 환불관리 ==================================
	int selectOrderCount(String project_code);
	
	List<Map<String, Object>> selectOrderList(String project_code);
	
	List<Map<String, Object>> selectPaymentRewardList(@Param("project_code") String project_code, @Param("payment_code") String payment_code);

	List<ShipmentVO> selectShipStateCount(String project_code);

	List<FundHistoryVO> selectRefundStateCount(String project_code);

	int selectTotalPaymentAmount(String project_code);

	List<RefundVO> selectRefund(String project_code);

	int updateRefundApprove(Map<String, Object> map);

	int updateRefundFundHistoryStatus(Map<String, Object> map);

	void updateRefundStatus(Map<String, Object> map);

	void insertRefundPay(Map<String, Object> map);

	int updateShipmentStatus(Map<String, Object> map);

	void updateShipFundHistoryStatus(Map<String, Object> map);

	int deleteShipmentStatus(String payment_code);

	void deleteShipFundHistoryStatus(String payment_code);

	
	// ================================== 정산관리 ==================================
	Map<String, Object> selectProjectInfoJoinStory(String project_code);

	int selectSettlementFee(String project_code);

	int selectPreSettlementAmount(String project_code);

	int selectRefundAmount(String project_code);

	int insertPreSettlement(Map<String, Object> map);

	void updateProjectListSettlementStatus(Map<String, Object> map);

	Map<String, Object> selectPreSettlementInfo(String project_code);

	int updateFinalSettlement(Map<String, Object> map);

	void updateProjectListFinalSettlementStatus(Map<String, Object> map);

	String selectProjectDate(String project_code);

	

	

	

	





}
