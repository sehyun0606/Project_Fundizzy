package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectMakerController {
	
	@GetMapping("ProjectMaker")
	public String projectMaker() {
		
		return "project/projectMaker/project_maker_home";
	}
	
	@GetMapping("ProjectPlan")
	public String projectPlan() {
		return "project/projectMaker/project_plan";
	}
}
