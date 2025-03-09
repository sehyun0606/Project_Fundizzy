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
public class NaverApiClient {

	@Value("${naver.client_id}")
	private String naverClientId;
	
	@Value("${naver.client_secret}")
	private String naverClientSecret;
	
	@Value("${naver.redirect_url}")
	private String naverRedirectUrl;

	@Value("${naver.grant_type}")
	private String grantType;

	public Map<String, String> requestAccessToken(Map<String, String> authResponse) {
		String requestUrl = "https://nid.naver.com/oauth2.0/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<String, String>();
        requestBody.add("grant_type", grantType);
        requestBody.add("client_id", naverClientId);
        requestBody.add("client_secret", naverClientSecret);
        requestBody.add("code", authResponse.get("code"));
        requestBody.add("state", authResponse.get("state"));

        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(requestBody, headers);
        
        RestTemplate restTemplate = new RestTemplate();
		
        ResponseEntity<Map> response = restTemplate.exchange(
                requestUrl,
                HttpMethod.POST,
                requestEntity,
                Map.class // VO 대신 Map 사용
        );

//        log.info("네이버 토큰 응답 데이터: " + response.getBody());
        System.out.println("네이버 토큰 응답 데이터 : " + response.getBody());
        
        return response.getBody();
	}

	public Map<String, Object> getNaverUserInfo(String accessToken) {
		// 사용자 정보 요청 URL 생성
        URI uri = UriComponentsBuilder
                .fromUriString("https://openapi.naver.com")
                .path("/v1/nid/me")
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
