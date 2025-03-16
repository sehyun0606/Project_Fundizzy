package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.FundizzyPayMapper;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;

@Service
public class FundizzyPayService {
	@Autowired
	private FundizzyPayMapper mapper;
	
//페이 잔액 들고오기
	public FundizzyPay getPayBalance(String email) {
		// TODO Auto-generated method stub
		return mapper.selectPayBalance(email);
	}
	
	//페이 잔액 들고오기 - int 타입으로
	public int getPayBalanceInt(String email) {
		// TODO Auto-generated method stub
		return  mapper.selectPayBalanceInt(email);
	}
	
	
}
