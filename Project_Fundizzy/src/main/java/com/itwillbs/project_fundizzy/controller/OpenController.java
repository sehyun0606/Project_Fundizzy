package com.itwillbs.project_fundizzy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		// keep 전체 개수
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
	public String openBoardNew(String project_code, HttpSession session, Model model) {
		String email = (String)session.getAttribute("sId");
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		// *새소식 리스트 가져오기 
		List<Map<String, Object>> newsList = fundService.getNews(project_code);
		System.out.println("뉴스리스트 - " + newsList);
		model.addAttribute("newsList", newsList); //ok
		
		//리워드 테이블 가져오기
		List<Map<String, Object>> reward = fundService.getReward(project_code);
		System.out.println("map = " + reward);
		model.addAttribute("reward", reward);
		
		//찜테이블 가져오기
		Map<String, String> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		
		// keep 전체 개수
		int keepCount = openService.getKeepCount(project_code);
		model.addAttribute("keepCount", keepCount);
		
		//fund-history table 가져오기 - 구매자 수 출력 
		int fundHistory = fundService.getFundHistoryCount(project_code);
		model.addAttribute("fundHistory", fundHistory);
		
		return "merch/open/open_board_new";
	}
//	@GetMapping("OpenBoardNewBoard")
//	public String openBoardNewBoard() {
//		return "merch/open/open_board_new_board";
//	}
	@GetMapping("OpenBoardSupport")
	public String openBoardSupport(@RequestParam Map<String, Object> map, String project_code, Model model, HttpSession session) {
		String email = (String)session.getAttribute("sId");
		
		//펀드 보드 가져오기 
		Map<String, Object> fundStory = fundService.getFundBoard(project_code);
		System.out.println("map == " + fundStory); // ok
		model.addAttribute("fundStory", fundStory); //ok
		
		// *지지서명 가져오기 
		List<Map<String, Object>> supportList = fundService.getSupportList(project_code);
		model.addAttribute("supportList", supportList);
		System.out.println("supportList ======== " + supportList);
		
		// * 댓글 목록 조회 기능 
		List<Map<String, Object>> ReplyList = fundService.getReplyList(map);
		System.out.println("Reply LIst = " + ReplyList);
		model.addAttribute("ReplyList", ReplyList);
		
		//찜테이블 가져오기
		Map<String, String> keep = fundService.getKeep(email,project_code); 
		model.addAttribute("keep", keep);
		
		// keep 전체 개수
		int keepCount = openService.getKeepCount(project_code);
		model.addAttribute("keepCount", keepCount);
		
		//fund-history table 가져오기 - 구매자 수 출력 
		int fundHistory = fundService.getFundHistoryCount(project_code);
		model.addAttribute("fundHistory", fundHistory);
		
		return "merch/open/open_board_support";
	}
	
	//지지서명 등록 
	@PostMapping("SupportSignatureOpen")
	public String supportSignature(@RequestParam Map<String, String> map, Model model, String project_code) {
		
		String supportKeyword = "";
		if("on".equals(map.get("like"))) {
			supportKeyword += 1;
		}
		if("on".equals(map.get("life"))) {
			supportKeyword += 2;
			
		}
		if("on".equals(map.get("useful"))) {
			supportKeyword += 3;
			
		}
		if("on".equals(map.get("littleMoney"))) {
			supportKeyword += 4;
			
		}
		if("on".equals(map.get("cheerup"))) {
			supportKeyword += 5;
			
		}
		
		//지지서명시 필요한 값 들고오기
		String email = map.get("email");
		String supportContent = map.get("support_content");
		
		//지지서명 등록
		fundService.getSupportSignature(project_code, email, supportContent, supportKeyword);
		
		return "redirect:/OpenBoardSupport?project_code=" + project_code;
	}
	
	//fund 지지서명 - 댓글 작성 기능 
	@PostMapping("SupportReplyOpen")
	public String supportReply(@RequestParam Map<String, Object> map, HttpSession session, Model model, String project_code,
			HttpServletRequest request, String support_num) {
		
		//지지서명 출력 
//			List<Map<String, Object>> supportList = fundService.getSupportList();
		
		//댓글 테이블 출력 
		List<Map<String, Object>> ReplyList = fundService.getReplyList(map);
		System.out.println("Reply LIst = " + ReplyList);
		
		//세션에 있는 아이디 저장 
		String maker_email = (String) session.getAttribute("sId");
		System.out.println("makerEmail = " + maker_email);
		
		//map에 아이디 및 ip 저장
		map.put("maker_email", maker_email);
		map.put("reply_writer_ip", getClientIp(request));
		
		//댓글 db에 등록 
		int count = fundService.registSupportReply(map);
		
		if(count > 0) {
			System.out.println("insert 성공!!!!!!!!!!");
//				model.addAttribute("supportList", supportList);
		}
		return "redirect:/OpenBoardSupport?project_code=" + project_code;
	}

	// -- 유틸리티 메서드 --
	// ip 가져오기
	private String getClientIp(HttpServletRequest request) {
		String ipAddress = request.getRemoteAddr();
		System.out.println( "ip값 === " + ipAddress);
		if(ipAddress .equals("0:0:0:0:0:0:0:1")) {
			ipAddress = "127.0.0.1";
		}
		
		return ipAddress;
	}

}
