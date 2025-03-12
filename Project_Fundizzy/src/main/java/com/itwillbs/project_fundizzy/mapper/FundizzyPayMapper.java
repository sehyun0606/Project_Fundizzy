package com.itwillbs.project_fundizzy.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FundizzyPayMapper {

	String selectPayBalance(String email);
	
	int selectPayBalanceInt(String email);
}
