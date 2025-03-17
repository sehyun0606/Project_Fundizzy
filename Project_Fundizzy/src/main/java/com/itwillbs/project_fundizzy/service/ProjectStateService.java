package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.ProjectStateMapper;
import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.NewsVO;
import com.itwillbs.project_fundizzy.vo.ProjectDateVO;
import com.itwillbs.project_fundizzy.vo.RefundVO;
import com.itwillbs.project_fundizzy.vo.ShipmentVO;

@Service
public class ProjectStateService {
	@Autowired
	private ProjectStateMapper stateMapper;
	
	// ================================== 프로젝트 현황 ==================================
	public List<Map<String, Object>> getPaymentCountList(String project_code) {
		return stateMapper.selectPaymentCountList(project_code);
	}

	public List<Map<String, Object>> getDailyPaymentList(String project_code) {
		return stateMapper.selectDailyPaymentList(project_code);
	}

	public List<Map<String, Object>> getCumulativePaymentList(String project_code) {
		return stateMapper.selectCumulativePaymentList(project_code);
	}
	
	public ProjectDateVO getProjectDate(String project_code) {
		return stateMapper.selectProjectDate(project_code);
	}
	
	// ================================== 새소식 ==================================
	public int registNewsBoard(Map<String, String> map) {
		return stateMapper.insertNewsBoard(map);
	}

	public List<NewsVO> getNewsList(String project_code, int startRow, int listLimit) {
		return stateMapper.selectNewsList(project_code, startRow, listLimit);
	}

	public int getNewsListCount(String project_code) {
		return stateMapper.selectNewsListCount(project_code);
	}

	public NewsVO getNews(int news_code) {
		return stateMapper.getNews(news_code);
	}

	public int removeNews(int news_code) {
		return stateMapper.deleteNews(news_code);
	}

	public int modifyNewsBoard(Map<String, String> map) {
		return stateMapper.updateNewsBoard(map);
	}
	
	// ================================== 발송 및 환불관리 ==================================
	public int getOrderCount(String project_code) {
		return stateMapper.selectOrderCount(project_code);
	}
	
	public List<Map<String, Object>> getOrderList(String project_code) {
		return stateMapper.selectOrderList(project_code);
	}
	
	public List<Map<String, Object>> getPaymentRewardList(String project_code, String payment_code) {
		return stateMapper.selectPaymentRewardList(project_code, payment_code);
	}

	public List<ShipmentVO> getShipStateCount(String project_code) {
		return stateMapper.selectShipStateCount(project_code);
	}

	public List<FundHistoryVO> getRefundStateCount(String project_code) {
		return stateMapper.selectRefundStateCount(project_code);
	}

	public int getTotalPayemtAmount(String project_code) {
		return stateMapper.selectTotalPaymentAmount(project_code);
	}

	public List<RefundVO> getRefund(String project_code) {
		return stateMapper.selectRefund(project_code);
	}

	@Transactional
	public int modifyRefundFundHistoryStatus(Map<String, Object> map) {
		
		if(map.get("reject_reason") == null) {
			stateMapper.insertRefundPay(map);
		}
		stateMapper.updateRefundStatus(map);

		return stateMapper.updateRefundFundHistoryStatus(map);
	}

	public int modifyShipmentStatus(Map<String, Object> map) {
		stateMapper.updateShipFundHistoryStatus(map);
		return stateMapper.updateShipmentStatus(map);
	}

	public int removeShipmentStatus(String payment_code) {
		stateMapper.deleteShipFundHistoryStatus(payment_code);
		return stateMapper.deleteShipmentStatus(payment_code);
	}

	public Map<String, Object> getProjectInfoJoinStory(String project_code) {
		return stateMapper.selectProjectInfoJoinStory(project_code);
	}

	public int getSettlementFee(String project_code) {
		return stateMapper.selectSettlementFee(project_code);
	}

	public int getPreSettlementAmount(String project_code) {
		return stateMapper.selectPreSettlementAmount(project_code);
	}

	public int getRefundAmount(String project_code) {
		return stateMapper.selectRefundAmount(project_code);
	}

	public int registPreSettlement(Map<String, Object> map) {
		stateMapper.updateProjectListSettlementStatus(map);
		return stateMapper.insertPreSettlement(map);
	}

	public Map<String, Object> getPreSettlementInfo(String project_code) {
		return stateMapper.selectPreSettlementInfo(project_code);
	}

	public int modifyFinalSettlement(Map<String, Object> map) {
		stateMapper.updateProjectListFinalSettlementStatus(map);
		return stateMapper.updateFinalSettlement(map);
	}

	




	

	


}
