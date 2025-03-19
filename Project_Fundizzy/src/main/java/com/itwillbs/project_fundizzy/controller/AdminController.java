package com.itwillbs.project_fundizzy.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.service.AdminService;
import com.itwillbs.project_fundizzy.service.MailService;
import com.itwillbs.project_fundizzy.vo.PageInfo;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private MailService mailService;
	
	@GetMapping("adminPageLoginNoInputUser")
	public String admin(HttpSession session) {
		if(session.getAttribute("adminId") != null) {
			return "admin/home/admin_home";
		}
		return "admin/login/admin_login";
	}
	
	@PostMapping("adminLoginAction")
	public String AdminLoginAction(@RequestParam Map<String, String> admin, Model model, HttpSession session) {
//		System.out.println("넘어온 정보 : " + admin);

		// DB에 있는 어드민 아이디, 비밀번호 가져오기
		Map<String, String> adminDBInfo = adminService.getAdminDBInfo(admin);
//		System.out.println("리턴 된 정보 : " + adminDBInfo);
		
		if(adminDBInfo == null) { 
			model.addAttribute("msg", "회원 정보가 없습니다!");
			return "result/result";
		} else if(!admin.get("admin_passwd").equals(adminDBInfo.get("admin_passwd"))) {
			model.addAttribute("msg", "로그인 실패!");
			return "result/result";
		} 
		
		session.setAttribute("adminName", adminDBInfo.get("admin_name"));
		
		return "redirect:/adminHome";
	}
	
	@GetMapping("adminHome")
	public String adminHome(Model model) throws JsonProcessingException {
        List<Map<String, Object>> chartData = new ArrayList<>();

        Map<String, Object> projectStatus = new HashMap<>();
        projectStatus.put("labels", Arrays.asList("완료", "진행 중", "대기 중"));
        projectStatus.put("data", Arrays.asList(30, 50, 20));
        chartData.add(projectStatus);

        Map<String, Object> userStatus = new HashMap<>();
        userStatus.put("labels", Arrays.asList("활성 사용자", "비활성 사용자"));
        userStatus.put("data", Arrays.asList(70, 30));
        chartData.add(userStatus);

        Map<String, Object> fundingStatus = new HashMap<>();
        fundingStatus.put("labels", Arrays.asList("목표 금액", "달성 금액"));
        fundingStatus.put("data", Arrays.asList(100, 60));
        chartData.add(fundingStatus);

        Map<String, Object> userGrowth = new HashMap<>();
        userGrowth.put("labels", Arrays.asList("신규 사용자", "기존 사용자"));
        userGrowth.put("data", Arrays.asList(40, 60));
        chartData.add(userGrowth);

        // Jackson ObjectMapper를 사용하여 JSON 문자열로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String chartDataJson = objectMapper.writeValueAsString(chartData);

        // JSP로 데이터 전달
        model.addAttribute("chartDataJson", chartDataJson);

        return "admin/home/admin_home"; // admin/home.jsp로 이동
    }
	
	// 로그아웃 비즈니스 로직
	@GetMapping("adminLogout")
	public String MemberLogout(HttpSession session) {
		session.invalidate();
		
		return "main";
	}
	
	// 회원, 관리자 관리 페이지
	@GetMapping("memberManage")
	public String memberManage(@RequestParam Map<String, String> member, Model model) {
		// 회원 정보 들고오기
		List<Map<String, String>> memberInfo = adminService.getUserInfo();
		List<Map<String, String>> recentRegDate = adminService.getRegDate();
		List<Map<String, String>> recentWithdrawDate = adminService.getWithdrawDate();
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("recentRegDate", recentRegDate);
		model.addAttribute("recentWithdrawDate", recentWithdrawDate);
		
		
		return "admin/manage/member_manage";
	}
	
	@GetMapping("adminManage")
	public String adminManage() {
		return "admin/manage/admin_manage";
	}
	
	@ResponseBody
	@PostMapping("adminAdd")
	public String adminAdd(@RequestParam Map<String, String> admin, Model model) {
		String response = "";
		
		System.out.println("넘어온 정보 : " + admin);
		Map<String, String> adminDBInfo = adminService.getAdminDBInfo(admin);
//		System.out.println("넘어온 정보 : " + adminDBInfo);
		if(adminDBInfo == null) {
			int count = adminService.insertAdminInfo(admin);
			if(count > 0) {
				response = "true";
				return response;
			}
		}
		return response;
	}
	
	
	@GetMapping("QnaManage")
	public String QnaManage(Model model) {
		
		List<Map<String, String>> unanswerQnaList = adminService.getUnansweredQnaList();
		System.out.println("미답변 문의사항 : " + unanswerQnaList);
		List<Map<String, String>> answerQnaList = adminService.getAnsweredQnaList();
		System.out.println("답변 문의사항 : " + answerQnaList);
		List<Map<String, String>> qnaList = adminService.getQnaList();
//		System.out.println("모든 문의사항 : " + qnaList);
		
		
		model.addAttribute("unanswerQnaList", unanswerQnaList);
		model.addAttribute("answerQnaList", answerQnaList);
		model.addAttribute("qnaList", qnaList);
		return "admin/admin_community/admin_community_qna";
	}
	
	@ResponseBody
	@GetMapping("sendReply")
	public String sendReply(@RequestParam Map<String, String> map) {
		String result = "";
		System.out.println("ajax요청 : " + map);
		LocalDateTime now = LocalDateTime.now();
	    // 올바른 포맷 적용
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    String formattedDate = now.format(formatter);
	    System.out.println(formattedDate);
	    int updateQnaReply = adminService.updateQnaReply(map);
	    
		if(map != null) {
			map.put("dateTime", formattedDate);
			Map<String, String> sendMailInfo = mailService.sendQnaMail(map);
			System.out.println("보낸 것 : " + map);
			System.out.println("인증메일 정보 : " + sendMailInfo);
			result = "true";
			return result;
		} else {
			return result;
		}
	}
	
	@GetMapping("qnaBoardList")
	public String qnaBoardList(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {
		System.out.println("검색타입 : " + searchType);
		System.out.println("검색어 : " + searchKeyword);
//		System.out.println("페이지번호 : " + pageNum);
		
		// [ 페이징 처리 ]
		// 1. 페이징 처리를 위해 조회 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 6; // 한 페이지 당 표시할 게시물 수(임시로 3개로 지정)
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 DB 행 번호(= row 값)
		
		// 2. 실제 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업
		// 1) BoardService - getBoardListCount() 메서드 호출하여 전체 게시물 갯수 조회 요청
		//    => 파라미터 : 검색타입, 검색어   리턴타입 : int(listCount)
		int listCount = adminService.getBoardListCount(searchType, searchKeyword);
		System.out.println("전체 게시물 수 : " + listCount);
		
		// 2) 한 페이지에서 표시할 목록(페이지 당 페이지 번호) 갯수 설정
		int pageListLimit = 3; // 임시) 페이지 당 페이지 번호 갯수를 3으로 설정(1 2 3 or 4 5 6)
		
		// 3) 최대 페이지번호 계산
		//    => 전체 게시물 수(listCount)를 페이지 당 게시물 수(listLimit)로 나눔
		//       이 때, 나머지가 0보다 크면 페이지 수 + 1 추가
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 단, 최대 페이지번호가 0 일 경우 기본값으로 1 설정
		if(maxPage == 0) {
			maxPage = 1;
		}
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산(페이지 목록의 맨 앞 페이지번호)
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산(페이지 목록의 맨 뒤 페이지번호)
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호(endPage) 값이 최대 페이지 번호(maxPage) 보다 클 경우
		//    마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "BoardList?pageNum=1");
			return "result/fail";
		}
		// 3. 페이징 정보를 관리하는 PageInfo 객체 생성 및 계산 결과 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", pageInfo);
		// ------------------------------------------------------
		// BoardService - getBoardList() 메서드를 호출하여 전체 게시물 목록 조회 요청
		// => 파라미터 : 검색타입, 검색어, 시작행번호, 페이지 당 게시물 수   
		//    리턴타입 : List<BoardVO>(boardList)
		List<Map<String, Object>> qnaList = adminService.getQnaBoardList(searchType, searchKeyword, startRow, listLimit);
		
		// ------------------------------------------------------
		// 조회된 게시물 목록 정보(List 객체)를 Model 객체에 저장
		model.addAttribute("qnaList", qnaList);
		
		return "admin/admin_community/admin_community_qna";
	}
	
	
	
//	@GetMapping("mail")
//	public String mail() {
//		return "member/mail/mail";
//	}
	
	
	
	
	
	
	
	
	
}
