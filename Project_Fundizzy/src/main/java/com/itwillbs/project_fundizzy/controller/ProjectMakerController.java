package com.itwillbs.project_fundizzy.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_fundizzy.service.ProjectMakerService;

@Controller
public class ProjectMakerController {
	
	@Autowired
	private ProjectMakerService projectMakerService;
	
	
	@GetMapping("ProjectMaker")
	public String projectMaker(HttpSession session, Model model) {
		String project_code = (String) session.getAttribute("project_code");
		
		String projectSetting = projectMakerService.getProjectInfo(project_code);
		List<Character> settingList = new ArrayList<Character>();
		if(projectSetting.equals("0")) {
			System.out.println(settingList);
			model.addAttribute("settingList",settingList);
		} else {
			for(int i = 0; i < projectSetting.length(); i++) {
				char a = projectSetting.charAt(i);
				settingList.add(a);
			}
			System.out.println(settingList);
			model.addAttribute("settingList",settingList);
		}
		
		
		
		return "project/projectMaker/project_maker_home";
	}
	
	//세션에 프로젝트 코드 저장
	@PostMapping("ProjectMaker")
	public String goProjectMaker(String project_code,HttpSession session) {
		session.setAttribute("project_code", project_code);
		return "redirect:/ProjectMaker";
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
		map.put("project_code", projcet_code);
		
		//insert
		projectMakerService.makeNewProject(map);
		
		System.out.println(map);
		
		return "redirect:/MakerPage";
	}
	
	//서비스타입 고를때 실행되는 AJAX
	@ResponseBody
	@GetMapping("GetServiceType")
	public String getServiceType(String service_type, HttpSession session) {
		String project_code = (String) session.getAttribute("project_code");
		String result = "TRUE";
		projectMakerService.updateServceType(service_type, project_code);
		
		return result;
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
