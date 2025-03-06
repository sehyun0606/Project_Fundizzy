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
import org.springframework.web.servlet.tags.Param;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.JsonObject;
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
	//출금이체 
	public Map<String, Object> requestCharge(Map<String, Object> map) {
		//map에서 꺼내 토큰 변수에 저장 
		BankToken bankToken = (BankToken) map.get("bankToken");
		
		//bank_tran_id, tran_dtime 생성
		String bank_tran_id = BankValueGenerator.getBankTranId(client_use_code);
		String tran_dtime = BankValueGenerator.getTranDTrime();
		
		//등록계좌 조회 api 요청주소 생성
		 URI uri = UriComponentsBuilder
				 .fromUriString(base_url)
				 .path("/v2.0/transfer/withdraw/fin_num")
				 .encode()
				 .build()
				 .toUri();
		 System.out.println("uri = " + uri.toString());
		 //http 통신에서 전송할 header 정보 생성 
		 HttpHeaders headers = new HttpHeaders();
		 headers.setBearerAuth(bankToken.getAccess_token());
		 
		 //header setcontent type을 호출해 json타입으로 설정 
		 headers.setContentType(MediaType.APPLICATION_JSON);
		 
		 JsonObject jsonObject = new JsonObject();
//		 이용기관 정보
		 jsonObject.addProperty("bank_tran_id", bank_tran_id); // 거래 고유번호
		 jsonObject.addProperty("cntr_account_type", "N"); //약정계좌(N) & 계정 구분 
		 jsonObject.addProperty("cntr_account_num", cntr_account_num);//약정 계좌번호
		 
		 //입금계좌인자내역 (아이티윌에 출력할 메시지) 
		 jsonObject.addProperty("dps_print_content",(String) map.get("email")); //사용자 아이디
		 
		 //출금계좌 정보
		 jsonObject.addProperty("fintech_use_num", (String)map.get("charge_fintech_use_num"));// 출금계좌 핀테크 이용번호
		 jsonObject.addProperty("wd_print_content",  "funddizy pay");// 출금계좌 인자내약
		 
		 jsonObject.addProperty("tran_amt", (String)map.get("tran_amt")); // 출금금액
		 jsonObject.addProperty("tran_dtime", tran_dtime); //거래날짜
		 jsonObject.addProperty("req_client_name", (String)map.get("charge_req_client_name")); // 출금계좌 예금주명 
		 jsonObject.addProperty("req_client_fintech_use_num", (String)map.get("charge_fintech_use_num")); // 요청고객 핀테크 이용번호(출금계좌)
		 
		 
		 jsonObject.addProperty("req_client_num", bankToken.getUser_seq_no()); //사용자 일련번호
		 jsonObject.addProperty("transfer_purpose", "ST");
		 
		 //출금계좌 정보 
		 jsonObject.addProperty("recv_client_name", "이연태");
		 jsonObject.addProperty("recv_client_bank_code", cntr_account_bank_code);
		 jsonObject.addProperty("recv_client_account_num", cntr_account_num);
		 
		 System.out.println("잘 나오는지 출력 = " + uri.toString());
		 
		 HttpEntity<String> httpEntity = new HttpEntity<String>(jsonObject.toString(),headers);
		 
		 RestTemplate restTemplate = new RestTemplate();
		 
		 ParameterizedTypeReference<Map<String, Object>> responseType = new ParameterizedTypeReference<Map<String,Object>>() {
		};
		 
		ResponseEntity<Map<String, Object>> response = restTemplate.exchange(uri, HttpMethod.POST, httpEntity, responseType);
		System.out.println("응답 데이터 출력 = " + response.getBody());
		return response.getBody();
	}
}
