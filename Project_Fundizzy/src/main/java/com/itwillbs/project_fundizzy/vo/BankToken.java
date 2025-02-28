package com.itwillbs.project_fundizzy.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class BankToken implements Serializable {
	private String id;
	
	private String access_token;
	private String token_type;
	private int expires_in;
	private String refresh_token;
	private String scope;
	private String user_seq_no;
	
	private String rep_code;
	private String rsp_message;
}
