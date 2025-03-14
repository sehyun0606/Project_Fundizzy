package com.itwillbs.project_fundizzy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.service.FundizzyPayService;
import com.itwillbs.project_fundizzy.service.MypageService;
import com.itwillbs.project_fundizzy.vo.BankAccount;
import com.itwillbs.project_fundizzy.vo.BankToken;
import com.itwillbs.project_fundizzy.vo.FundizzyPay;
import com.itwillbs.project_fundizzy.vo.MemberVO;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;
import com.mysql.cj.Session;


@Controller
public class MyPageController {
	@Autowired
	private MypageService mypageService;
	@Autowired
	private Bankservice bankService;
	
	@Autowired
	private FundizzyPayService fundizzyService;
	
	private String virtualPath = "/resources/upload/";
	
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
	public String ProfileSettings(Model model, HttpSession session) {
		String email = (String)session.getAttribute("sId");
		
		MemberVO member = mypageService.getMemberInfo(email);
		
		model.addAttribute("memberInfo", member);
		return "myPage/supporter/profile_settings";
	}
	
	@PostMapping("ProfileInfoEdit")
	public String profileInfoEdit(MemberVO member, HttpSession session) {
		

		String email = (String) session.getAttribute("sId");
		String realPath = getRealPath(session, virtualPath);
		
		member.setEmail(email);
		
		//파일 업로드되는 서브 경로
		String subDir = email + "/ProfileImg" ;
		
		realPath += subDir;
		try {
			Path path = Paths.get(realPath);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile profileImg = member.getProfileImg();
		
		member.setProfile("");
		
		String imgName = "";
		
		if(!profileImg.getOriginalFilename().equals("")) {
			imgName = UUID.randomUUID().toString() + "_" + profileImg.getOriginalFilename();
			member.setProfile(subDir + "/" + imgName);
		}
		
		mypageService.updateProfile(member);
		
		session.setAttribute("profileImg", member.getProfile());
		
		
		updateFile(profileImg, realPath, imgName);
		
		return "redirect:/SupporterPage";
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
	public String payPage(HttpSession session, Model model) {
		//이메일 가져오기
		String email = (String) session.getAttribute("sId");
		// 토큰 가져오기 
		BankToken bankToken = (BankToken)session.getAttribute("token");
		System.out.println("세션 = " + bankToken);
		if(bankToken == null) {
			model.addAttribute("msg", "금융 인증 후 사용 가능합니다.");
			return "result/fail";
		}
		
		//페이 정보를 표시하기 위해 페이 가져오기
		FundizzyPay fundizzy_pay_info = bankService.getFundizzyPayInfo(email);
		System.out.println("@@fundizzy_pay_info = " + fundizzy_pay_info);
		model.addAttribute("fundizzy_pay_info", fundizzy_pay_info);
		
		
		//페이 입출금 정보를 표시하기 위해 페이 가져오기
		List<FundizzyPay> fundizzy_pay = bankService.getFundizzyPay(email);
		
		model.addAttribute("fundizzy_pay", fundizzy_pay);
		return "myPage/supporter/pay_page";
	}
	
	
	//페이 충전 페이지 (정유나 -> 아이티윌) - POST 
	@PostMapping("PayCharge")
	public String payCharge(@RequestParam Map<String, Object> map, String tran_amt, HttpSession session, Model model ) {

		// 토큰 및 이메일 가져오기 
		BankToken bankToken = (BankToken)session.getAttribute("token");
		String email = (String) session.getAttribute("sId");
		System.out.println("세션 = " + bankToken);
		if(bankToken == null) {
			return "result/fail";
		}
		
		// map에 토큰과 세션의 아이디 저장 
		map.put("bankToken", bankToken);
		map.put("email", email);
		map.put("tran_amt", tran_amt);
		
		// DB에서 등록된 계좌정보 들고와서 map에 저장
		BankAccount bankAccount = bankService.getDBAccountInfo(bankToken.getUser_seq_no());
		map.put("bankAccount", bankAccount);
		
		// map에 출금이체(=충전) 요청을 리턴
		Map<String, Object> chargeResult = bankService.requestCharge(map);
		System.out.println("!!!!chargeResult = " + chargeResult);
		System.out.println("****map = " + map);
		
		if(!chargeResult.get("rsp_code").equals("A0000")) {
			model.addAttribute("msg", "rsp_code 오류발생 \\n 다시 시도하세요." + chargeResult.get("rsp_message"));
			return "result/fail";
		}
		//충전 결과 map에 사용자 일련번호 및 이메일 저장 
		chargeResult.put("user_seq_no", bankToken.getUser_seq_no());
		chargeResult.put("email", email);
		
		//이체결과 저장 요청
		int charge_result = bankService.registChargeResult(chargeResult);
		
		//페이 잔액 업데이트를 위한 fundizzy_pay 들고오기
		String payBalance = fundizzyService.getPayBalance(email);
		System.out.println("payBalance " + payBalance);
		map.put("payBalance", payBalance);
		
		if(charge_result > 0) {
			System.out.println("충전 성공");
			System.out.println("*****세션에 저장된 sId: " + session.getAttribute("sId"));
			System.out.println("bankToken의 이메일: " + bankToken.getEmail());
			//충전 성공시 잔액과 충전금액 더한값 페이 잔액에 update
			int pay_amt_result = bankService.registPayAmtResult(chargeResult, payBalance,email);
			if(pay_amt_result > 0) {
				System.out.println("잔액 업데이트 성공 ");
			}
		}
		model.addAttribute("bank_tran_id", chargeResult.get("bank_tran_id"));
		
		// pay 테이블 인설트를 위한 맵객체 생성
		Map<String, String> mapForPay = new HashMap<String, String>();
		mapForPay.put("email", (String)session.getAttribute("sId"));
		mapForPay.put("pay_amt", tran_amt);
		mapForPay.put("pay_type", "CH");
		
		//충전금액 pay 테이블에 적용
		bankService.payTransaction(mapForPay);
		
		return "redirect:/PayChargeResult";
	}
	
//	페이 충전 페이지 (정유나 -> 아이티윌) - 비지니스 로직 
	@GetMapping("PayCharge")
	public String payCharge() {
		return "myPage/supporter/pay_charge";
	}
	
	
//	페이 충전결과 페이지 (정유나 -> 아이티윌)
	@GetMapping("PayChargeResult")
	public String payChargeResult(HttpSession session, String bank_tran_id , Model model) {
		System.out.println("bank_tran_id " + bank_tran_id);
		
		String email = (String) session.getAttribute("sId"); 
		System.out.println("이메일!!!! " + email );
		
		//db에 거래결과 저장
		Map<String, Object> chargeResult = bankService.getDBTransactionResult(bank_tran_id);
		model.addAttribute("chargeResult", chargeResult);
		
		//페이 테이블에서 잔액 가져오기 
		int payBalance = fundizzyService.getPayBalanceInt(email);
		System.out.println("payBalance" + payBalance);
		model.addAttribute("payBalance", payBalance);
		
		return "myPage/supporter/pay_charge_result";
	}
	
	//페이 입금 페이지 (아이티윌 -> 정유나) 
	@PostMapping("PayTransfer")
	public String payTransfer(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		// 세션에서 토큰 가져오기
		String email = (String) session.getAttribute("sId");
		BankToken bankToken = (BankToken) session.getAttribute("token");
//		System.out.println("###### banktoken = " + bankToken);
		
		//map 객체에 세션 아이디 추가 
		map.put("email",email);
		System.out.println("###### map = " + map);
		
		// DB에서 등록된 계좌정보 들고와서 
		BankAccount bankAccount = bankService.getDBAccountInfo(bankToken.getUser_seq_no());
//		System.out.println("user_seq - no == " + bankToken.getUser_seq_no());
		
		//map에 대표계좌 정보 저장
		map.put("bankAccount", bankAccount);
		
		//requestTransfer() 요청해서 map의 transferResult에 저장 
		Map<String, Object> transferResult = bankService.requestDeposit(map);
//		System.out.println("@@@@@@@@@transfer result = " + transferResult);
		
		//@응답데이터가 map 객체로 저장되어있으며 객체내에 res_list값이 리스트 형태로 저장됨
		//1. res_list값에 해당하는 list 객체 꺼내기
		List<Object> res_list = (List<Object>)transferResult.get("res_list");
//		System.out.println("*****res_list == " + res_list);
		
		//2. res_list내의 첫번째 이체 결과정보 객체 꺼내서 map으로 저장 
		Map<String, Object> result = (Map<String, Object>)res_list.get(0);
//		System.out.println("****result == " + result);
		
		//@api응답코드가 "A0000"가 아닌 경우엔 오류메시지 띄우기 - String msg 써서 하는거라 보고하기
		if(!transferResult.get("rsp_code").equals("A0000")) {
			String msg = "요청 처리 과정에서 오류발생 \\n" + transferResult.get("rsp_message");
			msg += "\\n" + result.get("tran_no") + " : " + result.get("bank_rsp_message");
			model.addAttribute("msg", msg);
			return "result/fail";
		}
		
		//transferResult에 입금이체 결과 db에 저장 
		transferResult.put("user_seq_no", bankToken.getUser_seq_no());
		
		transferResult.put("email", email);
		
		//서비스에 registTransferResult(transferResult) 저장 요청 - 리턴타입 보이드
		bankService.registTransferResult(transferResult);
		
		//모델에 transferResult 중 거래고유번호값 model에 추가 후 전달
		model.addAttribute("bank_tran_id", transferResult.get("bank_tran_id"));
		
		//입금이체 조회 결과 페이지로 리다이렉트 
		return "redirect:/PayTransferResult";
		
	}
	
	//페이 입금 페이지 (아이티윌 -> 정유나) - 비지니스 로직 
	@GetMapping("PayTransfer")
	public String payTransfer() {
		return "myPage/supporter/pay_transfer";
	}
	
	//페이 입금 완료(결과) 페이지
	@GetMapping("PayTransferResult")
	public String payTransferResult(HttpSession session, String bank_tran_id , Model model) {
		System.out.println("bank_tran_id " + bank_tran_id);
		
		String email = (String) session.getAttribute("sId"); 
		//db에 거래결과 저장
		Map<String, Object> chargeResult = bankService.getDBTransactionResult(bank_tran_id);
		model.addAttribute("chargeResult", chargeResult);
		
		//페이 테이블에서 잔액 가져오기 
		int payBalance = fundizzyService.getPayBalanceInt(email);
		System.out.println("payBalance" + payBalance);
		model.addAttribute("payBalance", payBalance);
		
		return "myPage/supporter/pay_transfer_result";
	}
	
	//파일 업로드를 위한 메서드
	private String getRealPath(HttpSession session, String virturalPath) {
		return session.getServletContext().getRealPath(virturalPath);
	}
	
	//파일 업데이트를 위한 메서
	private void updateFile(MultipartFile img, String realPath, String imgName) {
		try {
			MultipartFile mFile = img;
			
			
			if(!mFile.getOriginalFilename().equals("")) {
				mFile.transferTo(new File(realPath,imgName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
