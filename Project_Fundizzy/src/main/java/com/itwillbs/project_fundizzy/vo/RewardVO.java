package com.itwillbs.project_fundizzy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RewardVO {
	private String project_code;
	private int reward_code;
	private String product_name;
	private String product_desc;
	private int price;
	private int product_limit;
	private int delivery_fee;
	
}
