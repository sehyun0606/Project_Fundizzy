package com.itwillbs.project_fundizzy.aop;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Retention(RUNTIME)
@Target(METHOD)
public @interface LoginCheck {
	
	public static enum MemberRole {
		USER
	}

	public MemberRole memberRole();
}
