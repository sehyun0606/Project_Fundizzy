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
	
	
	@GetMapping("mail")
	public String mail() {
		return "member/mail/mail";
	}
	
	
	
	
	
	
	
	
	
}
