package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminSettlementMapper {

	int selectSettlementListCount();

	List<Map<String, Object>> selectSettlementList(int startRow, int listLimit);

	Map<String, Object> selectSettlementInfo(String project_code);

	int insertSettlementPay(Map<String, Object> map);

	void updatePreProjectListStatus(Map<String, Object> map);

	void updatePreSettlementStatus(Map<String, Object> map);

	int updateFinalSettlementStatus(Map<String, Object> map);

	void updateFinalProjectListStatus(Map<String, Object> map);

}
