package com.itwillbs.project_fundizzy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.itwillbs.project_fundizzy.aop.LoginCheck;
import com.itwillbs.project_fundizzy.aop.LoginCheck.MemberRole;
import com.itwillbs.project_fundizzy.service.HelpCenterService;
import com.itwillbs.project_fundizzy.service.MemberService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class HelpCenterController {
	@Autowired
	private HelpCenterService helpCenterService;
	@Autowired
	private MemberService memberService;
	
	@GetMapping("HelpCenter")
	public String HelpCenter(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
		model.addAttribute("faqList", boardList);
		return "helpCenter/help_main";
	}
	
	
	@GetMapping("Notice") 
	public String Notice(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
		model.addAttribute("faqList", boardList);
		return "helpCenter/notice/notice_list";
	}
	
	@GetMapping("Supporter")
	public String Supporter(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
//		System.out.println("가져온 정보 : " + boardList);
		
		model.addAttribute("faqList", boardList);
		return "helpCenter/supporter/supporter_list";
	}
	
	@GetMapping("SupporterSelect")
	public String SupporterSelect(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
		model.addAttribute("faqList", boardList);
		return "helpCenter/supporter/supporter_select_list";
	}
	
	@GetMapping("Maker")
	public String Maker(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
		model.addAttribute("faqList", boardList);
		return "helpCenter/maker/maker_list";
	}
	
	@GetMapping("MakerSelect")
	public String MakerSelect(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
		model.addAttribute("faqList", boardList);
		return "helpCenter/maker/maker_select_list";
	}
	
	@GetMapping("BoardDetail")
	public String BoardDetail(Model model) {
		List<Map<String, String>> boardList = helpCenterService.getBoardList();
		model.addAttribute("faqList", boardList);
		return "helpCenter/board_detail";
	}
	
	@ResponseBody
	@GetMapping("checkLikeStatus")
	public String checkLikeStatus(@RequestParam Map<String, String> map) {
		String response = "false";
		System.out.println("ajax요청 값 : " + map);
		Map<String, String> likeStatus = helpCenterService.getUserLikeStatus(map);
		System.out.println("받아온 board_like : " +likeStatus);
		
		if(likeStatus == null) {
			return response;
		} else if(likeStatus.get("like_status").equals("Y")) {
			response = "true";
		}
		return response;
	}
	
	@LoginCheck(memberRole = MemberRole.USER)
	@ResponseBody
	@GetMapping("toggleLike")
	public String toggleLike(@RequestParam Map<String, String> map) {
	    String response = "false"; // 기본값 false 설정
	    System.out.println("ajax 요청 값 : " + map);

	    // 현재 좋아요 상태 조회
	    Map<String, String> likeStatus = helpCenterService.getUserLikeStatus(map);
	    System.out.println("결과값 : " + likeStatus);

	    // 좋아요 정보 저장을 위한 UserInfo Map 생성
	    Map<String, String> UserInfo = new HashMap<>();

	    if (likeStatus == null) {
	        // 좋아요가 처음 눌리는 경우 INSERT 실행
	        UserInfo.put("boardNum", map.get("boardNum")); 
	        UserInfo.put("UserEmail", map.get("UserEmail"));

	        int insertLikeStatus = helpCenterService.insertLikeStatus(UserInfo);
	        int updateBoardLikeCount = helpCenterService.updateBoardLike(UserInfo);
	        if (insertLikeStatus > 0 && updateBoardLikeCount > 0) {
	            response = "true";
	            return response;
	        }
	    } else {
	        // 기존에 좋아요 기록이 있는 경우 상태 변경 (Y → N or N → Y)
	        UserInfo.put("boardNum", String.valueOf(likeStatus.get("board_num")));
	        UserInfo.put("user_email", likeStatus.get("user_email"));
	        UserInfo.put("like_id", String.valueOf(likeStatus.get("like_id")));

	        int updateLikeStatus = helpCenterService.updateLikeStatus(UserInfo);
	        System.out.println("업데이트 결과 : " + updateLikeStatus);

	        if (updateLikeStatus > 0) {
	            // 변경된 좋아요 상태 다시 조회
	            Map<String, String> resultLikeStatus = helpCenterService.getUserLikeStatus(map);
	            System.out.println("최종 결과값 : " + resultLikeStatus);

	            if ("Y".equals(resultLikeStatus.get("like_status"))) {
	                response = "true";
	                return response;
	            }
	        }
	    }
	    return response;
	}
	
	@GetMapping("QnaForm")
	public String QnaForm() {
		return "helpCenter/qna/qna_form";
	}


	@GetMapping("submitQna")
	public String submitQna(@RequestParam Map<String, String> map, Model model) {
		System.out.println("제출 정보 : " + map);
		int insertQnaCount = helpCenterService.insertQna(map);
		if(insertQnaCount > 0) {
			model.addAttribute("msg", "문의글 작성 완료 되었습니다.\\n1~2일 내로 이메일로 답변 발송 됩니다.");
			model.addAttribute("targetURL", "HelpCenter");
			return "result/result";
		}
		return "helpCenter/help_main";
	}
}
