package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NotificationMapper {
	// 알림설정테이블에 회원가입시 선택한 알림정보 입력
	void insertNOTSetInfo(Map<String, String> map);
	
	// 알림설정 정보 조회
	Map<String, Object> selectMemberNOTSetInfo(String email);
	
	//  알림설정 옵션 변경
	int updateNOTSetOption(Map<String, String> optionMap);

}
