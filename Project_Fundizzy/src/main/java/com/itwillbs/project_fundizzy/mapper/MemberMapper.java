package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

	int insertMember(Map<String, String> member);

	// 사용자 인증코드 유/무 조회
	Map<String, String> selectMailAuthInfo(Map<String, String> mailAuthInfo);
	
	// 인증코드 없을 시 입력
	void insertMailAuthInfo(Map<String, String> mailAuthInfo);
	
	// 인증코드 있을 시 업데이트
	void updateMailAuthInfo(Map<String, String> mailAuthInfo);
	
	// 사용자 인증코드 조회
	String selectAuthCode(Map<String, String> authInfo);
	
	// 사용자 이메일 조회
	Map<String, String> selectEmail(String email);

	String selectNickname(String email);

	void insertKakaoUser(@Param("nickname") String nickname,@Param("email") String email);

	Map<String, String> selectDBKakaoUser(String email);

	Map<String, String> selectDBKakaoUserInfo(String email);

	void insertNaverUser(@Param("nickname") String nickname,@Param("email") String email);

	Map<String, String> selectDBNaverUser(String email);

	Map<String, String> selectDBNaverUserInfo(String email);
		
//	메서드 추가한사람 : 정세현
	String selectProfileImg(String email);





}
