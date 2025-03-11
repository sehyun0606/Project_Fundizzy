package com.itwillbs.project_fundizzy.vo;

import lombok.Data;

@Data
public class ShipmentVO {
	private int idx; 
	private String common_code; //공통코드
	private String shipment_code; //발송코드 
	private String project_code; //프로젝트 코드 
	private String supporter_email; // 구매자(=서포터) 이메일 
	private String name; //이름
	private String phone_num; //전화번호
	private String address; //주소
	private String address1;//상세주소
	private String extra_address;//참조주소
	private String post_code;//우편번호
	private String delivery_req;//배송시 요청사항
	private String courier;//택배사
	private String tracking_num;//송장번호
	private String shipping_date; //발송날짜 
}
