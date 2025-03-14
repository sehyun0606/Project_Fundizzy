package com.itwillbs.project_fundizzy.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.service.FundHistoryService;
import com.itwillbs.project_fundizzy.service.FundService;
import com.itwillbs.project_fundizzy.service.PaymentService;
import com.itwillbs.project_fundizzy.service.ProjectInfoService;
import com.itwillbs.project_fundizzy.service.ProjectStoryService;
import com.itwillbs.project_fundizzy.service.RewardService;
import com.itwillbs.project_fundizzy.service.PaymentService;
import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;
import com.itwillbs.project_fundizzy.vo.Payment;
import com.itwillbs.project_fundizzy.vo.ProjectStoryVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;


@Controller
public class FundController {
	
	@Autowired
	private FundService fundService;
	
	@Autowired
	private Bankservice bankService;
	
	@Autowired
	private ProjectStoryService projectStoryService;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private RewardService rewardService;
	
	@Autowired
	private ProjectInfoService projectInfoService;
	
	
	//왼쪽 
	//fund 목록 (= 펀딩+ 누르면 이동하는 가장 첫 페이지)
	@GetMapping("FundList")
	public String fundList(Model model) {
		List<Map<String, Object>> fundList = fundService.getFundList();
		System.out.println("fundList = " + fundList);
		model.addAttribute("fundList", fundList);
		return "merch/funding/fund_list";
	}
	
	//fund 스토리
	@GetMapping("FundBoardStory")
	public String fundBoardStory(HttpSession session, String project_code, Model model) {
		System.out.println("project_code = " + project_code);
		String email = (String) session.getAttribute("sId");
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		//리워드 테이블 가져오기
		List<Map<String, Object>> reward = fundService.getReward(project_code);
		System.out.println("map = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, Object> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		
		return "merch/funding/fund_board_story";
	}
	
	//찜 등록
	@PostMapping("FundBoardStoryKeep")
	@ResponseBody
	public String fundBoardStoryKeep(String email, String project_code) {
		int keep = fundService.registKeep(email, project_code);
		
		//값이 없을 경우
	    if (email == null || project_code == null || email.isEmpty() || project_code.isEmpty()) {
	        System.out.println("⚠️ email 또는 project_code가 null입니다.");
	        return "error"; 
	    }
		return "true";
	}
	
	//찜 삭제
	@PostMapping("FundBoardStoryKeepDelete")
	@ResponseBody
	public String fundBoardStoryKeepDelete(String email, String project_code) {
		fundService.removeKeep(email, project_code);
		
		return "";
	}
	
	//fund 새소식 
	@GetMapping("FundBoardNew")
	public String fundBoardNew(String project_code, HttpSession session, Model model) {
		String email = (String)session.getAttribute("sId");
		System.out.println("project-code = " + project_code);
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		List<Map<String, Object>> newsList = fundService.getNews(project_code);
		System.out.println("뉴스리스트 - " + newsList);
		model.addAttribute("newsList", newsList); //ok
		
		//리워드 테이블 가져오기
		List<Map<String, Object>> reward = fundService.getReward(project_code);
		System.out.println("map = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, Object> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		return "merch/funding/fund_board_new";
	}
	
	
	//fund 지지서명
	@GetMapping("FundBoardSupport")
	public String fundBoardSupport(@RequestParam Map<String, Object> map, String project_code, Model model, HttpSession session) {
		String email = (String)session.getAttribute("sId");
		
		List<Map<String, Object>> supportList = fundService.getSupportList(project_code);
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
	public String supportSignature(@RequestParam Map<String, String> map, Model model, String project_code) {
		System.out.println("@@@@@@@@@@@@ map : " + map);
		System.out.println("******** project_code  : " + project_code);
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
		String email = map.get("email");
		String supportContent = map.get("support_content");
		
		System.out.println("eeeeeeeeeeeeeeee = " + project_code + email + email );
		//지지서명 등록
		fundService.getSupportSignature(project_code, email, supportContent, supportKeyword);
		
		return "redirect:/FundBoardSupport";
	}
	
	//fund 지지서명 - 댓글 작성 기능 
	@PostMapping("SupportReply")
	public String supportReply(@RequestParam Map<String, String> map, HttpSession session, Model model, String project_code,
			HttpServletRequest request) {
		
		//지지서명 출력 
//		List<Map<String, Object>> supportList = fundService.getSupportList();
		
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
//			model.addAttribute("supportList", supportList);
		}
		
		return "redirect:/FundBoardSupport";
	}
	
	//지지서명 - 댓글 삭제 기능
	@ResponseBody
	@GetMapping("SupportReplyDelete")
	public String supportReplyDelete(@RequestParam Map<String, Object> map, HttpSession session, Model model, String project_code,
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
	public String fundBoardSupporter(String project_code) {
		return "merch/funding/fund_board_supporter";
	}
	@GetMapping("FundBoardRefund")
	public String fundBoardRefund(String project_code) {
		return "merch/funding/fund_board_refund";
	}
	@GetMapping("FundBoardReward")
	public String fundBoardReward(String project_code) {
		return "merch/funding/fund_board_reward";
	}
	
	
	
//----------------------------------------------오른쪽 결제창 관련 -----------------------------------------------------------------------------------
	//리워드 선택 - get 
	@GetMapping("PaymentReward")
	public String paymentReward(String project_code, Model model) {
		List<Map<String, Object>> reward = fundService.getPaymentReward(project_code);
		System.out.println("reward map = " +  reward); // ok
		model.addAttribute("reward", reward);
		return "merch/payment/payment_reward";
	}
	
	//결제창으로 이동 - post 
	@PostMapping("PaymentPay")
	public String paymentPay(@RequestParam("reward_code[]") String[] rewardCodes, int total_count, int total_price, String project_code, Model model, HttpSession session) {
	    
	    // 이메일 가져오기
	    String email = (String) session.getAttribute("sId");
	   
	    // 히든값 가져오기 
	    System.out.println("!!!!!!!!!최종 수량: " + total_count);
	    System.out.println("!!!!!!!!!최종 가격: " + total_price);
	    
	    // 받은 reward_code 배열 출력
	    System.out.println("Received reward_codes: " + Arrays.toString(rewardCodes));
	    
	    // 히든값 모델에 저장 후 jsp에 전달
	    model.addAttribute("total_count", total_count);
	    model.addAttribute("total_price", total_price);
	    
	    // 선택한 리워드 가져오기 
	    List<RewardVO> rewardList = fundService.getPaymentSelectedReward(project_code, rewardCodes);
	    if (!rewardList.isEmpty()) { 
	        RewardVO selectedReward = rewardList.get(0);  
	        System.out.println("selectedReward = " + selectedReward);
	        model.addAttribute("selectedReward", selectedReward);
	    } else {
	        model.addAttribute("selectedReward", null);
	        System.out.println("**리스트가 비어있어요");
	    }

	    // 배송을 위한 member 정보 가져오기 
	    Map<String, Object> member = fundService.getPaymentPayMember(email);
	    System.out.println("payment member = " + member);
	    model.addAttribute("member", member);
	    
	    // 결제를 위한 펀디지 페이(가장 최근꺼 하나만) 들고오기 
	    Map<String, Object> fundizzy_pay  = bankService.getFundizzyPayLast(email);
	    model.addAttribute("fundizzy_pay", fundizzy_pay);
	    System.out.println("list fundizzy_pay " + fundizzy_pay);
	    return "merch/payment/payment_pay";
	}
	
	//결제창으로 이동 - get 비지니스 로직
	@GetMapping("PaymentPay")
	public String paymentPayPage() {
		return "merch/payment/payment_pay";
	}
	
	//결제완료 창으로 이동
	@PostMapping("PaymentComplete")
	public String paymentComplete(@RequestParam Map<String, Object> map, HttpSession session ,Model model, String project_code,  @RequestParam(value = "reward_code", required = false) String[] rewardCodes) {
		System.out.println("필요한거 : " + map);
		
		String email = (String) session.getAttribute("sId");
		System.out.println("* project_code = " + project_code);
		
		//1 페이로 결제한 내역 계산 후 pay table에 insert 작업 
		map.put("email", email);
		map.put("pay_tran_id", UUID.randomUUID().toString());
		
//		System.out.println("ajax에서 받은 map 과연?? = " + map);
//		System.out.println("email: " + map.get("email"));
//		System.out.println("result_balance: " + map.get("result_balance"));
//		System.out.println("pay_tran_id: " + map.get("pay_tran_id"));  // 추가 확인
//		System.out.println("total_count: " + map.get("total_count"));  // 주문수량
//		System.out.println("payment_price: " + map.get("payment_price")); // 최종결제금액 (배송비포함)
		
		
		// 1. 결제 정보 저장 성공
		// 2. 결제내역 input
		// 3. 배송지 input
		// 4. 펀딩내역(fund-history) input
		// 위 작업중 하나라도 실패할경우 다 원위치
		// service에서 트랜잭션 실행
		Boolean isSuccess = fundService.insertForPayment(map);
		
//		int result = fundService.registPaymentPay(map);
//		if (result > 0) {
//		    System.out.println("1번 결제 정보 저장 성공 - registPaymentPay");
//		} else {
//		    System.out.println("결제 정보 저장 실패");
//		}
				
		// 2. 결제내역 input
//		map.put("payment_code", UUID.randomUUID().toString());
//		int pay_result = fundService.registPayment(map);
//		if(pay_result > 0) {
//			System.out.println("*2번 결제내역 payment input 성공 *");
//		}
		
		// 3. 배송지 input
//		int result_ship = fundService.registShipMent(map);
//		if(result_ship > 0) {
//			System.out.println("#3번배송지 input 성공 @");
//		}
		
		// 4. 펀딩내역(fund-history) input 
		
//		String projectTitle = projectStoryService.getProject_title((String) map.get("project_code"));
//		String representativePicture = projectStoryService.getRepresentativePicture((String) map.get("project_code"));
//	    String productName = rewardService.getproductName((String) map.get("project_code"));
//	    String rewardCode = rewardService.getrewardCode((String) map.get("project_code"));
//	    String paymentCode = paymentService.getPaymentCode((String)map.get("project_code"));
//	    String businessName = projectInfoService.getBusinessName((String) map.get("project_code"));
	    
//	    map.put("project_title", projectTitle);// 프로젝트 제목 추가 
//	    map.put("representative_picture", representativePicture); // 대표사진 추가 - 완료 
//	    map.put("product_name", productName);// 제품명 추가
//	    map.put("reward_code", rewardCode);// 리워드코드 추가
//	    map.put("payment_code", paymentCode);// 결제코드 추가
//	    map.put("business_name", businessName);// 회사명 추가 

//		System.out.println("@@@MAP" + map);
//		int resultFundHistory = fundService.registFundHistory(map);
//		if(resultFundHistory > 0) {
//			System.out.println("#4번  input 성공 @");
//		}
		
//		//리워드 가져오기 
//		 List<RewardVO> rewardList = fundService.getPaymentSelectedReward(project_code, rewardCodes);
//		System.out.println("pay reward = " + rewardList);
//		model.addAttribute("reward", rewardList);  // 리워드 데이터
//		
//		model.addAttribute("map", map);     
		return "merch/payment/payment_complete";
	}
	
	
	//결제 완료창 - get 비지니스 로직
	@GetMapping("PaymentComplete")
	public String paymentCompletePage(String project_code, Model model) {
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
