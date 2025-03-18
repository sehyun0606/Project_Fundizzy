package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project_fundizzy.service.FundService;
import com.itwillbs.project_fundizzy.service.HomeService;
import com.itwillbs.project_fundizzy.service.OpenService;
import com.itwillbs.project_fundizzy.vo.ProjectStoryVO;


@Controller
public class OpenController {
	@Autowired
	private OpenService openService;
	@Autowired
	private FundService fundService;
	@Autowired
	private HomeService homeService;
	
	
	// 오픈 메인페이지에 오픈예정 상품 리스트 출력
	@GetMapping("OpenList")
	public String openList(Model model) {
		
		List<Map<String, Object>> openList = openService.getOpenList();
		model.addAttribute("openList", openList);
		
		return "merch/open/open_list";
	}
	
	@GetMapping("OpenBoardStory")
	public String openBoardStory(HttpSession session, String project_code, Model model) {
		System.out.println("project_code = " + project_code);
		String email = (String) session.getAttribute("sId");
		
		// *대표이미지와 상세 이미지 가져오기 
		List<ProjectStoryVO> projectStoryList = fundService.getProjectStory(project_code);
		model.addAttribute("projectStoryList", projectStoryList); //ok
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); //ok
		model.addAttribute("fundStory", fundStory); //ok
		
//		//찜테이블 가져오기
		Map<String, String> keep = fundService.getKeep(email, project_code); 
		model.addAttribute("keep", keep);
		
		int keepCount = openService.getKeepCount(project_code);
		model.addAttribute("keepCount", keepCount);
		
		
		//fund-history table 가져오기 - 구매자 수 출력 
		int fundHistory = fundService.getFundHistoryCount(project_code);
		model.addAttribute("fundHistory", fundHistory);
		
		
		// 인기있는 프로젝트 출력을 위한 
		List<Map<String, String>> projectLikeList = homeService.getProjectLikeList();
		model.addAttribute("projectLikeList", projectLikeList);
	
		return "merch/open/open_board_story";
	}
	
	@GetMapping("OpenBoardNew")
	public String openBoardNew() {
		return "merch/open/open_board_new";
	}
//	@GetMapping("OpenBoardNewBoard")
//	public String openBoardNewBoard() {
//		return "merch/open/open_board_new_board";
//	}
	@GetMapping("OpenBoardSupport")
	public String openBoardSupport() {
		return "merch/open/open_board_support";
	}
	
	

}
