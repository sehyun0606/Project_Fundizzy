package com.itwillbs.project_fundizzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class Open {
	
	@GetMapping("OpenList")
	public String openList() {
		return "merch/open/open_list";
	}
	@GetMapping("OpenBoardStory")
	public String openBoardStory() {
		return "merch/open/open_board_story";
	}
	@GetMapping("OpenBoardNew")
	public String openBoardNew() {
		return "merch/open/open_board_new";
	}
	@GetMapping("OpenBoardNewBoard")
	public String openBoardNewBoard() {
		return "merch/open/open_board_new_board";
	}
	@GetMapping("OpenBoardSupport")
	public String openBoardSupport() {
		return "merch/open/open_board_support";
	}
	@GetMapping("OpenBoardSupporter")
	public String openBoardSupporter() {
		return "merch/open/open_board_supporter";
	}
	@GetMapping("OpenBoardRefund")
	public String openBoardReopen() {
		return "merch/open/open_board_refund";
	}
	@GetMapping("OpenBoardReward")
	public String openBoardReward() {
		return "merch/open/open_board_reward";
	}

}
