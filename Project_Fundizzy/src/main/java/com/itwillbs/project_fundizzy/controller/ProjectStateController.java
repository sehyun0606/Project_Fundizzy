package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_fundizzy.service.ProjectStateService;
import com.itwillbs.project_fundizzy.vo.NewsVO;

// 최서해
@Controller
public class ProjectStateController {
	@Autowired
	ProjectStateService stateService;
	
	@GetMapping("ProjectState")
	public String project_state() {
		return "project/projectState/project_state";
	}

	@GetMapping("SettlementInfo")
	public String settlement_info() {
		return "project/projectState/settlement_info";
	}

	@GetMapping("SettlementDetail")
	public String settlement_detail() {
		return "project/projectState/settlement_detail";
	}

	@GetMapping("ShipmentRefund")
	public String shipment_refund() {
		return "project/projectState/shipment_refund";
	}
	
	@GetMapping("NewsList")
	public String news_list(Model model, HttpSession session) {
		String maker_email = (String) session.getAttribute("sId");
		System.out.println("maker_email : " + maker_email);
		
		String project_code = (String) session.getAttribute("project_code");
		System.out.println("project_code : " + project_code);
		
		if(maker_email == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "Login");
			return "result/result";
		}
		
		List<NewsVO> newsList = stateService.getNewsList(project_code);
//		List<NewsVO> newsList = stateService.getNewsList();
		model.addAttribute("newsList", newsList);
		
		return "project/projectState/news_list";
	}

	// 새소식 폼 인서트
	@PostMapping("NewsBoard")
	public String news_board(NewsVO news, Model model, HttpSession session) {
		
		String maker_email = (String) session.getAttribute("sId");
		String project_code = (String) session.getAttribute("project_code");
		
		int insertCount;
		try {
			insertCount = stateService.registNewsBoard(news);
			if(insertCount > 0) {
				model.addAttribute("msg", "새소식이 등록되었습니다");
				model.addAttribute("targetURL", "NewsList");
				return "result/result";
//			} else {
//				model.addAttribute("msg", "새소식을 다시 등록해주세요");
//				model.addAttribute("targetURL", "NewsList");
//				return "result/result";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "새소식을 다시 등록해주세요");
			model.addAttribute("targetURL", "NewsList");
			return "result/result";
		}
		
		return "redirect:/NewsList";
	}
	
}


















