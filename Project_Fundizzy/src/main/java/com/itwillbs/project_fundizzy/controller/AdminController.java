package com.itwillbs.project_fundizzy.controller;

import java.util.Map;

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
	
	@GetMapping("admin")
	public String admin() {
		
		return "admin/admin_login";
	}
	
	@PostMapping("adminLoginAction")
	public String AdminLoginAction(@RequestParam Map<String, String> admin, Model model) {
		System.out.println("넘어온 정보 : " + admin);
		
		Map<String, String> adminDBInfo = service.getAdminDBInfo(admin);
		System.out.println("리턴 된 정보 : " + adminDBInfo);
		if(adminDBInfo == null) { 
			model.addAttribute("msg", "회원 정보가 없습니다!");
			return "result/result";
		} else if(!admin.get("admin_passwd").equals(adminDBInfo.get("admin_passwd"))) {
			model.addAttribute("msg", "로그인 실패!");
			return "result/result";
		}
		
		return "redirect:/adminHome";
	}
	
	@GetMapping("adminHome")
	public String adminHome() {
		return "admin/admin_home";
	}
}
