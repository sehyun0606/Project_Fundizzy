package com.itwillbs.project_fundizzy.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectDateVO {
	private String project_code;
	private Date open_start_date;
	private Date open_end_date;
	private Date project_start_date;
	private Date project_end_date;
}
