package com.itwillbs.project_fundizzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.FundHistoryMapper;
import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.RefundVO;

@Service
public class FundHistoryService {
	@Autowired
	private FundHistoryMapper historyMapper;
	
	//구매기록 페이징 숫자 구하는 메서드
	public int getFundHistoryListCount(String member_email) {
		return historyMapper.selectFundHistoryListCount(member_email);
	}
	
	//페이징 처리된 페이지에서 불러올 구매내역 리스트 불러오는 메서드
	public List<FundHistoryVO> getFundList(int startRow, int listLimit, String member_email) {
		return historyMapper.selectFundList(startRow,listLimit,member_email);
	}

	public FundHistoryVO getFundInfo(String fund_idx) {
		return historyMapper.selectFundInfo(fund_idx);
	}
	
	@Transactional
	public void registRefund(RefundVO refund) {
		int fundIdx = refund.getFund_idx();
		historyMapper.insertRefund(refund);
		historyMapper.updateFundHistory(fundIdx);
	}
}
