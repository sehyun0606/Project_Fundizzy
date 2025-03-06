package com.itwillbs.project_fundizzy.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService service;
	
	@GetMapping("adminPageLoginNoInputUser")
	public String admin(HttpSession session) {
		if(session.getAttribute("adminId") != null) {
			return "admin/home/admin_home";
		}
		return "admin/login/admin_login";
	}
	
	@PostMapping("adminLoginAction")
	public String AdminLoginAction(@RequestParam Map<String, String> admin, Model model, HttpSession session) {
//		System.out.println("넘어온 정보 : " + admin);

		// DB에 있는 어드민 아이디, 비밀번호 가져오기
		Map<String, String> adminDBInfo = service.getAdminDBInfo(admin);
//		System.out.println("리턴 된 정보 : " + adminDBInfo);
		
		if(adminDBInfo == null) { 
			model.addAttribute("msg", "회원 정보가 없습니다!");
			return "result/result";
		} else if(!admin.get("admin_passwd").equals(adminDBInfo.get("admin_passwd"))) {
			model.addAttribute("msg", "로그인 실패!");
			return "result/result";
		} 
		
		session.setAttribute("adminId", adminDBInfo.get("admin_id"));
		
		return "redirect:/adminHome";
	}
	
	@GetMapping("adminHome")
	public String adminHome(HttpSession session, Model model) {
		String adminId = (String)session.getAttribute("adminId");
		
		return "admin/home/admin_home";
	}
	
	// 로그아웃 비즈니스 로직
	@GetMapping("adminLogout")
	public String MemberLogout(HttpSession session) {
		session.invalidate();
		
		return "main";
	}
	
	// 회원, 관리자 관리 페이지
	@GetMapping("memberManage")
	public String memberManage(@RequestParam Map<String, String> member, Model model) {
		// 회원 정보 들고오기
		List<Map<String, String>> memberInfo = service.getUserInfo();
		List<Map<String, String>> recentRegDate = service.getRegDate();
		List<Map<String, String>> recentWithdrawDate = service.getWithdrawDate();
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("recentRegDate", recentRegDate);
		model.addAttribute("recentWithdrawDate", recentWithdrawDate);
		
		
		return "admin/manage/member_manage";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
