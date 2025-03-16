package com.itwillbs.project_fundizzy.controller;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.itwillbs.project_fundizzy.handler.BankValueGenerator;
import com.itwillbs.project_fundizzy.service.AdminSettlementService;
import com.itwillbs.project_fundizzy.vo.PageInfo;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Controller
public class AdminSettlementController {
	@Autowired
	private AdminSettlementService setService;
	
	@GetMapping("SettlementManage")
	public String settlementManage(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = setService.getSettlementListCount();
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
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		// 정산 정보 조회
		List<Map<String, Object>> settlementList = setService.getSettlementList(startRow,listLimit);
		model.addAttribute("settlementList", settlementList);
		
		
		return "admin/settlement_management/settlement_status";
	}
	
	@ResponseBody
	@GetMapping("AdminSettlementInfo")
	public Map<String, Object> settlementInfo(Model model, String project_code) {
		
		// 선정산 요청 정보 조회
		Map<String, Object> settlement = setService.getSettlementInfo(project_code);
		
		// #,### 형식으로 변환
		DecimalFormat decimalFormat = new DecimalFormat("#,###");
		String total_amount = decimalFormat.format(settlement.get("total_amount"));
		String pre_amount = decimalFormat.format(settlement.get("pre_amount"));
		String fee = decimalFormat.format(settlement.get("fee"));
		settlement.put("total_amount", total_amount);
		settlement.put("pre_amount", pre_amount);
		settlement.put("fee", fee);
		
		if(settlement.get("refund_amount") == null) {
			settlement.put("refund_amount", 0);
		}
		
		model.addAttribute("settlement", settlement);
		
		return settlement;
	}
	
	// 정산 승인
	@PostMapping("SetConfirm")
	public String setConfirm(@RequestParam Map<String, Object> map, Model model) {

		String pay_tran_id = BankValueGenerator.getTranId();
		map.put("pay_tran_id", pay_tran_id);
		
		if(map.get("pre_amount") != null && !map.get("pre_amount").equals("")) {
			String stringPreAmount = ((String) map.get("pre_amount")).replace(",", "");
			int pre_amount = Integer.parseInt(stringPreAmount);
			map.put("pay_amt", pre_amount);
		}
		
		if(map.get("final_amount") != null && !map.get("final_amount").equals("")) {
			String stringFinalAmount = ((String) map.get("final_amount")).replace(",", "");
			int final_amount = Integer.parseInt(stringFinalAmount);
			map.put("pay_amt", final_amount);
		}
		
		if(map.get("refund_amount") == null || map.get("refund_amount").equals("")) {
			map.put("refund_amount", 0);
		}
		
		System.out.println("mapppp : " + map);
		
		
		int insertCount = setService.registSettlementPay(map);
		
		if(insertCount > 0) {
			model.addAttribute("msg", "정산 요청이 승인되었습니다");
			model.addAttribute("targetURL", "SettlementManage");
			return "result/result";
		} else {
			model.addAttribute("msg", "정산 승인에 실패하였습니다\n다시 시도해주세요");
			model.addAttribute("targetURL", "SettlementManage");
			return "result/result";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
}











