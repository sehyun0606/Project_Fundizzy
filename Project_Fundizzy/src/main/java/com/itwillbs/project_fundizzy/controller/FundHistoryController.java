package com.itwillbs.project_fundizzy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
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

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.service.FundHistoryService;
import com.itwillbs.project_fundizzy.vo.FundHistoryVO;
import com.itwillbs.project_fundizzy.vo.PageInfo;
import com.itwillbs.project_fundizzy.vo.RefundVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Controller
public class FundHistoryController {
	
	@Autowired
	private FundHistoryService historyService;
	
	private String virtualPath = "/resources/upload/";
	
	@GetMapping("FundHistory")
	public String fundHistory(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
		
		
		
		String member_email = (String) session.getAttribute("sId");
		
		int listLimit = 3;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = historyService.getFundHistoryListCount(member_email);
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
		
		List<FundHistoryVO> fundList = historyService.getFundList(startRow,listLimit, member_email);
		model.addAttribute("fundList", fundList);
		
		return "myPage/supporter/my_fund";
	}
	
	@GetMapping("GetFundInfo")
	@ResponseBody
	public String getFundInfo(String fund_idx) {
		
		FundHistoryVO history = historyService.getFundInfo(fund_idx);
		Gson gson = new Gson();
		
		return gson.toJson(history);
	}
	
	@PostMapping("RefundReqeust")
	public String refundRequest(HttpSession session, RefundVO refund) {
		//프로젝트 번호 생성(난수)
		Random r = new Random();
		int rNum = r.nextInt(1000000);
		
		System.out.println(refund.getProduct_name());
		
		String refundCode = "" + rNum;
		refund.setRefund_code(rNum);
		String realPath = getRealPath(session, virtualPath);
		//파일 업로드되는 서브 경로
		String subDir = refundCode ;
		
		realPath += subDir;
		
		//실제 파일 업로드 경로 생성
		try {
			Path path = Paths.get(realPath);
			Files.createDirectory(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile refundImg = refund.getRefundImg();
		
		refund.setRefund_img("");
		
		String refundImgName = "";
		
		if(!refundImg.getOriginalFilename().equals("")) {
			refundImgName = UUID.randomUUID().toString() + "_" + refundImg.getOriginalFilename();
			refund.setRefund_img(subDir + "/" + refundImgName);
		}
		historyService.registRefund(refund);
		
		try {
			if(!refundImg.getOriginalFilename().equals("")) {
				refundImg.transferTo(new File(realPath,refundImgName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/FundHistory";
	}
	
	//파일 업로드 및 다운로드를 위한 유틸리티 메서드
	//파일 업로드에 사용될 실제 업로드 디렉토리 경로를 리턴하는 메서드
	private String getRealPath(HttpSession session, String virturalPath) {
		return session.getServletContext().getRealPath(virturalPath);
	}
	
	//업로드된 파일을 업데이트하는 메서드
	private void updateFile(MultipartFile img, String realPath, String imgName) {
		try {
			MultipartFile mFile = img;
			
			
			if(!mFile.getOriginalFilename().equals("")) {
				mFile.transferTo(new File(realPath,imgName));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
