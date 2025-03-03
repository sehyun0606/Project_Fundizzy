package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.handler.bankApiClient;
import com.itwillbs.project_fundizzy.mapper.BankMapper;
import com.itwillbs.project_fundizzy.vo.BankToken;
@Service
public class Bankservice {
	@Autowired
	private bankApiClient bankApiClient;
	
	@Autowired
	private BankMapper mapper;

	public BankToken getAccessToken(Map<String, String> authResponse) {
		return bankApiClient.requestAccessToken(authResponse);
	}
//db에 token 저장 
	public void registAccessToken(Map<String, Object> map) {
		String access_token = mapper.selectAccessToken(map);
		if(access_token == null) {
			mapper.insertAccessToken(map);
		} else {
			mapper.updateAccessToken(map);
		}
		 
	}
	
	// 토큰 조회
	public BankToken getBankAccessTokenInfo(String email) {
		return mapper.selectTokenInfo(email);
	}
	public Map<String, Object> getBankUserInfo(BankToken bankToken) {
		// TODO Auto-generated method stub
		return bankApiClient.requestBankUserInfo(bankToken);
	}
	

}
