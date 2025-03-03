package com.itwillbs.project_fundizzy.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.itwillbs.project_fundizzy.vo.BankToken;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class BankTokenCheckAspect {
	// Advice : Before Advice
	// PointCut : BankTokenCheck 커스텀 어노테이션
	@Before("@annotation(com.itwillbs.fundizzy.aop.BankTokenCheck)")
	public void tokenCheck() {
		// HttpServletRequest 객체 가져오기
		RequestAttributes attrs = RequestContextHolder.getRequestAttributes();
		if(attrs == null) {
			return;
		}
		
		HttpServletRequest request = ((ServletRequestAttributes)attrs).getRequest();
		
		// HttpSession 객체 가져오기
		HttpSession session = request.getSession();
		
		// 엑세스토큰 정보가 저장된 BankToken 객체를 세션에서 꺼내서 변수에 저장
		BankToken bankToken = (BankToken)session.getAttribute("token");
		
		// 토큰 존재 여부 판별하여 없을 경우 처리
		if(bankToken == null || bankToken.getAccess_token() == null) {
			String prevURL = request.getServletPath(); // ex) "/BankMain"
			String queryString = request.getQueryString(); // ex) null 또는 "id=hong&passwd=1234" 형식
			if(queryString != null) {
				prevURL += "?" + queryString;
			}
			
			session.setAttribute("prevURL", prevURL);
			
			throw new HttpStatusCodeException(
					HttpStatus.UNAUTHORIZED, // HTTP 상태코드로 인가받지 않은 사용자라는 의미의 코드 사용
					"계좌 연결한 회원만 접근 가능합니다!/BankMain") {};
		}
		
	}
	
}














