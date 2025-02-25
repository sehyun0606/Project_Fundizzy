package com.itwillbs.project_fundizzy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.FundMapper;

@Service
public class FundService {
	@Autowired
	private FundMapper mapper;
	//지지서명 등록
	public int getSupportSignature(int project_code, String email, String supportContent, String supportKeyword) {
		// TODO Auto-generated method stub
		return mapper.insertSupportSignature(project_code, email, supportContent, supportKeyword);
	}

}
