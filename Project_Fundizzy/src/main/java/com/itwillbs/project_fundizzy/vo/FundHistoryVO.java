package com.itwillbs.project_fundizzy.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FundHistoryVO {
	private int fund_idx;
	private String project_code;
	private String member_email;
	private String project_title;
	private String representative_picture;
	private String product_name;
	private String business_name;
	private int result_point;
	private String send_stat;
	private String refund_stat;
	private int reward_code;
	private Timestamp purchase_date;
	private Timestamp refund_date;
	private Timestamp send_date;
	private int product_count;
	private String payment_code;
}
