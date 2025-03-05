package com.itwillbs.project_fundizzy.handler;

import java.net.URI;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.session.HeaderWebSessionIdResolver;
import org.springframework.web.servlet.function.ServerRequest.Headers;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.project_fundizzy.vo.BankToken;

import lombok.extern.log4j.Log4j2;
@Component
@Log4j2
public class BankApiClient {
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
	
	//계좌 목록 
	public Map<String, Object> requestBankUserInfo(BankToken bankToken) {
	    URI uri = UriComponentsBuilder
	            .fromUriString(base_url)
	            .path("/v2.0/user/me")
	            .queryParam("user_seq_no", bankToken.getUser_seq_no())
	            .encode()
	            .build()
	            .toUri();
	      
	      HttpHeaders headers = new HttpHeaders();
	      // 1) HttpHeaders 객체의 add() 메서드로 엑세스토큰 정보 추가(일반적인 헤더 추가 방법)
	      //    => 속성값 전달 시 "Bearer" 문자열과 공백 1개와 엑세스토큰 결합하여 전달
	      headers.add("Authorization", "Bearer " + bankToken.getAccess_token());
	      System.out.println(">>>>> API 요청 URL: " + uri.toString());
	      System.out.println(">>>>> 요청 헤더: " + headers);

	      // HTTP 요청에 사용될 헤더 정보를 관리할 HttpEntity 객체 생성
	      // => 파라미터 : HTTP Body 정보 객체, HTTP Header 정보 객체
	      // => 제네릭타입은 전달할 body 에 대한 타입 지정
	      HttpEntity<String> requestEntity = new HttpEntity<String>(headers);
	      System.out.println("요청정보 = " + requestEntity);
	      RestTemplate restTemplate = new RestTemplate();
	      
	      ParameterizedTypeReference<Map<String, Object>> responseType = new ParameterizedTypeReference<Map<String,Object>>() {};
	      ResponseEntity<Map<String, Object>> response = restTemplate.exchange( uri,
	                        HttpMethod.GET,
	                        requestEntity,
	                        responseType
	                     );
	      System.out.println(">>>>> 사용자 정보조회 요청 응답데이터의 body : " + response.getBody());
	  	return response.getBody();
	}
	// 계좌정보 조회 
	public Map<String, String> reqeustAccountDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		BankToken bank_token = (BankToken) map.get("bank_token");
		String bank_tran_id = BankValueGenerator.getBankTranId(client_use_code);
		String tran_dtime = BankValueGenerator.getTranDTrime();
				
		return null;
	}
}
