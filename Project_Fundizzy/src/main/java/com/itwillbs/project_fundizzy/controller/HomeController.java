package com.itwillbs.project_fundizzy.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.itwillbs.project_fundizzy.aop.LoginCheck;
import com.itwillbs.project_fundizzy.service.HomeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired 
	private HomeService homeService;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping("/")
	public String home(Model model) {
		List<Map<String, String>> categoryList =  homeService.getCategory();
		System.out.println("카테고리 리스트 : " + categoryList);
		List<Map<String, String>> projectList = homeService.getProjectList();
		System.out.println("프로젝트 리스트 : " + projectList);
		List<Map<String, String>> projectLikeList = homeService.getProjectLikeList();
		List<Map<String, String>> projectRandomList = homeService.getProjectRandomList();
		List<Map<String, String>> projectProgressList = homeService.getProjectProgressList();
		
		
		
		
		
		model.addAttribute("category", categoryList);
		model.addAttribute("projectList", projectList);
		model.addAttribute("projectLikeList", projectLikeList);
		model.addAttribute("projectRandomList", projectRandomList);
		model.addAttribute("projectProgressList", projectProgressList);
		
		return "main";
	}
}
