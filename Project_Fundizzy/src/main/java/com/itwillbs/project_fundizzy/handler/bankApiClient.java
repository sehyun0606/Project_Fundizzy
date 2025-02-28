package com.itwillbs.project_fundizzy.handler;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.project_fundizzy.vo.BankToken;

import lombok.extern.log4j.Log4j2;
@Component
@Log4j2
public class bankApiClient {
	@Value("${bank.base_url}")
	private String base_url;
	
	@Value("${bank.callback_url}")
	private String callback_url;
	
	@Value("${bank.client_id}")
	private String client_id;
	
	@Value("${bank.client_secret}")
	private String client_secret;
	
	@Value("${bank.client_use_code}")
	private String client_use_code;
	
	@Value("${bank.cntr_account_num}")
	private String cntr_account_num;
	
	@Value("${bank.cntr_account_bank_code}")
	private String cntr_account_bank_code;
	
	@Value("${bank.cntr_account_holder_name}")
	private String cntr_account_holder_name;
	
	//2.1.2 토큰 발급 api
	public BankToken requestAccessToken(Map<String, String> authResponse) {
		String requestUrl = base_url + "/oauth/2.0/token";
		System.out.println("토큰 발급 api 요청 주소" + requestUrl);
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		
		MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<String, String>();
		requestBody.add("code", authResponse.get("code"));
		requestBody.add("client_id", client_id);
		requestBody.add("client_secret", client_secret);
		requestBody.add("redirect_uri", callback_url);
		requestBody.add("grant_type", "authorization_code");
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(requestBody ,headers);
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<BankToken> response = restTemplate.exchange(requestUrl, HttpMethod.POST, requestEntity, BankToken.class);
		log.info("토큰발급 요청 응답데이터의 body = " + response.getBody());
		return response.getBody();
	}

}
