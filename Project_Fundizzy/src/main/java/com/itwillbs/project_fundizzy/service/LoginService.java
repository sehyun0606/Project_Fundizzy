package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.handler.KakaoApiClient;
import com.itwillbs.project_fundizzy.vo.KakaoToken;

@Service
public class LoginService {
	@Autowired
	private KakaoApiClient kakaoApiClient;

	public KakaoToken getAccessToken(Map<String, String> authResponse) {
		// TODO Auto-generated method stub
		return kakaoApiClient.requestAccessToken(authResponse);
	}

	public Map<String, Object> getKakaoUserInfo(String access_token) {
		return kakaoApiClient.getKakaoUserInfo(access_token);
	}
	

}
