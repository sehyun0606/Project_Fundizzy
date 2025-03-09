package com.itwillbs.project_fundizzy.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RefundVO {
	private int refund_code;
	private int fund_idx;
	private String member_email;
	private int reward_code;
	private String product_name;
	private int refund_amound;
	private String refund_reason;
	private String refund_img;
	private MultipartFile refundImg;
	private String reject_reason;
	private Timestamp refund_request_date;
	private Timestamp refund_confirm_date;
	private String refund_status;
	private String project_code;
}
