package com.itwillbs.project_fundizzy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project_fundizzy.service.ProjectMakerService;
import com.itwillbs.project_fundizzy.vo.MakerInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Controller
public class ProjectMakerController {
	
	@Autowired
	private ProjectMakerService projectMakerService;
	
	private String virtualPath = "/resources/upload/";
	
	@GetMapping("ProjectMaker")
	public String projectMaker(HttpSession session, Model model) {
		String project_code = (String) session.getAttribute("project_code");
		
		Map<String, String> projectSetting = projectMakerService.getSettingInfo(project_code);
		
		model.addAttribute("projectSetting", projectSetting);
		
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
	
	//서비스 요금 선택
	@GetMapping("ProjectPlan")
	public String projectPlan(HttpSession session, Model model) {
		
		String projectCode = (String) session.getAttribute("project_code");
		
		String serviceType = projectMakerService.getServiceType(projectCode);
		
		model.addAttribute("serviceType", serviceType);
		
		return "project/projectMaker/project_plan";
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
	
	
	//프로젝트 정보 입력 폼
	@GetMapping("ProjectInfo")
	public String projectInfo() {
		return "project/projectMaker/project_info";
	}
	
	
	//프로젝트 정보 업로드
	@PostMapping("ProjectInfo")
	public String registProjcetInfo(ProjectInfoVO projectInfo, HttpSession session, Model model) {
		
		String projectCode = projectInfo.getProject_code();
		String realPath = getRealPath(session, virtualPath);
		//파일 업로드되는 서브 경로
		String subDir = projectCode + "/registrationCard" ;
		
		realPath += subDir;
		
		//실제 파일 업로드 경로 생성
		try {
			Path path = Paths.get(realPath);
			Files.createDirectory(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile registrationCardImg = projectInfo.getRegistrationCard();
		
		projectInfo.setRegistration_card("");
		
		String registrationCardName = "";
		
		if(!registrationCardImg.getOriginalFilename().equals("")) {
			registrationCardName = UUID.randomUUID().toString() + "_" + registrationCardImg.getOriginalFilename();
			projectInfo.setRegistration_card(subDir + "/" + registrationCardName);
		}
		projectMakerService.registProjectInfo(projectInfo);
		
		try {
			if(!registrationCardImg.getOriginalFilename().equals("")) {
				registrationCardImg.transferTo(new File(realPath,registrationCardName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/ProjectMaker";
	}
	
	@GetMapping("ProjcetInfoEdit")
	public String projcetInfoEdit(HttpSession session, Model model) {
		
		String project_code = (String)session.getAttribute("projcet_code");
		
		ProjectInfoVO projectInfo = projectMakerService.getProjectinfo(project_code);
		
		model.addAttribute("projectInfo", projectInfo);
		
		return "project/projectMaker/project_maker_edit";
	}
	
	
	
	@GetMapping("ProjectStory")
	public String projectStory(){
		
		return "project/projectMaker/project_story";
	}
	
	//리워드 설정 페이지
	@GetMapping("ProjectReward")
	public String projectReward(HttpSession session, Model model) {
		
		String projectCode =  (String)session.getAttribute("project_code");
		
		List<RewardVO> rewardList = projectMakerService.getReward(projectCode);
		
		model.addAttribute("rewardList", rewardList);
		
		return "project/projectMaker/project_reward";
	}
	
	//리워드 저장하기
	@PostMapping("ProjectReward")
	public String registReward(RewardVO reward, HttpSession session) {
		
		String projectCode =  (String)session.getAttribute("project_code");
		
		reward.setProject_code(projectCode);
		
		
		projectMakerService.registReward(reward);
		
		
		return "redirect:/ProjectReward";
	}
	
	
	@GetMapping("MakerInfo")
	public String makerInfo() {
		return "project/projectMaker/maker_info";
	}
	
	//메이커 정보 저장
	@PostMapping("MakerInfo")
	public String submitMakerInfo(MakerInfoVO makerInfo, HttpSession session) {
		String projectCode = makerInfo.getProject_code();
		String realPath = getRealPath(session, virtualPath);
		//파일 업로드되는 서브 경로
		String subDir = projectCode + "/MakerProfile" ;
		
		realPath += subDir;
		
		//실제 파일 업로드 경로 생성
		try {
			Path path = Paths.get(realPath);
			Files.createDirectory(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile registrationCardImg = makerInfo.getProfileImg();
		
		makerInfo.setProfile_img("");
		
		String registrationCardName = "";
		
		if(!registrationCardImg.getOriginalFilename().equals("")) {
			registrationCardName = UUID.randomUUID().toString() + "_" + registrationCardImg.getOriginalFilename();
			makerInfo.setProfile_img(subDir + "/" + registrationCardName);
		}
		projectMakerService.registMakerInfo(makerInfo);
		
		try {
			if(!registrationCardImg.getOriginalFilename().equals("")) {
				registrationCardImg.transferTo(new File(realPath,registrationCardName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/ProjectMaker";
	}
	
	//메이커 정보 수정 폼
	@GetMapping("MakerInfoEdit")
	public String makerInfoEdit(HttpSession session,Model model) {
		
		String projectCode = (String)session.getAttribute("project_code");
		
		MakerInfoVO makerInfo = projectMakerService.getMakerInfo(projectCode);
		
		model.addAttribute("makerInfo", makerInfo);
		
		return "project/projectMaker/maker_info_edit";
	}
	
	
	
	
	//파일 업로드 및 다운로드를 위한 유틸리티 메서드
	//파일 업로드에 사용될 실제 업로드 디렉토리 경로를 리턴하는 메서드
	private String getRealPath(HttpSession session, String virturalPath) {
		return session.getServletContext().getRealPath(virturalPath);
	}
}
