package com.itwillbs.project_fundizzy.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.stereotype.Component;

// 자바 메일 기능 사용 시 메일 서버(ex. 네이버, Gmail 등) 인증을 위한 정보를 관리하는 클래스 정의
@Component
public class MailAuthenticator extends Authenticator {
	// 내 앱 비밀번호 : bogu baxh lurz qvzx
	// 인증정보(아이디, 패스워드) 를 관리할 PasswordAuthentication 클래스 타입 멤버변수 선언
	PasswordAuthentication passwordAuthentication;
	
	// 기본 생성자 정의
	public MailAuthenticator() {
	}

	/*
	 * 인증 정보 관리 객체(PasswordAuthentication)를 외부로 리턴하는 getPasswordAuthentication() 메서드 정의
	 * => 슈퍼클래스인 Autheneticator 클래스의 getPasswordAuthentication() 메서드 오버라이딩하자!
	 */
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		passwordAuthentication = new PasswordAuthentication("limhsb77@gmail.com", "bogubaxhlurzqvzx");
		return passwordAuthentication;
	}
	
	
}













