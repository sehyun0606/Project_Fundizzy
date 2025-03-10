package com.itwillbs.project_fundizzy.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class FundizzyPay implements Serializable {
	private String email;
	private int pay_amt;
	private String pay_type;
	private String pay_date;
	private String pay_tran_id;
	private int pay_balance;
	
	//-----------------admin access token 조회로 인한 idx와 email 추가 ------------------------ (db에는 추가 안했음)
	
}
