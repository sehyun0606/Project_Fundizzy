package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// 최서해
@Controller
public class ProjectStateController {
	
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
	


	
}
