package com.itwillbs.project_fundizzy.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MakerInfoVO {
	private String project_code;
	private String member_email;
	private String maker_name;
	private String maker_email;
	private String maker_phone;
	private String facebook_address;
	private String twitter_address;
	private String instagram_address;
	private String profile_img;
	private MultipartFile profileImg;
}
