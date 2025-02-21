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
	@GetMapping("ProjectInfo")
	public String projectInfo() {
		return "project/projectMaker/project_info";
	}
	@GetMapping("ProjectStory")
	public String projectStory(){
		
		return "project/projectMaker/project_story";
	}
	@GetMapping("ProjectReward")
	public String projectReward() {
		
		return "project/projectMaker/project_reward";
	}
	@GetMapping("MakerInfo")
	public String makerInfo() {
		return "project/projectMaker/maker_info";
	}
}
