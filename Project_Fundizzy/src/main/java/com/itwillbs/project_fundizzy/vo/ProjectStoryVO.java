package com.itwillbs.project_fundizzy.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectStoryVO {
	private String project_code;
	private String project_title;
	private String representative_picture;
	private String product_picture;
	private String project_content;
	private String project_story;
	private String open_story;
	private MultipartFile representativePicture;
	private MultipartFile[] productPicture;
}
