package com.itwillbs.project_fundizzy.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
@Aspect
public class LoginCheckAspect {
	@Before("@annotation(com.itwillbs.project_fundizzy.aop.LoginCheck) && @annotation(loginCheck)")
	public void loginCheck(LoginCheck loginCheck) {
		System.out.println("어노테이션 파라미터 : " + loginCheck);
		
		RequestAttributes attrs = RequestContextHolder.getRequestAttributes();
		if(attrs == null) {
			return;
		}
		
		HttpServletRequest request = ((ServletRequestAttributes)attrs).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes)attrs).getResponse();
		
		switch (loginCheck.memberRole()) {
			case USER :
				checkNotLoginUser(request);
		}
	}
	
	private void checkNotLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sId");
		System.out.println("세션 아이디 : " + id);
		
		if(id == null) {
			String prevURL = request.getServletPath(); // ex) "/BankMain"
			String queryString = request.getQueryString(); // ex) null 또는 "id=hong&passwd=1234" 형식
			if(queryString != null) {
				prevURL += "?" + queryString;
			}
			
			session.setAttribute("prevURL", prevURL);
		
			throw new HttpStatusCodeException(
					HttpStatus.UNAUTHORIZED, // HTTP 상태코드로 인가받지 않은 사용자라는 의미의 코드 사용
					"회원만 이용 가능합니다!\\n로그인 페이지로 이동합니다./Login") {}; // 상태메세지 지정
		}
	}
		
}
