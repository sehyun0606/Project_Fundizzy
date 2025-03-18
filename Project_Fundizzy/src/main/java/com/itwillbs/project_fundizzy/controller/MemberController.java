package com.itwillbs.project_fundizzy.controller;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.handler.GenerateRandomCode;
import com.itwillbs.project_fundizzy.handler.KakaoApiClient;
import com.itwillbs.project_fundizzy.service.Bankservice;
import com.itwillbs.project_fundizzy.service.LoginService;
import com.itwillbs.project_fundizzy.service.MailService;
import com.itwillbs.project_fundizzy.service.MemberService;
import com.itwillbs.project_fundizzy.vo.BankToken;
import com.itwillbs.project_fundizzy.vo.KakaoToken;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	@Autowired
	private Bankservice bankservice;
	@Autowired
	private LoginService loginService;
	
	
	@Value("${kakao.api_key}")
	private String kakaoClientId;

	@Value("${kakao.redirect_url}")
	private String kakaoRedirectUrl;
	
	@Value("${naver.client_id}")
	private String naverClientId;

	@Value("${naver.client_secret}")
	private String naverClientSecret;
	
	@Value("${naver.redirect_url}")
	private String naverRedirectUrl;
	
	// 로그인 폼으로 이동
	@GetMapping("Login")
	public String Login(HttpSession session, Model model) {
		
		if(session.getAttribute("sId") != null) {
			return "main";
		}
		
		String state = UUID.randomUUID().toString().substring(0, 8);
//		System.out.println(state);
		
		model.addAttribute("state", state);
		model.addAttribute("kakaoClientId", kakaoClientId);
		model.addAttribute("kakaoRedirectUrl", kakaoRedirectUrl);
		model.addAttribute("naverClientId", naverClientId);
		model.addAttribute("naverClientSecret", naverClientSecret);
		model.addAttribute("naverRedirectUrl", naverRedirectUrl);
		
		return "member/login/login_form";
	}
	
	// 카카오 콜백
	@GetMapping("kakaoCallback")
	public String kakaoLogin(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		System.out.println("응답결과 : " + authResponse);
		System.out.println("code : " + authResponse.get("code"));
		
		// 2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged) 요청
		KakaoToken kakaoToken = loginService.getKakaoAccessToken(authResponse);
		log.info(">>>>>> 엑세스토큰 정보 : " + kakaoToken);
		
		if(kakaoToken == null || kakaoToken.getAccess_token() == null) {
			model.addAttribute("msg", "토큰 발급 실패! 다시 인증을 수행해 주세요.");
			return "result/success";
		}
		
		// 카카오 엑세스 토큰으로 유저 정보 가져오기
		Map<String, Object> kakaoUserInfo = loginService.getKakaoUserInfo(kakaoToken.getAccess_token());
		System.out.println("가져온 사용자 정보 : " + kakaoUserInfo);

		// 사용자 정보에서 필요한 값 추출
        String nickname = (String) ((Map<String, Object>) kakaoUserInfo.get("properties")).get("nickname");
        String email = (String) ((Map<String, Object>) kakaoUserInfo.get("kakao_account")).get("email");
        String profile = memberService.getProfileImg(email);
        System.out.println("닉네임 : " + nickname + " 이메일 : " + email);
        
        // DB에서 유저 정보 가져오기
        Map<String, String> DBKakaoUser = memberService.getDBKakaoUser(email);
        System.out.println("가져온 정보 : " + DBKakaoUser);
        if(DBKakaoUser == null) {
        	memberService.insertKakaoUser(nickname, email);
        }
        // DB에서 유저 정보 다시한번 더 가져오기
        Map<String, String> DBKakaoUserInfo = memberService.getDBKakaoUserInfo(email);
        
        session.setAttribute("DBKakaoUserInfo", DBKakaoUserInfo);
		session.setAttribute("sId", email);
		session.setAttribute("profileImg", profile);
        session.setAttribute("loginType", "kakao");
        
        // Model 객체에 사용자 정보를 추가하여 JSP로 전달
        model.addAttribute("targetURL", "./");
        model.addAttribute("isClose", true);
        
		return "result/success";
	}
	
	@GetMapping("NaverCallback")
	public String NaverCallback(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		System.out.println("응답결과 : " + authResponse);
		 Map<String, String> naverToken = loginService.getNaverAccessToken(authResponse);
		System.out.println("네이버 토큰 가져온 정보 : " + naverToken);
		
		if(naverToken == null || naverToken.get("access_token") == null) {
			model.addAttribute("msg", "토큰 발급 실패! 다시 인증을 수행해 주세요.");
			return "result/success";
		}
		
		// 네이버 엑세스 토큰으로 유저 정보 가져오기
		Map<String, Object> naverUserInfo = loginService.getNaverUserInfo(naverToken.get("access_token"));
		System.out.println("가져온 유저 정보 : " + naverUserInfo);
		
		String email = (String) ((Map<String, Object>) naverUserInfo.get("response")).get("email");
		String nickname = (String) ((Map<String, Object>) naverUserInfo.get("response")).get("nickname");
		String profile = memberService.getProfileImg(email);
		System.out.println("email: " + email + " nickname: " + nickname);
		
		// DB에서 유저 정보 가져오기
        Map<String, String> DBNaverUser = memberService.getDBNaverUser(email);
        System.out.println("가져온 정보 : " + DBNaverUser);
        if(DBNaverUser == null) {
        	memberService.insertNaverUser(nickname, email);
        }
        // DB에서 유저 정보 다시한번 더 가져오기
        Map<String, String> DBNaverUserInfo = memberService.getDBNaverUserInfo(email);
        System.out.println("한번 더 가져온 정보 : " + DBNaverUserInfo);
        
        session.setAttribute("DBNaverUserInfo", DBNaverUserInfo);
		session.setAttribute("sId", email);
		session.setAttribute("profileImg", profile);
        session.setAttribute("loginType", "naver");
        
        // Model 객체에 사용자 정보를 추가하여 JSP로 전달
        model.addAttribute("targetURL", "./");
        model.addAttribute("isClose", true);
		return "result/success";
	}
	
	
	
	
	
	
	
	// 회원가입 페이지 이동
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
	
		// 로그인 비즈니스 로직
		@PostMapping("LoginSuccess")
		public String LoginSuccess(
				@RequestParam Map<String, String> loginInfo,
				String rememberId,
				HttpSession session,
				Model model,
				BCryptPasswordEncoder bpe,
				HttpServletResponse response) {
			
//			System.out.println("넘어온 로그인 정보 : " + loginInfo);

			Map<String, String> dbMember = memberService.getMember(loginInfo.get("email"));
			System.out.println("DB에 저장되어있는 멤버 정보 : " + dbMember);
			
			if(dbMember == null) { 
				model.addAttribute("msg", "회원 정보가 없습니다!");
				return "result/result";
				
			} else if(!bpe.matches(loginInfo.get("password"), dbMember.get("passwd"))) {
				model.addAttribute("msg", "로그인 실패!");
				return "result/result";
				
			} else if(dbMember.get("member_status").equals("2")) { 
				model.addAttribute("msg", "탈퇴한 회원입니다!");
				return "result/result";
				
			} else {
				session.setAttribute("sId", dbMember.get("email"));
				session.setAttribute("profileImg", dbMember.get("profile"));
				session.setAttribute("loginType", "local");
				session.setMaxInactiveInterval(5000000);
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
				
				session.setAttribute("member", dbMember);
				
				return "redirect:/";
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
			
			return "redirect:/";
		}
		
		// 아이디 찾기 페이지 이동
		@GetMapping("FindEmail")
		public String FindEmail() {
			return "member/login/find_email";
		}
		
		// 비밀번호 찾기 페이지 이동
		@GetMapping("FindPasswd")
		public String FindPasswd() {
			return "member/login/find_passwd";
		}
		
		@GetMapping("ActionFindEmail")
		public String ActionFindEmail(String email, Model model) {
			// DB 정보조회
			Map<String, String> DBInfo = memberService.getMember(email);
			System.out.println("가져온 정보 : " + DBInfo);
			
			model.addAttribute("DBInfo", DBInfo);
			model.addAttribute("email", email);
			
			return "member/login/find_success_email";
		}
		
		
		@ResponseBody
		@PostMapping("ActionFindPasswd")
		public String ActionFindPasswd(String email) {
			System.out.println("ajax로 받아온 거 " + email);
			
			Map<String, String> info = memberService.getMember(email);
			System.out.println("db에서 받아온 거 " + info);
			
			if(info != null) {
				Map<String, String> passwdMail = mailService.sendPasswdMail(info);
				System.out.println("메일 : " + passwdMail);
				
				return new Gson().toJson(passwdMail);
			}
			return new Gson().toJson(null);
		}
		
		@GetMapping("PasswdUpdate")
		public String PasswdUpdate() {
			return "member/login/passwd_update";
		}
		
		@GetMapping("resetPasswordProcess")
		public String resetPasswordProcess(@RequestParam Map<String, String> map, BCryptPasswordEncoder bpe, Model model) {
			System.out.println("넘어온 것 : " + map );
			
			String securedPasswd = bpe.encode(map.get("password"));
			System.out.println("평문 : " + map.get("password"));
			System.out.println("암호문 : " + securedPasswd);
			
			map.put("password", securedPasswd);
			
			int updateCount = memberService.updatePassword(map);
			if(updateCount > 0) {
				return "member/login/passwd_update_success";
			}
			
			model.addAttribute("msg", "비밀번호 변경 실패!\n다시 시도해 주세요.");
			return "result/result";
		}
		
		
		
		
		
		
		
		
		
		
		// 메일 발송 페이지 확인용
//		@GetMapping("testMailJSP")
//		public String testMailJSP() {
//			return "member/mail/mail";
//		}
	
		
}
