package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.MemberMapper;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	public int insertMember(Map<String, String> member) {
		return mapper.insertMember(member);
	}

	public void registMailAuthInfo(Map<String, String> mailAuthInfo) {
		
		// 기존 인증 정보 존재 여부 확인
		Map<String, String> dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
		
		// 인증정보 조회 결과 판별
		if(dbMailAuthInfo == null) { // 기존 인증정보 없음(인증메일 발송 이력 없음)
			// 새 인증정보 등록을 위해 insertMailAuthInfo() 메서드 호출하여 등록 작업 요청(INSERT)
			mapper.insertMailAuthInfo(mailAuthInfo);
		} else { // 기존 인증정보 있음(인증메일 발송 이력 있음)
			// 기존 인증정보 갱신 위해 updateMailAuthInfo() 메서드 호출하여 수정 작업 요청(UPDATE)
			mapper.updateMailAuthInfo(mailAuthInfo);
		}
		
	}
	
	// 사용자 인증코드 조회
	public String getAuthCode(Map<String, String> authInfo) {
		return mapper.selectAuthCode(authInfo);
	}

	//-----------------------------------------------------------------------------------
	// 사용자 이메일 조회
	public Map<String, String> getMember(String email) {
		return mapper.selectEmail(email);
	}

	public String getMemberNickname(String email) {
		return mapper.selectNickname(email);
	}
	
	// 카카오 로그인
	public void insertKakaoUser(String nickname, String email) {
		mapper.insertKakaoUser(nickname, email);
	}

	public Map<String, String> getDBKakaoUser(String email) {
		return mapper.selectDBKakaoUser(email);
	}

	public Map<String, String> getDBKakaoUserInfo(String email) {
		return mapper.selectDBKakaoUserInfo(email);
	}

	// 네이버 로그인
	public void insertNaverUser(String nickname, String email) {
		mapper.insertNaverUser(nickname, email);
	}

	public Map<String, String> getDBNaverUser(String email) {
		return mapper.selectDBNaverUser(email);
	}

	public Map<String, String> getDBNaverUserInfo(String email) {
		return mapper.selectDBNaverUserInfo(email);
	}

//	메서드 추가한 사람 정세현
	public String getProfileImg(String email) {
		return mapper.selectProfileImg(email);
	}

	public int updatePassword(Map<String, String> map) {
		return mapper.updatePassword(map);
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
