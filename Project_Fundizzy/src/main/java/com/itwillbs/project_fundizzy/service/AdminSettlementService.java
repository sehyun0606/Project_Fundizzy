package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.handler.BankValueGenerator;
import com.itwillbs.project_fundizzy.mapper.AdminSettlementMapper;

@Service
public class AdminSettlementService {
	@Autowired
	private AdminSettlementMapper setMapper;

	public int getSettlementListCount() {
		return setMapper.selectSettlementListCount();
	}

	public List<Map<String, Object>> getSettlementList(int startRow, int listLimit) {
		return setMapper.selectSettlementList(startRow, listLimit);
	}

	public Map<String, Object> getSettlementInfo(String project_code) {
		return setMapper.selectSettlementInfo(project_code);
	}

	public int registSettlementPay(Map<String, Object> map) {
		// 선정산
		if(map.get("pre_amount") != null && !map.get("pre_amount").equals("")) {
			setMapper.updatePreProjectListStatus(map);
			setMapper.updatePreSettlementStatus(map);
		// 최종정산
		} else if(map.get("final_amount") != null && !map.get("final_amount").equals("")) {
			setMapper.updateFinalProjectListStatus(map);
			setMapper.updateFinalSettlementStatus(map);
		}
		
		return setMapper.insertSettlementPay(map);
	}

	
	
	
	
	
	
}















