package com.itwillbs.project_fundizzy.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NotificationSetVO {
	private int idx;
	private String member_email;
	private String is_recv_notification;
	private String is_recv_by_email;
	private String is_recv_by_sms;
	private String is_recv_site;
	private String is_recv_following;
	private String is_recv_wish;
	private String is_recv_myproject;
	private String is_recv_joinproject;
}
