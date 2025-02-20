package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class PreOrderController {
	
	@GetMapping("PreOrderList")
	public String preOrderList() {
		return "merch/preOrder/preOrder_list";
	}
	@GetMapping("PreOrderBoardStory")
	public String preOrderBoardStory() {
		return "merch/preOrder/preOrder_board_story";
	}
	@GetMapping("PreOrderBoardNew")
	public String preOrderBoardNew() {
		return "merch/preOrder/preOrder_board_new";
	}
	@GetMapping("PreOrderBoardNewBoard")
	public String preOrderBoardNewBoard() {
		return "merch/preOrder/preOrder_board_new_board";
	}
	@GetMapping("PreOrderBoardSupport")
	public String preOrderBoardSupport() {
		return "merch/preOrder/preOrder_board_support";
	}
	@GetMapping("PreOrderBoardSupporter")
	public String PreOrderBoardSupporter() {
		return "merch/preOrder/preOrder_board_supporter";
	}
	@GetMapping("PreOrderBoardRefund")
	public String preOrderBoardRepreOrder() {
		return "merch/preOrder/preOrder_board_refund";
	}
	@GetMapping("PreOrderBoardReward")
	public String preOrderBoardReward() {
		return "merch/preOrder/preOrder_board_reward";
	}

}
