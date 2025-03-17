package com.itwillbs.project_fundizzy.controller;

import java.nio.file.spi.FileSystemProvider;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

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

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
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
import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;
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
		System.out.println("reward = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, Object> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		
		return "merch/funding/fund_board_story";
	}
	
	//찜 등록
	@PostMapping("FundBoardStoryKeep")
	@ResponseBody
	public String fundBoardStoryKeep(String project_code, HttpSession session) {
		String email = (String) session.getAttribute("sId");
		System.out.println("email = " + email);
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
		
		// *새소식 리스트 가져오기 
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
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		// *지지서명 가져오기 
		List<Map<String, Object>> supportList = fundService.getSupportList(project_code);
		model.addAttribute("supportList", supportList);
		System.out.println("supportList ======== " + supportList);
		
		// * 댓글 목록 조회 기능 
		List<Map<String, Object>> ReplyList = fundService.getReplyList(map);
		System.out.println("Reply LIst = " + ReplyList);
		model.addAttribute("ReplyList", ReplyList);
		
		//리워드 테이블 가져오기
		List<Map<String, Object>> reward = fundService.getReward(project_code);
		System.out.println("map = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, Object> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		
		return "merch/funding/fund_board_support";
	}
	
	//지지서명 등록 
	@PostMapping("SupportSignature")
	public String supportSignature(@RequestParam Map<String, String> map, Model model, String project_code) {
		
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
		
		//지지서명 등록
		fundService.getSupportSignature(project_code, email, supportContent, supportKeyword);
		
		return "redirect:/FundBoardSupport";
	}
	
	//fund 지지서명 - 댓글 작성 기능 
	@PostMapping("SupportReply")
	public String supportReply(@RequestParam Map<String, Object> map, HttpSession session, Model model, String project_code,
			HttpServletRequest request) {
		
		//지지서명 출력 
//		List<Map<String, Object>> supportList = fundService.getSupportList();
		
		//댓글 테이블 출력 
		List<Map<String, Object>> ReplyList = fundService.getReplyList(map);
		System.out.println("Reply LIst = " + ReplyList);
		
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
		
		//지지서명 테이블 가져오기 
		String maker_email = (String)session.getAttribute("sId");
		System.out.println("maker_email = " + maker_email);
		
		//댓글 테이블 가져오기 
		List<Map<String, Object>> ReplyList = fundService.getReplyList(map);
		System.out.println("Reply LIst = " + ReplyList);
		
		if(maker_email == null) {
			responseMap.put("invalidSession", true);
		}else {
			map.put("reply_writer", maker_email);
			//댓글 작성자와 현재 세션에 로그인 된 아이디가 일치 하지 않을경우
			if(!maker_email.equals(map.get("reply_writer")) && fundService.getReplyWriter(map) == null) {
				System.out.println("댓글 작성자와 아이디가 일치하지 않습니다.");
				responseMap.put("invalidSession", true);
				} else {
					int count = fundService.updateSupportReply(map);
					if(count > 0) {
						System.out.println("db 에서 댓글 삭제 성공");
					}
					responseMap.put("result", true);
			}
		}
		JSONObject jo = new JSONObject(responseMap);
		
		return jo.toString();
	}
	
	//fund 서포터
	@GetMapping("FundBoardSupporter")
	public String fundBoardSupporter(String project_code, HttpSession session, Model model) {
		
		String email = (String)session.getAttribute("sId");
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		//**서포터 출력을 위한 fund_history 테이블 가져오기
		List<Map<String, Object>> fund_history = fundService.getFundHistory(project_code);
		System.out.println("fund history = " + fund_history);
		model.addAttribute("fund_history", fund_history);
		
		//리워드 테이블 가져오기
		List<Map<String, Object>> reward = fundService.getReward(project_code);
		System.out.println("map = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, Object> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		
		return "merch/funding/fund_board_supporter";
	}
	
	//환불 규정
	@GetMapping("FundBoardRefund")
	public String fundBoardRefund(String project_code, HttpSession session, Model model) {
		String email = (String)session.getAttribute("sId");
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		//**서포터 출력을 위한 fund_history 테이블 가져오기
		List<Map<String, Object>> fund_history = fundService.getFundHistory(project_code);
		System.out.println("fund history = " + fund_history);
		model.addAttribute("fund_history", fund_history);
		
		//리워드 테이블 가져오기
		List<Map<String, Object>> reward = fundService.getReward(project_code);
		System.out.println("map = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, Object> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		return "merch/funding/fund_board_refund";
	}

	
	
	
//----------------------------------------------오른쪽 결제 관련 -----------------------------------------------------------------------------------
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
	public String paymentPay(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		
		String email = (String)session.getAttribute("sId");
	    //히든값 모델에 저장 후 jsp에 전달
	    model.addAttribute("total_price", map.get("total_price"));
	    
	    // 리워드정보를 저장할 List 객체
	    List<RewardVO> rewardList = new ArrayList<RewardVO>();
	    
	    // 선택한 리워드 정보조회 후, 선택한 리워드 개수와함께 맵객체에 저장후
	    // 리스트 객체에 저장
	    // 리워드 등록가능 개수 5, 선택한 리워드 개수가 랜덤으로 넘어와서 반복문으로 판별
	    for(int i = 1; i < 6; i ++) {
	    	// 리워드 카운트가 null이 아니고 카운트가 0이 아니면 해당 리워드를 선택
	    	// 해당 리워드정보 조회후 선택한 개수와 함께 rewardInfoList에 저장
	    	if(map.get("rewardCount" + i) != null && !map.get("rewardCount" + i).equals("0")) {
	    		RewardVO reward = fundService.getPaymentSelectedReward(map.get("project_code"), map.get("reward" + i));
				reward.setProduct_count(Integer.parseInt(map.get("rewardCount" + i)));
				rewardList.add(reward);
	    	}
	    }
	    // 배송비 저장을 위한 project info 테이블 가져오기
	    ProjectInfoVO project_info = new ProjectInfoVO();
	    model.addAttribute("project_info", project_info);
	    
	    // 선택한 리워드 정보와 개수 모델에저장
	    model.addAttribute("rewardList", rewardList);
	    System.out.println("rewardList = " + rewardList);
	    
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
	
	//결제 완료창으로 이동 - post
	@PostMapping("PaymentComplete")
	public String paymentComplete(@RequestParam Map<String, String> map, HttpSession session ,Model model, String payment_price,
			String delivery_fee) {
	    String email = (String) session.getAttribute("sId");
	    String pay_tran_id = UUID.randomUUID().toString();
	    // 1 페이로 결제한 내역 계산 후 pay table에 insert 작업 
	    map.put("email", email);
	    map.put("pay_tran_id", pay_tran_id);
	    map.put("payment_price", payment_price);
	    map.put("delivery_fee", delivery_fee);
	    System.out.println("필요한거 : " + map);
	    
	    
	    // 2. 결제내역 input
	    // 3. 배송지 input
	    // 4. 펀딩내역(fund-history) input
	    // 위 작업중 하나라도 실패할경우 다 원위치
	    // service에서 트랜잭션 실행
	    
	    Boolean isSuccess = fundService.insertForPayment(map);
	    if(!isSuccess) {
	    	model.addAttribute("msg", "결제에 실패하셨습니다.");
	    	return "result/fail";
	    }
	    
	    List<Map<String, Object>> resultList = fundService.getResultList(pay_tran_id);
	    model.addAttribute("resultList", resultList);
	    System.out.println("resultList" + resultList);
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
