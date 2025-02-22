package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	int insertMember(Map<String, String> member);

	// 사용자 인증코드 유/무 조회
	Map<String, String> selectMailAuthInfo(Map<String, String> mailAuthInfo);
	// 인증코드 없을 시 입력
	void insertMailAuthInfo(Map<String, String> mailAuthInfo);
	// 인증코드 있을 시 업데이트
	void updateMailAuthInfo(Map<String, String> mailAuthInfo);
	
	
	String selectAuthCode(Map<String, String> authInfo);

	Map<String, String> selectEmail(String email);



}
