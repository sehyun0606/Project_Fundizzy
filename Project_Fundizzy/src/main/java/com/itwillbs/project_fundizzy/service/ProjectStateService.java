package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectStateMapper;
import com.itwillbs.project_fundizzy.vo.NewsVO;
import com.itwillbs.project_fundizzy.vo.RefundVO;
import com.itwillbs.project_fundizzy.vo.ShipmentVO;

@Service
public class ProjectStateService {
	@Autowired
	ProjectStateMapper stateMapper;
	
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

	public List<RefundVO> getRefundStateCount(String project_code) {
		return stateMapper.selectRefundStateCount(project_code);
	}



	

	


}
