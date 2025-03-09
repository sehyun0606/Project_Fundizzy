package com.itwillbs.project_fundizzy.vo;

import lombok.Data;

@Data
public class ShipmentVO {
	private int idx;
	private String common_code;
	private String shipment_code;
	private String project_code;
	private String supporter_email;
	private String name;
	private String phone_num;
	private String address;
	private String address1;
	private String post_code;
	private String delivery_req;
	private String courier;
	private String tracking_num;
	private String shipping_date;
}
