package com.itwillbs.project_fundizzy.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_fundizzy.handler.GenerateRandomCode;
import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.service.MailService;
import com.itwillbs.project_fundizzy.service.MemberService;
import com.itwillbs.project_fundizzy.vo.BankToken;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	@Autowired
	private Bankservice bankservice;
	
	
	// 로그인 폼으로 이동
	@GetMapping("Login")
	public String Login() {
		return "member/login/login_form";
	}
	
	@GetMapping("SignUp")
	public String SignUp() {
		return "member/sign_up/join_form";
	}
	
	// 회원가입 비즈니스 로직
	@PostMapping("SignUpAction")
	public String SignUpSuccess(@RequestParam Map<String, String> member, Model model, BCryptPasswordEncoder bpe) {
//		System.out.println("랜덤 코드 : " + GenerateRandomCode.getRandomCode(6).toUpperCase());
		System.out.println("회원가입 정보 : " + member);
		
		String securedPasswd = bpe.encode(member.get("password"));
		System.out.println("평문 : " + member.get("password"));
		System.out.println("암호문 : " + securedPasswd);
		
		member.put("password", securedPasswd);
		
		System.out.println("암호화된 비밀번호 : " + member.get("password"));
				
		int insertCount = 0;		
		try {
			insertCount = memberService.insertMember(member);		
		} catch (Exception e) {
			e.printStackTrace();		
		}
				
		if(insertCount > 0 ) {
			return "redirect:/SignUpSuccess?email=" + member.get("email");
		} else {
			model.addAttribute("msg", "회원가입 실패!");
			return "result/result";
		}
		
	}
	
	// 회원가입 성공 시 회원가입 완료 페이지 이동
	@GetMapping("SignUpSuccess")
	public String SignUpSuccess(String email, Model model) {
		
		String nickName = (String)memberService.getMemberNickname(email);
		
		model.addAttribute("nickName", nickName);
		
		
		return "member/sign_up/join_success";
	}
	
	// 메일 발송 비지니스 로직
	@GetMapping("sendAuthMail")
	@ResponseBody
	public String sendAuthMail(@RequestParam Map<String, String> map, Model model) {
		String responseData = "false";
		
		if(map != null) {
			// ----------------- 인증 메일 발송 작업 추가 --------------------
			// MailService - sendAuthMail() 메서드 호출하여 인증메일 발송 요청
			// => 파라미터 : MemberVO 객체   리턴타입 : MailAuthInfo(mailAuthInfo)
			Map<String, String> mailAuthInfo = mailService.sendAuthMail(map);
			System.out.println("member : " + map);
			System.out.println("인증메일 정보 : " + mailAuthInfo);
			// -------------------
			// MemberService - registMailAuthInfo() 메서드 호출하여 인증 정보 등록 요청
			// => 파라미터 : MailAuthInfo 객체   리턴타입 : void
			memberService.registMailAuthInfo(mailAuthInfo);
			responseData = "true";
			return responseData;
		} else {
			return responseData;
		}
	}
	
	// 인증코드 체크 비즈니스 로직
		@GetMapping("authCodeCheck")
		@ResponseBody
		public String authCodeCheck(@RequestParam Map<String, String> authInfo) {
			System.out.println(authInfo);
			String responseData = "";
			String CodeInfo = memberService.getAuthCode(authInfo);
			System.out.println("ajax로 넘어온 코드 " + authInfo.get("code"));
			System.out.println("DB에서 들고온 코드 " +  CodeInfo);
			try {
				if(authInfo.get("code").equals(CodeInfo)) {
					System.out.println("일치함");
					responseData = "true";
				} else {
					System.out.println("일치하지 않음");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return responseData;
		}
	
		
		@PostMapping("LoginSuccess")
		public String LoginSuccess(
				@RequestParam Map<String, String> loginInfo,
				String rememberId,
				HttpSession session,
				Model model,
				BCryptPasswordEncoder bpe,
				HttpServletResponse response) {
			
			System.out.println("넘어온 로그인 정보 : " + loginInfo);

			Map<String, String> dbMember = memberService.getMember(loginInfo.get("email"));
			System.out.println("DB에 저장되어있는 멤버 정보 : " + dbMember);
			
			if(dbMember == null) { 
				model.addAttribute("msg", "회원 정보가 없습니다!");
				return "result/result";
				
			} else if(!bpe.matches(loginInfo.get("password"), dbMember.get("passwd"))) {
				model.addAttribute("msg", "로그인 실패!");
				return "result/result";
				
			} else if(dbMember.get("member_status") == "3") { 
				return "result/result";
				
			} else {
				session.setAttribute("sId", dbMember.get("email"));
				session.setMaxInactiveInterval(1800);
				System.out.println("아이디 저장하기 체크박스값 : " + rememberId);
//				 --------- 쿠키 생성 코드 중복 제거 ----------
				// 생성/삭제 관계없이 쿠키값을 무조건 로그인 한 아이디로 설정
				Cookie cookie = new Cookie("rememberId", loginInfo.get("email"));
				
//				// 쿠키 만료기간은 저장 시 30일, 삭제 시 0 으로 설정
				if(rememberId != null) {
					cookie.setMaxAge(60 * 60 * 24 * 30);
				} else {
					cookie.setMaxAge(0);
				}
				
				response.addCookie(cookie);
				//2025-02-10 핀테크 엑세스토큰 정보 조회 후 세션에 저장하는 기능
				
				BankToken token = bankservice.getBankAccessTokenInfo(dbMember.get("email"));
				session.setAttribute("token", token);
				
				return "main";
				// ---------------------------------------------------------------------------
				// [ 특정 페이지 로그인 필수 처리 후 로그인 완료 시 원래 페이지로 이동 처리 ]
				// - 세션에 저장된 "prevURL" 속성값이 null 이 아닐 경우 해당 주소로 리다이렉트하고
				//   null 일 경우(로그인 링크 직접 클릭) 기존과 동일하게 메인페이지로 리다이렉트
//				if(session.getAttribute("prevURL") == null) {
					// 메인페이지로 리다이렉트
//					return "redirect:/";
//				}
				
				// null 이 아닐 경우 이전 요청 URL 을 리다이렉트 주소에 결합하여 리턴
				// => 주의! request.getServletPath() 메서드로 요청 주소를 가져올 경우
				//    "/요청서블릿주소" 형태이므로 "redirect:/" 문자열에서 / 제외하고 결합 필요함
//				return "redirect:" + session.getAttribute("prevURL");
			}
			
		}
	
		// 로그아웃 비즈니스 로직
		@GetMapping("MemberLogout")
		public String MemberLogout(HttpSession session) {
			
			session.invalidate();
			
			return "main";
		}
	
	
}
