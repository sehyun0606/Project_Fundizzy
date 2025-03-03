package com.itwillbs.project_fundizzy.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.aop.BankTokenCheck;
import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.vo.BankToken;
import com.mysql.cj.log.Log;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class BankController {
	@Autowired
	private Bankservice bankservice;
	
	// 마이페이지 - 결제정보관리 페이지(등록한 계좌 목록 출력)
	@BankTokenCheck
	@GetMapping("ManageMyPaymentInfo")
	public String manageMyPaymentInfo(HttpSession session, Model model) {
		BankToken bankToken = (BankToken) session.getAttribute("token");
		System.out.println("토큰 정보 = " + bankToken);
		
		Map<String, Object> bankUserInfo = bankservice.getBankUserInfo(bankToken);
		System.out.println("API 응답 데이터: " + bankUserInfo);
		System.out.println("rsp code 출력 == " + bankUserInfo.get("rsp_Code"));
//		if(!bankUserInfo.get("rsp_code").equals("A0000")) {
//			model.addAttribute("msg", "요청처리과정에서 오류발생 \\n" + bankUserInfo.get("rsp_message"));
//			return "result/fail";
//		}
		model.addAttribute("bankUserInfo", bankUserInfo);
		return "bank/mypayment_info_manage";
	}
	
	
	//사용자인증 api 
	@GetMapping("callback")
	public String callback(@RequestParam Map<String, String> authResponse, Model model, HttpSession session) {
		System.out.println("응답결과 = " + authResponse);
		
		//사용자 인증을 위한 토큰 발급 
		BankToken token = bankservice.getAccessToken(authResponse);
		System.out.println(">>>>>>>>>>엑세스 토큰 정보 = " + token);
		
		if(token == null || token.getAccess_token() == null) {
			model.addAttribute("msg", "토큰 발급 실패! 다시 인증을 수행해 주세요. \\n 실패원인 : " + token.getRep_code() + " " + token.getRsp_message());
			model.addAttribute("isClose", true);
			return "result/fail";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", session.getAttribute("sId"));
		map.put("token", token);
		bankservice.registAccessToken(map);
		
		session.setAttribute("token", token);
		
		model.addAttribute("msg", "계좌 인증 완료!");
		model.addAttribute("isClose", true);
		
		return "result/success";
	}
	//계좌 등록 버튼 누르면 ManageMyPaymentInfo에 뜨도록 
	@PostMapping("BankAccountRegist")
	public String bankAccountRegist(HttpSession session ,Model model) {
		BankToken bankToken = (BankToken) session.getAttribute("token");
		Map<String, Object> bankUserInfo = bankservice.getBankUserInfo(bankToken);
		System.out.println("API 응답 데이터: " + bankUserInfo);
		System.out.println("rsp code 출력 == " + bankUserInfo.get("rsp_Code"));
		model.addAttribute("bankUserInfo", bankUserInfo);
		return "bank/mypayment_info_manage";
	}
	
}
 