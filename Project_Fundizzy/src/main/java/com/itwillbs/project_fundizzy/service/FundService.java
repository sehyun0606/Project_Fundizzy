package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.FundMapper;

@Service
public class FundService {
	@Autowired
	private FundMapper mapper;
	//지지서명 목록 출력 
	public List<Map<String, Object>> getSupportList() {
		// TODO Auto-generated method stub
		return mapper.selectSupportList();
	}
	//지지서명 등록
	public int getSupportSignature(int project_code, String email, String supportContent, String supportKeyword) {
		// TODO Auto-generated method stub
		return mapper.insertSupportSignature(project_code, email, supportContent, supportKeyword);
	}
	public int registSupportReply(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertSupportReply(map);
	}
	public List<Map<String, Object>> getReplyList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.selectReplyList(map);
	}
	
	
	
	

}
