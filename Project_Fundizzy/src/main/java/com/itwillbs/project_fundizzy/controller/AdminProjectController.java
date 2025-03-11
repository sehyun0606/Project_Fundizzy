package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.service.AdminProjectService;
import com.itwillbs.project_fundizzy.vo.PageInfo;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Controller
public class AdminProjectController {
	
	@Autowired
	private AdminProjectService projectService;
	
	
	@GetMapping("AdminProjectStatus")
	public String adminProjectStatus(@RequestParam(defaultValue = "1") int pageNum,  Model model) {
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = projectService.getprojectListCount();
		int pageListLimit = 5;
		
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "존재하지 않는 페이지");
			model.addAttribute("targetURL","AdminNotice?pageNum=1");
			return "result/result";
		}
		PageInfo pageInfo = new PageInfo(listCount,pageListLimit,maxPage,startPage,endPage,pageNum);
		model.addAttribute("pageInfo",pageInfo);
		
		
		List<ProjectListVO> projectList = projectService.getProjectList(startRow,listLimit);
		
		model.addAttribute("projectList", projectList);
		
		return "admin/project_management/project_status";
	}
	
	//ajax를 활용하여 기본 프로젝트 정보 확인
	@ResponseBody
	@GetMapping("AdminGetProjectInfo")
	public String adminGetProjectInfo(String projectCode) {
		Map<String, Object> projectInfo = projectService.getProjectInfo(projectCode);
		Gson gson = new Gson();
		
		return gson.toJson(projectInfo);
	}
	
	//ajax를 활용하여 리워드 정보 확인
	@ResponseBody
	@GetMapping("AdminGetRewardInfo")
	public String adminGetRewardInfo(String projectCode) {
		List<RewardVO> rewardInfo = projectService.getRewardInfo(projectCode);
		Gson gson = new Gson();
		
		return gson.toJson(rewardInfo);
	}
	
	//ajax를 활용하여 판매자 정보 확인
	@ResponseBody
	@GetMapping("AdminGetMakerInfo")
	public String adminGetMakerInfo(String projectCode) {
		Map<String,Object> makerInfo = projectService.getMakerInfo(projectCode);
		Gson gson = new Gson();
		
		return gson.toJson(makerInfo);
	}
	
	@GetMapping("ProjectAccept")
	public String projectAccept(String project_code) {
		
		projectService.projectAccept(project_code);
		
		return "redirect:/AdminProjectStatus";
	}
	
	@GetMapping("ProjectDeny")
	public String projectDeny(String project_code) {
		
		projectService.projectDeny(project_code);
		
		return "redirect:/AdminProjectStatus";
	}
}










