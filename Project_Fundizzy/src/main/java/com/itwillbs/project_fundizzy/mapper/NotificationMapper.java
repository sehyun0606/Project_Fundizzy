package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NotificationMapper {
	// 알림설정테이블에 회원가입시 선택한 알림정보 입력
	void insertNOTSetInfo(String email);
	
	// 알림설정 정보 조회
	Map<String, Object> selectMemberNOTSetInfo(String email);
	
	// 알림설정 옵션 변경
	int updateNOTSetOption(Map<String, String> optionMap);
	
	// 알림테이블에 알림 입력
	void insertNOTInfo(Map<String, String> map);
	
	// 알림테이블의 나의 알림 리스트 조회
	List<Map<String, Object>> selectMyNOTList(String email);
	
	// 해당프로젝트를 찜한 멤버이메일 조회
	List<String> selectKeepMember(String project_code);
	
	// 해당프로젝트를 지지서명한 멤버이메일 조회
	List<String> selectSupprotMember(String project_code);
	
	// 프로젝트 정보 조회
	Map<String, String> selectProjectInfo(String project_code);
	
	// 알림 읽음 처리
	void updateNotStatus(String email);
	
	// 읽지않은 알림 수 조회
	int selectUnReadCount(String email);
	
	// 알림 삭제
	int deleteNotFromDB(@Param("codeArr") String[] codeArr);

	String selectSettlementStatus(String project_code);

}
