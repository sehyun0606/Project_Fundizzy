package com.itwillbs.project_fundizzy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.PaymentMapper;

@Service
public class PaymentService {
	@Autowired
	private PaymentMapper paymentMapper;
	
	//결제코드 가져오기 
	public String getPaymentCode(String project_code) {
		// TODO Auto-generated method stub
		return paymentMapper.selectPaymentCode(project_code);
	}
}
