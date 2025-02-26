package com.itwillbs.project_fundizzy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project_fundizzy.service.MypageService;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;


@Controller
public class MyPageController {
	@Autowired
	private MypageService mypageService;
	// 서포터 메인
	@GetMapping("SupporterPage")
	public String SupporterPage(Model model) {
		model.addAttribute("user","supporter");
		return "myPage/supporter/supporter_mypage";
	}
	
	// 설정 메인 - 프로필 아래 내정보설정 버튼을 통해 이동
	@GetMapping("SettingMain")
	public String SettingMain() {
		return "myPage/supporter/setting_main";
	}
	
	// 프로필 설정 - 설정메인에서 버튼을 통해 이동
	@GetMapping("ProfileSettings")
	public String ProfileSettings() {
		return "myPage/supporter/profile_settings";
	}
	
	@GetMapping("MemberInfo")
	public String memberInfo() {
		return "myPage/supporter/member_info";
	}
	
	//메이커페이지 이동
	//전달하는 파라미터: user값 maker
	//				프로젝트 리스트
	@GetMapping("MakerPage")
	public String makerPage(Model model,HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		List<ProjectListVO> projectList = mypageService.getMyProjectList(id);
		
		model.addAttribute("projectCount", projectList.size());
		model.addAttribute("projectList", projectList);
		model.addAttribute("user", "maker");
		
		return "myPage/maker/maker_mypage";
	}
	
}
