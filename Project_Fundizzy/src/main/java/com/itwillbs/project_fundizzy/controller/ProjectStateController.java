package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// 최서해
@Controller
public class ProjectStateController {
	
	@GetMapping("ShipmentRefund")
	public String shipmentRefund() {
		return "project/projectState/shipment_refund";
	}
	
	@GetMapping("SettlementDetail")
	public String settlementDetail() {
		return "project/projectState/settlement_detail";
	}
	
}
