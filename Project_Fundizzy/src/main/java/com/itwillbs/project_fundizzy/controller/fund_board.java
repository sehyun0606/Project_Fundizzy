package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

//정유나
@Controller
public class fund_board {
	
	@GetMapping("FundList")
	public String fundList() {
		return "fund_board/fund_list";
	}
	@GetMapping("FundBoardStory")
	public String fundBoardStory() {
		return "fund_board/fund_board_story";
	}
	@GetMapping("FundBoardNew")
	public String fundBoardNew() {
		return "fund_board/fund_board_new";
	}
	@GetMapping("FundBoardNewBoard")
	public String fundBoardNewBoard() {
		return "fund_board/fund_board_new_board";
	}

}
