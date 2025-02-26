package com.itwillbs.project_fundizzy.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project_fundizzy.service.ProjectMakerService;

@Controller
public class ProjectMakerController {
	
	@Autowired
	private ProjectMakerService projectMakerService;
	
	@GetMapping("ProjectMaker")
	public String projectMaker(Model model) {
		Random r = new Random();
		int rNum = r.nextInt(1000000);
		
		
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
