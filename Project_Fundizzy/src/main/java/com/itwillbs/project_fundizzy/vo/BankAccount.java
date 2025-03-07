package com.itwillbs.project_fundizzy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BankAccount {
	private String user_seq_no;
	private String account_num;
	private String account_holder_name;
	private String fintech_use_num;
	private String account_bank_code;
	
}

