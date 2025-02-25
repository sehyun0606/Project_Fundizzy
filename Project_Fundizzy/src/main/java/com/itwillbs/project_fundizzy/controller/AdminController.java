package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AdminController {
	
	@GetMapping("admin")
	public String admin() {
		
		return "admin/admin_login";
	}
	
	@PostMapping("adminLoginAction")
	public String AdminLoginAction() {
		
		return "redirect:/adminHome";
	}
	
	@GetMapping("adminHome")
	public String adminHome() {
		return "admin/admin_home";
	}
}
