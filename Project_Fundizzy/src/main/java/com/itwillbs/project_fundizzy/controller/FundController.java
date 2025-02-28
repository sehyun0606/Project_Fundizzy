package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_fundizzy.service.FundService;


@Controller
public class FundController {
	@Autowired
	private FundService fundService;
//	왼쪽 
	//fund 목록
	@GetMapping("FundList")
	public String fundList() {
		return "merch/funding/fund_list";
	}
	//fund 스토리
	@GetMapping("FundBoardStory")
	public String fundBoardStory() {
		return "merch/funding/fund_board_story";
	}
	//fund 새소식 
	@GetMapping("FundBoardNew")
	public String fundBoardNew() {
		return "merch/funding/fund_board_new";
	}
	//fund 새소식 - 글 
	@GetMapping("FundBoardNewBoard")
	public String fundBoardNewBoard() {
		return "merch/funding/fund_board_new_board";
	}
	//fund 지지서명
	@GetMapping("FundBoardSupport")
	public String fundBoardSupport(@RequestParam Map<String, Object> map , Model model ) {
		
		List<Map<String, Object>> supportList = fundService.getSupportList();
		model.addAttribute("supportList", supportList);
		System.out.println("supportList ======== " + supportList);
		return "merch/funding/fund_board_support";
	}
	//fund 서포터
	@GetMapping("FundBoardSupporter")
	public String fundBoardSupporter() {
		return "merch/funding/fund_board_supporter";
	}
	@GetMapping("FundBoardRefund")
	public String fundBoardRefund() {
		return "merch/funding/fund_board_refund";
	}
	@GetMapping("FundBoardReward")
	public String fundBoardReward() {
		return "merch/funding/fund_board_reward";
	}
//오른쪽 결제창 관련 
	@GetMapping("PaymentReward")
	public String paymentReward() {
		return "merch/payment/payment_reward";
	}
	@GetMapping("PaymentPay")
	public String paymentPay() {
		return "merch/payment/payment_pay";
	}
	@GetMapping("PaymentComplete")
	public String paymentComplete() {
		return "merch/payment/payment_complete";
	}
	
	//지지서명 등록 
	@PostMapping("SupportSignature")
	public String supportSignature(@RequestParam Map<String, String> map, Model model) {
		System.out.println("@@@@@@@@@@@@ map : " + map);
		String supportKeyword = "";
		if("on".equals(map.get("like"))) {
			supportKeyword += 1;
		}
		if("on".equals(map.get("life"))) {
			supportKeyword += 2;
			
		}
		if("on".equals(map.get("useful"))) {
			supportKeyword += 3;
			
		}
		if("on".equals(map.get("littleMoney"))) {
			supportKeyword += 4;
			
		}
		if("on".equals(map.get("cheerup"))) {
			supportKeyword += 5;
			
		}
		//지지서명시 필요한 값 들고오기
		//프로젝트 코드, 회원 아이디(이메일주소), 응원의 글, 키워드
		int project_code = Integer.parseInt(map.get("project_code"));
		String email = map.get("email");
		String supportContent = map.get("support_content");
		System.out.println(supportKeyword);
		fundService.getSupportSignature(project_code, email, supportContent, supportKeyword);
		return "redirect:/FundBoardSupport";
	}
}
