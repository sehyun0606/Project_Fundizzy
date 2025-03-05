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
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.project_fundizzy.vo.KakaoToken;

import lombok.extern.log4j.Log4j2;


@Log4j2
@Component
public class KakaoApiClient {
	
	@Value("${kakao.api_key}")
	private String kakaoClientID;
	
	@Value("${kakao.redirect_uri}")
	private String kakaoRedirectUri;
	
    @Value("${kakao.grant_type}")
    private String grantType;

    @Value("${kakao.base_url}")
    private String base_url;

	public KakaoToken requestAccessToken(Map<String, String> authResponse) {
		
		String requestUrl = base_url+ "/oauth/token";
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
				
		MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<String, String>();
		requestBody.add("grant_type", grantType);
		requestBody.add("client_id", kakaoClientID);
		requestBody.add("redirect_uri", kakaoRedirectUri);
        requestBody.add("code", authResponse.get("code"));
				
        HttpEntity<MultiValueMap<String, String>> requestEntity = 
        		new HttpEntity<MultiValueMap<String, String>>(requestBody, headers);
				
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<KakaoToken> response = 
				restTemplate.exchange(
	                requestUrl,
	                HttpMethod.POST,
	                requestEntity,
	                KakaoToken.class);
		
		log.info(">>>>>>> 토큰 발급 요청 응답데이터의 body : " + response.getBody());
				
		return response.getBody();
	}

	    public Map<String, Object> getKakaoUserInfo(String accessToken) {
	        // 사용자 정보 요청 URL 생성
	        URI uri = UriComponentsBuilder
	                .fromUriString("https://kapi.kakao.com")
	                .path("/v2/user/me")
	                .encode()
	                .build()
	                .toUri();

	        // HTTP 요청 헤더 설정
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "Bearer " + accessToken);

	        // HttpEntity 객체 생성 (헤더만 사용, 바디는 필요 없음)
	        HttpEntity<String> requestEntity = new HttpEntity<>(headers);

	        // RestTemplate 객체 생성
	        RestTemplate restTemplate = new RestTemplate();

	        // ParameterizedTypeReference 객체를 사용하여 응답 데이터를 Map으로 처리
	        ParameterizedTypeReference<Map<String, Object>> responseType =
	                new ParameterizedTypeReference<Map<String, Object>>() {};

	        // API 요청 전송 및 응답 처리
	        ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
	                uri,  // 요청 URL
	                HttpMethod.GET,  // GET 요청
	                requestEntity,  // 요청 헤더
	                responseType  // 응답 타입 (Map)
	        );

	        // 응답 데이터 확인
	        System.out.println("사용자 정보: " + response.getBody());

	        // 사용자 정보 리턴
	        return response.getBody();
	}

    
    
    
    
    
	
}
