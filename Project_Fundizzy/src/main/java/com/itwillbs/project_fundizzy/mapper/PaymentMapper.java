package com.itwillbs.project_fundizzy.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
	//결제코드 가져오기 
	String selectPaymentCode(String project_code);
	
	
	
}
