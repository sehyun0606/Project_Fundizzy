package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectStateMapper;
import com.itwillbs.project_fundizzy.vo.NewsVO;

@Service
public class ProjectStateService {
	@Autowired
	ProjectStateMapper stateMapper;

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

	public List<Map<String, Object>> getPaymentCountList(String project_code) {
		return stateMapper.selectPaymentCountList(project_code);
	}

	public List<Map<String, Object>> getDailyPaymentList(String project_code) {
		return stateMapper.selectDailyPaymentList(project_code);
	}

	public List<Map<String, Object>> getCumulativePaymentList(String project_code) {
		return stateMapper.selectCumulativePaymentList(project_code);
	}




}
