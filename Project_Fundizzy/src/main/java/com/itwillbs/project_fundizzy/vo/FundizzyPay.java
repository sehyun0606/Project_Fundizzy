package com.itwillbs.project_fundizzy.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FundizzyPay implements Serializable {
	private String email; //이메일
	private int pay_amt; //거래금액
	private String pay_type; //거래타입
	private String pay_date; // 거래일자
	private String pay_tran_id; //거래고유번호 
	private int pay_balance; //페이잔액
	
	//-----------------admin access token 조회로 인한 idx와 email 추가 ------------------------ (db에는 추가 안했음)
	
}
