package com.itwillbs.project_fundizzy.aop;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

// 핀테크 서비스 메뉴에서 엑세스토큰 체크 수행에 사용할 커스텀 어노테이션
@Retention(RUNTIME)
@Target(METHOD)
public @interface BankTokenCheck {
	// 내부 코드는 아무것도 필요없음
	// advice 에서 모든 작업을 수행하며 어노테이션은 메서드에 지정할 용도로 정의만 해두기!
}
