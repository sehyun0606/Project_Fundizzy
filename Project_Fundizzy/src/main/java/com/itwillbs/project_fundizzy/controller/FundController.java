package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.service.FundService;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;


@Controller
public class FundController {
	
	@Autowired
	private FundService fundService;
	
	@Autowired
	private Bankservice bankService;
	
//	왼쪽 
	//fund 목록
	@GetMapping("FundList")
	public String fundList() {
		return "merch/funding/fund_list";
	}
	//fund 스토리
	@GetMapping("FundBoardStory")
	public String fundBoardStory(String project_code, Model model) {
		
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
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
		
		// 댓글 목록 조회 기능 
		List<Map<String, Object>> ReplyList = fundService.getReplyList(map);
		System.out.println("Reply LIst = " + ReplyList);
		
		//모델에 추가 후 넘기기 
		model.addAttribute("ReplyList", ReplyList);
		
		return "merch/funding/fund_board_support";
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
		int project_code = Integer.parseInt(map.get("project_code"));
		String email = map.get("email");
		String supportContent = map.get("support_content");
		
		fundService.getSupportSignature(project_code, email, supportContent, supportKeyword);
		
		return "redirect:/FundBoardSupport";
	}
	
	//fund 지지서명 - 댓글 작성 기능 
	@PostMapping("SupportReply")
	public String supportReply(@RequestParam Map<String, String> map, HttpSession session, Model model, 
			HttpServletRequest request) {
		
		//지지서명 출력 
		List<Map<String, Object>> supportList = fundService.getSupportList();
		
		//세션에 있는 아이디 저장 
		String maker_email = (String) session.getAttribute("sId");
		System.out.println("makerEmail = " + maker_email);
		
		//map에 아이디 및 ip 저장
		map.put("maker_email", maker_email);
		map.put("reply_writer_ip", getClientIp(request));
		
		//댓글 db에 등록 
		int count = fundService.registSupportReply(map);
		
		if(count > 0) {
			System.out.println("insert 성공!!!!!!!!!!");
			model.addAttribute("supportList", supportList);
		}
		
		return "redirect:/FundBoardSupport";
	}
	
	//지지서명 - 댓글 삭제 기능
	@ResponseBody
	@GetMapping("SupportReplyDelete")
	public String supportReplyDelete(@RequestParam Map<String, Object> map, HttpSession session, Model model,
			HttpServletRequest request, @RequestParam Map<String, Object> responseMap) {
		
		//지지서명 출력 
		String maker_email = (String)session.getAttribute("sId");
		System.out.println("maker_email = " + maker_email);
		
		if(maker_email == null) {
			responseMap.put("invalidSession", true);
		}else {
			map.put("reply_writer", maker_email);
			//댓글 작성자와 현재 세션에 로그인 된 아이디가 일치 하지 않을경우
			if(!maker_email.equals(map.get("reply_writer")) && fundService.getReplyWriter(map) == null) {
				responseMap.put("invalidSession", true);
				} else {
					int count = fundService.removeSupportReply(map);
					if(count > 0) {
						System.out.println("댓글 삭제 성공");
					}
					responseMap.put("result", true);
			}
		}
		
		JSONObject jo = new JSONObject(responseMap);
		
		return jo.toString();
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
	
	
	
//----------------------------------------------오른쪽 결제창 관련 -----------------------------------------------------------------------------------
	//리워드 선택 - get 
	@GetMapping("PaymentReward")
	public String paymentReward(String project_code, Model model) {
		
		Map<String, Object> reward = fundService.getPaymentReward(project_code);
		System.out.println("reward map = " +  reward); // ok
		
		model.addAttribute("reward", reward);
		return "merch/payment/payment_reward";
	}
	
	
	
	//결제창으로 이동 - post 
	@PostMapping("PaymentPay")
	public String paymentPay(String reward_code, int total_count, int total_price, String project_code, Model model, HttpSession session) {
		
		//이메일 가져오기
		String email = (String) session.getAttribute("sId");
		
	   //히든값 가져오기 
	   System.out.println("!!!!!!!!!최종 수량: " + total_count);
	   System.out.println("!!!!!!!!!최종 가격: " + total_price); 
	   System.out.println("**********리워드 코드: " + reward_code); //ok
	   
	   //히든값 모델에 저장 후 jsp 에 ~>..
	   model.addAttribute("total_count", total_count);
	   model.addAttribute("total_price", total_price);
	   
		//리워드 가져오기 
		Map<String, Object> reward = fundService.getPaymentReward(project_code);
		System.out.println("pay reward = " + reward);
		model.addAttribute("reward", reward);
		
		
		//배송을 위한 member 정보 가져오기 
		Map<String, Object> member = fundService.getPaymentPayMember(email);
		System.out.println("payment member = " + member);
		model.addAttribute("member", member);
		
		//결제를 위한 펀디지 페이 들고오기 
		FundizzyPay fundizzy_pay = (FundizzyPay) bankService.getFundizzyPay(email);
		model.addAttribute("fundizzy_pay", fundizzy_pay);
		
		return "merch/payment/payment_pay";
	}
	
	//결제창으로 이동 - get 
	@GetMapping("PaymentPay")
	public String paymentPayPage() {
		return "merch/payment/payment_pay";
	}
	
	//결제 완료창 
	@GetMapping("PaymentComplete")
	public String paymentComplete() {
		return "merch/payment/payment_complete";
	}
	
	
	
//	-- 유틸리티 메서드 --
	//ip 가져오기
	private String getClientIp(HttpServletRequest request) {
		String ipAddress = request.getRemoteAddr();
		System.out.println( "ip값 === " + ipAddress);
		if(ipAddress .equals("0:0:0:0:0:0:0:1")) {
			ipAddress = "127.0.0.1";
		}
		
		return ipAddress;
	}
}
