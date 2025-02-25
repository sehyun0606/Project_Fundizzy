package com.itwillbs.project_fundizzy.controller;

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
	@GetMapping("FundList")
	public String fundList() {
		return "merch/funding/fund_list";
	}
	@GetMapping("FundBoardStory")
	public String fundBoardStory() {
		return "merch/funding/fund_board_story";
	}
	@GetMapping("FundBoardNew")
	public String fundBoardNew() {
		return "merch/funding/fund_board_new";
	}
	@GetMapping("FundBoardNewBoard")
	public String fundBoardNewBoard() {
		return "merch/funding/fund_board_new_board";
	}
	@GetMapping("FundBoardSupport")
	public String fundBoardSupport() {
		return "merch/funding/fund_board_support";
	}
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
	@ResponseBody
	@PostMapping("SupportSignature")
	public String Supportsignature(@RequestParam Map<String, String> map, Model model) {
		//지지서명시 필요한 값 들고오기
		//프로젝트 코드, 회원 아이디(이메일주소), 응원의 글, 키워드
		int project_code = Integer.parseInt(map.get("project_code"));
		String email = map.get("email");
		String supportContent = map.get("support_content");
		String supportKeyword = map.get("support_keyword");
		
		//등록여부 판별
		fundService.getSupportSignature(project_code, email, supportContent, supportKeyword);
//		if(insertCount > 0) {
//			model.addAttribute("msg", "응원글 등록에 성공하셨습니다.");
//			return "redirect:/Review";
//		}else {
//			model.addAttribute("msg", "응원글 등록에 실패하셨습니다.");
//			return "result/process";
//		}
		return "";
	}
}
