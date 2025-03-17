package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.RefundVO;

@Mapper
public interface FundHistoryMapper {


	int selectFundHistoryListCount(String member_email);

	List<FundHistoryVO> selectFundList(@Param("startRow")int startRow, 
										@Param("listLimit") int listLimit,
										@Param("member_email") String member_email);

	FundHistoryVO selectFundInfo(String fund_idx);

	void insertRefund(RefundVO refund);

	void updateFundHistory(int fundIdx);

	//회사명 가져오기 
	String selectBusinessName(String project_code);

	int updateShipCompleteStatus(String payment_code);

	void updateFundHistoryStatus(int fund_idx);

	List<Map<String, Object>> selectShipInfoList(String payment_code);

}
