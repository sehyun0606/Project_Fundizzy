package com.itwillbs.project_fundizzy.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_fundizzy.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
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
		Map<String, String> adminDBInfo = adminService.getAdminDBInfo(admin);
//		System.out.println("리턴 된 정보 : " + adminDBInfo);
		
		if(adminDBInfo == null) { 
			model.addAttribute("msg", "회원 정보가 없습니다!");
			return "result/result";
		} else if(!admin.get("admin_passwd").equals(adminDBInfo.get("admin_passwd"))) {
			model.addAttribute("msg", "로그인 실패!");
			return "result/result";
		} 
		
		session.setAttribute("adminName", adminDBInfo.get("admin_name"));
		
		return "redirect:/adminHome";
	}
	
	@GetMapping("adminHome")
	public String adminHome(HttpSession session, Model model) {
		String adminName = (String)session.getAttribute("adminName");
		
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
		List<Map<String, String>> memberInfo = adminService.getUserInfo();
		List<Map<String, String>> recentRegDate = adminService.getRegDate();
		List<Map<String, String>> recentWithdrawDate = adminService.getWithdrawDate();
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("recentRegDate", recentRegDate);
		model.addAttribute("recentWithdrawDate", recentWithdrawDate);
		
		
		return "admin/manage/member_manage";
	}
	
	@GetMapping("adminManage")
	public String adminManage() {
		return "admin/manage/admin_manage";
	}
	
	@ResponseBody
	@PostMapping("adminAdd")
	public String adminAdd(@RequestParam Map<String, String> admin, Model model) {
		String response = "";
		
		System.out.println("넘어온 정보 : " + admin);
		Map<String, String> adminDBInfo = adminService.getAdminDBInfo(admin);
//		System.out.println("넘어온 정보 : " + adminDBInfo);
		if(adminDBInfo == null) {
			int count = adminService.insertAdminInfo(admin);
			if(count > 0) {
				response = "true";
				return response;
			}
		}
		return response;
	}
	
	
	@GetMapping("QnaManage")
	public String QnaManage(Model model) {
		List<Map<String, String>> unanswerQnaList = adminService.getUnansweredQnaList();
		System.out.println("미답변 문의사항 : " + unanswerQnaList);
		List<Map<String, String>> answerQnaList = adminService.getAnsweredQnaList();
		System.out.println("답변 문의사항 : " + answerQnaList);
		List<Map<String, String>> qnaList = adminService.getQnaList();
		
		
		model.addAttribute("unanswerQnaList", unanswerQnaList);
		model.addAttribute("answerQnaList", answerQnaList);
		model.addAttribute("qnaList", qnaList);
		return "admin/admin_community/admin_community_qna";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
