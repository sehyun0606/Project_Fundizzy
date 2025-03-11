package com.itwillbs.project_fundizzy.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	private String profile;
	private MultipartFile profileImg;
	private String interests;
	private String introduction;
	private String phone;
	private String email;
	private String nickname;
}
