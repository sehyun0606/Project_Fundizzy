package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.service.MypageService;
import com.itwillbs.project_fundizzy.vo.BankAccount;
import com.itwillbs.project_fundizzy.vo.BankToken;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;
import com.mysql.cj.Session;


@Controller
public class MyPageController {
	@Autowired
	private MypageService mypageService;
	@Autowired
	private Bankservice bankService;
	// 서포터 메인
	@GetMapping("SupporterPage")
	public String SupporterPage(Model model) {
		model.addAttribute("user","supporter");
		return "myPage/supporter/supporter_mypage";
	}
	
	// 설정 메인 - 프로필 아래 내정보설정 버튼을 통해 이동
	@GetMapping("SettingMain")
	public String SettingMain() {
		return "myPage/supporter/setting_main";
	}
	
	// 프로필 설정 - 설정메인에서 버튼을 통해 이동
	@GetMapping("ProfileSettings")
	public String ProfileSettings() {
		return "myPage/supporter/profile_settings";
	}
	
	@GetMapping("MemberInfo")
	public String memberInfo() {
		return "myPage/supporter/member_info";
	}
	
	//메이커페이지 이동
	//전달하는 파라미터: user값 maker
	//				프로젝트 리스트
	@GetMapping("MakerPage")
	public String makerPage(Model model,HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		List<ProjectListVO> projectList = mypageService.getMyProjectList(id);
		
		model.addAttribute("projectCount", projectList.size());
		model.addAttribute("projectList", projectList);
		model.addAttribute("user", "maker");
		
		return "myPage/maker/maker_mypage";
	}
	
	//페이 페이지
	@GetMapping("PayPage")
	public String payPage() {
		return "myPage/supporter/pay_page";
	}
	
	
	//페이 충전 페이지 (정유나 -> 아이티윌) - POST 
	@PostMapping("PayCharge")
	public String payCharge(@RequestParam Map<String, Object> map, HttpSession session, Model model ) {
		// 토큰 가져오기 
		BankToken bankToken = (BankToken) session.getAttribute("token");
		System.out.println("banktoken = " + bankToken);
		
		// map에 토큰과 세션의 아이디 저장 
		map.put("bankToken", bankToken);
		map.put("email", session.getAttribute("sId"));
		
		// DB에서 등록된 계좌정보 들고와서 map에 저장
		BankAccount bankAccount = bankService.getDBAccountInfo(bankToken.getUser_seq_no());
		map.put("bankAccount", bankAccount);
		
		// map에 출금이체(=충전) 요청을 리턴
		Map<String, Object> chargeResult = bankService.requestCharge(map);
		
		if(!chargeResult.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", "rsp_code 오류발생 \\n 다시 시도하세요." + chargeResult.get("rsp_message"));
			return "result/fail";
		}
		//충전 결과 map에 사용자 일련번호 저장 
		chargeResult.put("user_seq_no", bankToken.getUser_seq_no());
		
		//이체결과 저장 요청
		bankService.registChargeResult(chargeResult);
		model.addAttribute("bank_tran_id", chargeResult.get("bank_tran_id"));
		
		return "redirect:/BankChargeResult";
	}
	
//	페이 충전 페이지 (정유나 -> 아이티윌) - 비지니스 로직 
	@GetMapping("PayCharge")
	public String payCharge(String bank_tran_id , Model model) {
		
		return "myPage/supporter/pay_charge";
	}
	
	
//	페이 충전결과 페이지 (정유나 -> 아이티윌)
	@GetMapping("PayChargeResult")
	public String payChargeResult(String bank_tran_id , Model model) {
		Map<String, Object> chargeResult = bankService.getDBTransactionResult(bank_tran_id);
		model.addAttribute("chargeResult", chargeResult);
		return "myPage/supporter/pay_charge_result";
	}
	
	//페이 송금 페이지 (아이티윌 -> 정유나)
	@PostMapping("PayTransfer")
	public String payTransfer() {
		// 세션에서 토큰 가져오기
		
		//map 객체에 세션 아이디 추가 
		
		// DB에서 등록된 계좌정보 들고와서 map에 저장
		
		//map에 대표계좌 정보 저장
		
		//requestTransfer() 요청해서 map의 transferResult에 저장 
		
		//@응답데이터가 map 객체로 저장되어있으며 객체내에 res_list값이 리스트 형태로 저장됨
		//1. res_list값에 해당하는 list 객체 꺼내기
		//2. res_list내의 첫번째 이체 결과정보 객체 꺼내서 map으로 저장 
		
		//api응답코드가 "A0000"가 아닌 경우엔 오류메시지 띄우기 - String msg 써서 하는거라 보고하기
		
		//transferResult에 입금이체 결과 db에 저장 
		
		//서비스에 registTransferResult(transferResult) 저장 요청 - 리턴타입 보이드
		
		//모델에 transferResult 중 거래고유번호값 model에 추가 후 전달
		
		//출금이체 조회 결과 페이지로 리다이렉트 
		
		
		
		return "myPage/supporter/pay_transfer";
	}
}
