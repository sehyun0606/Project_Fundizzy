package com.itwillbs.project_fundizzy.vo;

import lombok.Data;

@Data
public class KakaoToken {
	private String access_token;
    private String token_type;
    private String refresh_token;
    private String expires_in;
    private String scope;
    private String refresh_token_expires_in;
}
