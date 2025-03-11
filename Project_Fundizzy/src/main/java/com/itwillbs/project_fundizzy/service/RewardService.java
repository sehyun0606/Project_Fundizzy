package com.itwillbs.project_fundizzy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.RewardMapper;

@Service
public class RewardService {
	
	@Autowired
	private RewardMapper mapper;
	
	//프로젝트 이름 가져오기 
	public String getproductName(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectProductName(project_code);
	}

	//리워드 코드 가져오기 
	public String getrewardCode(String project_code) {
		// TODO Auto-generated method stub
		return mapper.selectRewardCode(project_code);
	}

}
