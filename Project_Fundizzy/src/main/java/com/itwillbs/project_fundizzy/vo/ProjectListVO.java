package com.itwillbs.project_fundizzy.vo;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectListVO {
	private int project_num;
	private String common_code;
	private String project_code;
	private String member_email;
	private String service_type;
	private int project_like;
	private Timestamp project_date;
	private String approve_stat;
	private Timestamp request_approve_date;
	private Timestamp approved_date;
	private String project_title;
	private String representative_picture;
	private int progress;
	private String service_config;
	private String project_info_config;
	private String story_config;
	private String reward_config;
	private String maker_config;
	private String settlement_status;
	private String date_config;
}
