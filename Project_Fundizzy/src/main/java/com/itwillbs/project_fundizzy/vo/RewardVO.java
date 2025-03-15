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
	
	// 결제시 해당 리워드선택 개수 저장을 위한 변수
	private int product_count;
	
}
