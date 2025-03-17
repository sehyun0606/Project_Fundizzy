package com.itwillbs.project_fundizzy.handler;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpStatusCodeException;

@ControllerAdvice
public class MyExceptionHandler {
	// 예외 처리를 수행하기 위한 메서드 정의
		// => 메서드 선언부 상단에 @ExceptionHandler 어노테이션 지정
		// => 기본 문법 : @ExceptionHandler(예외처리클래스명.class)
		//                public 리턴타입 메서드명(예외처리클래스명 변수명) {}
		//                => 메서드명은 무관
		//                => 리턴타입은 뷰페이지로 포워딩할 경우 String
		//                => 메서드 파라미터는 예외 발생 시 예외 객체를 전달받을 변수 선언
		// => try~catch 문에서 catch 블럭 역할을 수행함
		@ExceptionHandler(Exception.class) // 전체 예외를 하나로 묶어 처리하기 위해 Exception 클래스 지정
		public String exceptionHandler(Exception e) {
			System.out.println("exceptionHandler 메서드에서 예외 처리!");
			
			// 개발자는 콘솔에서 예외를 확인해야하므로 예외 메세지를 출력
			e.printStackTrace();
			
			// 예외 발생 시 사용자에게 응답으로 전송할 뷰페이지 지정(error_exception.jsp)
			// => 컨트롤러에서 포워딩하는 방법과 동일함
			return "result/error_exception";
		}
	// AOP 를 활용한 미로그인 체크 시 발생시킨 HttpStatusCodeException 예외 처리
		// => @ControllerAdvice 어노테이션이 적용된 예외 처리 클래스는
		//    DispatcherServlet 에 의해 관리되므로 컨트롤러와 동일한 객체 자동 주입 가능
		//    ex) HttpSession, Model 등
		// => 핸들러 메서드 파라미터로 예외 타입 클래스와 Model 타입 선언
		@ExceptionHandler(HttpStatusCodeException.class)
		public String httpStatusCodeExceptionHandler(HttpStatusCodeException e, Model model) {
//			System.out.println("httpStatusCodeExceptionHandler() 메서드에서 예외 처리!");
//			e.printStackTrace();
			// --------------------------------------------------
			// HTTP 상태코드를 판별하여 특정 코드에 따른 서로 다른 작업 수행도 가능
			// => HttpStatusCodeException 객체의 getStatusCode() 메서드를 통해 상태코드값 리턴하여 판별
//			if(e.getStatusCode() == HttpStatus.UNAUTHORIZED) { // 401
//				
//			} else if(e.getStatusCode() == HttpStatus.NOT_FOUND) { // 404
//				
//			}
			// --------------------------------------------------
			String msg = "";
			String targetURL  = "";
			String viewName  = "";
			
			// enum 타입 값 복수개 비교 시 if ~ else if 대신 switch 가 더 효율적
			switch(e.getStatusCode()) {
				// 주의! switch 문에 enum 객체 전달 시 case 문에 지정할 값은 enum 값만 지정
				// ex) HttpStatus.UNAUTHORIZED 대신 UNAUTHORIZED 만 지정
				case UNAUTHORIZED :
					// 예외 발생 시 상태메세지(e.getStatusText())로 "메세지/이동할주소" 형식으로 전달했으므로
					// "/" 기준으로 문자열 분리 후 첫번째 배열값은 msg, 두번째 배열값은 targetURL 에 저장
					String[] arrMsg = e.getStatusText().split("/");
					
					msg = arrMsg[0];
//					targetURL = "MemberLogin";
//					targetURL = arrMsg[1];
					
					// 상태 메세지 뒤에 "/요청주소" 항목이 있을 경우에만 targetURL 에 값 저장
					if(arrMsg.length == 2) {
						targetURL = arrMsg[1];
					}
					
					// 이동할 페이지(result/fail)를 viewName 변수에 저장
					viewName = "result/fail";
					break; // 지금은 생략 가능
			}
			
			// 출력할 오류메세지와 이동할 페이지를 Model 객체에 저장
			model.addAttribute("msg", msg);
			model.addAttribute("targetURL", targetURL);
			
			// 뷰페이지 리턴
			return viewName;
		}
}
