package com.itwillbs.project_fundizzy.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectInfoVO {
	private String project_code;
	private String category;
	private String sub_category;
	private String adult_check;
	private String maker_type;
	private String registration_card;
	private String business_number;
	private String business_name;
	private String representative_name;
	private String representative_email;
	private int target_amount;
	private MultipartFile registrationCard;
}
