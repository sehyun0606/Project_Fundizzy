package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BankController {
	
	// 마이페이지 - 결제정보관리 페이지
	@GetMapping("ManageMyPaymentInfo")
	public String manageMyPaymentInfo() {
		return "bank/my_payment_info_manage";
	}
}
 