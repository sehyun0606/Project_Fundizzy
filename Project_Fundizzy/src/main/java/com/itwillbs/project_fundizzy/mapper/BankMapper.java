package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.BankToken;

@Mapper
public interface BankMapper {
	//엑세스 토큰 조회
	String selectAccessToken(Map<String, Object> map);
	//토큰 정보 입력
	void insertAccessToken(Map<String, Object> map);
	//토큰 정보 갱신 
	void updateAccessToken(Map<String, Object> map);
	//토큰 정보 조회
	BankToken selectTokenInfo(String email);

}
