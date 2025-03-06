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
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_fundizzy.service.ProjectStateService;
import com.itwillbs.project_fundizzy.vo.NewsVO;
import com.itwillbs.project_fundizzy.vo.PageInfo;

// 최서해
@Controller
public class ProjectStateController {
	@Autowired
	ProjectStateService stateService;
	
	@GetMapping("ProjectState")
	public String projectState() {
		return "project/projectState/project_state";
	}

	@GetMapping("SettlementInfo")
	public String settlementInfo() {
		return "project/projectState/settlement_info";
	}

	@GetMapping("SettlementDetail")
	public String settlementDetail() {
		return "project/projectState/settlement_detail";
	}

	@GetMapping("ShipmentRefund")
	public String shipmentRefund() {
		return "project/projectState/shipment_refund";
	}
	
	@GetMapping("NewsList")
	public String newsList(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		String maker_email = (String) session.getAttribute("sId");
		System.out.println("maker_email : " + maker_email);
		
		String project_code = (String) session.getAttribute("project_code");
		System.out.println("project_code : " + project_code);
		
		if(maker_email == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "Login");
			return "result/result";
		}
		
		// 새소식 리스트 가져오기
//		List<NewsVO> newsList = stateService.getNewsList(project_code);
//		List<NewsVO> newsList = stateService.getNewsList();
//		model.addAttribute("newsList", newsList);
		
		int listCount = stateService.getNewsListCount(project_code);
		
		//페이징 처리 메서드
		if(!pagingMethod(1, model, pageNum, 10, listCount, session)) {
			return "result/result";
		}
		
		return "project/projectState/news_list";
	}

	// 새소식 폼 인서트
	@PostMapping("NewsBoard")
	public String newsBoard(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		
		String maker_email = (String) session.getAttribute("sId");
		String project_code = (String) session.getAttribute("project_code");
		map.put("maker_email", maker_email);
		map.put("project_code", project_code);
		
		System.out.println("map: " + map);
		
		int insertCount;
		try {
			insertCount = stateService.registNewsBoard(map);
			if(insertCount > 0) {
				model.addAttribute("msg", "새소식이 등록되었습니다");
				model.addAttribute("targetURL", "NewsList");
				return "result/result";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "새소식 등록에 실패하였습니다");
			model.addAttribute("targetURL", "NewsList");
			return "result/result";
		}
		
		return "redirect:/NewsList";
	}
	
	@ResponseBody
	@GetMapping("NewsModify")
	public NewsVO getNewsCodeToModify(int news_code) {
		NewsVO news = stateService.getNews(news_code);
		return news;
	}
	
	@PostMapping("NewsModify")
	public String newsModify(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		
		int updateCount;
		try {
			updateCount = stateService.modifyNewsBoard(map);
			if(updateCount > 0) {
				model.addAttribute("msg", "새소식이 수정되었습니다");
				model.addAttribute("targetURL", "NewsList");
				return "result/result";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "새소식 수정에 실패하였습니다");
			model.addAttribute("targetURL", "NewsList");
			return "result/result";
		}
		return "redirect:/NewsList";
	}
	
	@GetMapping("NewsDelete")
	public String boardDelete(NewsVO news, @RequestParam(defaultValue = "1") String pageNum, Model model, HttpSession session) {
		String maker_email = (String)session.getAttribute("sId");
		
		if(maker_email == null) {
			model.addAttribute("msg", "접근 권한이 없습니다!");
			model.addAttribute("targetURL", "Login");
			
			return "result/result";
		}
		
//		NewsVO dbNews = stateService.getNews(news.getNews_code());
		
		
//		if(news == null || !maker_email.equals("admin") && !maker_email.equals(dbNews.getNews_code())) {
//			model.addAttribute("msg", "잘못된 접근입니다!");
//			return "result/fail";
//		}

		// 새소식 삭제
		int deleteCount = stateService.removeNews(news.getNews_code());
		
		if(deleteCount > 0) {
			return "redirect:/NewsList?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "글 삭제 실패!");
			return "result/result";
		}
	}
	
	
	
	
	// ==================== [ 페이징 메서드 ] ======================
	private Boolean pagingMethod(int index, Model model, int pageNum, int listLimit, int listCount, HttpSession session) {
		int startRow = (pageNum - 1) * listLimit; // 조회할 테이블의 DB 행 번호(= row 값)
		int pageListLimit = 3; // 한페이지당 페이지번호 수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); // 최대 페이지번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //각 페이지의 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; // 각 페이지의 마지막 페이지번호
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// url 파라미터 조작 방지
		if(pageNum < 1 || (maxPage > 0 && pageNum > maxPage)) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "NewsList?pageNum=1");
			return false;
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		String project_code = (String) session.getAttribute("project_code");
		
		// 새소식 리스트 가져오기
		List<NewsVO> newsList = stateService.getNewsList(project_code, startRow, listLimit);
		model.addAttribute("newsList", newsList);

		
		return true;
	}
	
	
	
}


















