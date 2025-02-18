package com.itwillbs.project_fundizzy.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberController {
	
	@GetMapping("Login")
	public String Login() {
		return "member/login/login_form";
	}
	
	@GetMapping("SignUp")
	public String SignUp() {
		return "member/sign_up/join_form";
	}
	
	
	
	
	
	
	
	
	@PostMapping("LoginSuccess")
	public String LoginSuccess(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		
		
		
		
		
		return "";
	}
}
