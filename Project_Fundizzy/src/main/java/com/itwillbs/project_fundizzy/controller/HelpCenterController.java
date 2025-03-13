package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class HelpCenterController {
	@GetMapping("HelpCenter")
	public String HelpCenter() {
		
		return "helpCenter/help_main";
	}
	
	
	@GetMapping("Notice") 
	public String Notice() {
		return "helpCenter/notice/notice_main";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
