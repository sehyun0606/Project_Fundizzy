package com.itwillbs.project_fundizzy.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NewsVO {
	// 새소식 VO
	private int news_code; // 새소식 코드
	private String project_code; // 프로젝트 코드
	private String member_email; // 멤버 이메일
	private String news_title; // 제목
	private String news_content; // 내용
	private Timestamp news_date; // 내용
	private String news_status; // 상태('Y' - 게시, 'N' - 임시저장, 'D' - 삭제)
}
