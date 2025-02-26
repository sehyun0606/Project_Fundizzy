package com.itwillbs.project_fundizzy.controller;

import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.service.ProjectMakerService;

@Controller
public class ProjectMakerController {
	
	@Autowired
	private ProjectMakerService projectMakerService;
	
	@GetMapping("ProjectMaker")
	public String projectMaker() {
		
		return "project/projectMaker/project_maker_home";
	}
	
	//프로젝트 생성
	//전달받은 파라미터: 아이디,공통코드
	@PostMapping("MakeProject")
	public String makeProject(@RequestParam Map<String,Object> map,Model model) {
		
		//프로젝트 번호 생성(난수)
		Random r = new Random();
		int rNum = r.nextInt(1000000);
		map.put("project_num", rNum);
		//공통코드 및 프로젝트 코드 작업
		String common_code = (String) map.get("common_code");
		String projcet_code = rNum + common_code;
		map.put("project_code", rNum + projcet_code);
		
		//insert
		projectMakerService.makeNewProject(map);
		
		System.out.println(map);
		
		return "redirect:/MakerPage";
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
