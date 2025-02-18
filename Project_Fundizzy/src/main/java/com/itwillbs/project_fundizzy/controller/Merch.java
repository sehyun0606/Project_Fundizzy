package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class Merch {
	
	@GetMapping("FundList")
	public String fundList() {
		return "merch/funding/fund_list";
	}
	@GetMapping("FundBoardStory")
	public String fundBoardStory() {
		return "merch/funding/fund_board_story";
	}
	@GetMapping("FundBoardNew")
	public String fundBoardNew() {
		return "merch/funding/fund_board_new";
	}
	@GetMapping("FundBoardNewBoard")
	public String fundBoardNewBoard() {
		return "merch/funding/fund_board_new_board";
	}
	@GetMapping("FundBoardSupport")
	public String fundBoardSupport() {
		return "merch/funding/fund_board_support";
	}
	@GetMapping("FundBoardSupporter")
	public String fundBoardSupporter() {
		return "merch/funding/fund_board_supporter";
	}
	@GetMapping("FundBoardRefund")
	public String fundBoardRefund() {
		return "merch/funding/fund_board_refund";
	}
	@GetMapping("FundBoardReward")
	public String fundBoardReward() {
		return "merch/funding/fund_board_reward";
	}

}
