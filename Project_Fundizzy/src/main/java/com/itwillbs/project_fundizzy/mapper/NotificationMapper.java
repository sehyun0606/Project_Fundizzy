package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NotificationMapper {
	// 알림설정테이블에 회원가입시 선택한 알림정보 입력
	void insertNOTSetInfo(Map<String, String> map);
	
	// 알림설정 정보 조회
	Map<String, Object> selectMemberNOTSetInfo(String email);
	
	// 알림설정 옵션 변경
	int updateNOTSetOption(Map<String, String> optionMap);
	
	// 알림테이블에 알림 입력
	void insertNOTInfo(Map<String, String> map);
	
	// 알림테이블의 나의 알림 리스트 조회
	List<Map<String, Object>> selectMyNOTList(String email);

}
