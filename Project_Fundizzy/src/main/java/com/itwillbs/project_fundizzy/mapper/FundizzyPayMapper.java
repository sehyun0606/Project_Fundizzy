package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.FundizzyPay;

@Mapper
public interface FundizzyPayMapper {

	FundizzyPay selectPayBalance(String email);
	
	int selectPayBalanceInt(String email);

}
