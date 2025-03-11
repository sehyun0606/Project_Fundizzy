package com.itwillbs.project_fundizzy.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Payment implements Serializable {
	private int idx;
	private String common_code; //공통코드
	private String payment_code; //결제코드
	private String project_code; //프젝코드
	private String billing_email; //결제맴버이메일
	private String pament_method; //결제방법 - 페이로 고정
	private int payment_amount; //결제금액
	private String payment_request_date; //결제 요청날짜
	private String payment_complete_date; //결제 완료날짜
	private String participation_status; // 프젝참여상태 -PAR02로 고정 
	
}
