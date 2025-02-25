package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NotificationMapper {
	// 알림설정테이블에 회원가입시 선택한 알림정보 입력
	void insertNOTSetInfo(Map<String, String> map);

}
