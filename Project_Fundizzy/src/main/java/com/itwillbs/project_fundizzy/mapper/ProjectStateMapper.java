package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.NewsVO;
import com.itwillbs.project_fundizzy.vo.ShipmentVO;

@Mapper
public interface ProjectStateMapper {

	// ================================== 프로젝트 현황 ==================================
	List<Map<String, Object>> selectPaymentCountList(String project_code);
	
	List<Map<String, Object>> selectDailyPaymentList(String project_code);
	
	List<Map<String, Object>> selectCumulativePaymentList(String project_code);
	

	// ================================== 발송 및 환불관리 ==================================
	int selectOrderCount(String project_code);
	
	List<Map<String, Object>> selectOrderList(String project_code);
	
	List<Map<String, Object>> selectPaymentRewardList(@Param("project_code") String project_code, @Param("payment_code") String payment_code);
	
	
	
	// ================================== 새소식 ==================================
	int insertNewsBoard(Map<String, String> map);

	List<NewsVO> selectNewsList(@Param("project_code")String project_code, @Param("startRow")int startRow, @Param("listLimit")int listLimit);

	int selectNewsListCount(String project_code);

	NewsVO getNews(int news_code);

	int deleteNews(int news_code);

	int updateNewsBoard(Map<String, String> map);

	List<ShipmentVO> selectShipStatusCount(String project_code);


	




}
