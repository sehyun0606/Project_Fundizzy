package com.itwillbs.project_fundizzy.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.handler.GenerateRandomCode;
import com.itwillbs.project_fundizzy.handler.MailClient;


@Service
public class MailService {
	@Autowired
	private MailClient mailClient;

	// 인증 메일 발송 요청 메서드
	public Map<String, String> sendAuthMail(Map<String, String> map) {
		// 인증 메일에 포함시킬 인증코드(난수) 생성
		// GenerateRandomCode 클래스의 static 메서드 getRandomCode() 메서드 호출하여 난수 요청
		// => 파라미터 : 생성할 난수 길이(정수)  리턴타입 : String(auth_code)
		String auth_code = GenerateRandomCode.getRandomCode(6).toUpperCase();
		System.out.println("생성된 인증 코드 : " + auth_code);
		// ===================================================================================
		// [ 인증 메일 발송 요청 ]
		// 인증 메일에 포함할 제목과 본문 생성
		String subject = "[Fundizzy] 이메일 인증";
		
		// 인증코드만 발송하여 사용자가 인증 페이지에서 직접 코드값을 입력해야할 경우 사용
		String content = "<a>Fundizzy 인증코드</a>" + "<br>" +  "인증코드 : " + auth_code;
		// 인증을 위한 하이퍼링크를 포함할 경우(이메일 본문에는 HTML 태그 사용 가능)
//		String url = "http://localhost:8081/mvc_board/MemberEmailAuth?email=" + member.getMember_email() + "&auth_code=" + auth_code;
//		String content = "<a href='" + url + "'>이메일 인증을 수행하려면 이 링크를 클릭하세요!</a>";
//		System.out.println("메일 본문 : " + content);
		// --------------------------------------------
		// MailClient - sendMail() 메서드(static 메서드) 호출하여 메일 발송 요청
		// => 파라미터 : 이메일 주소, 메일 제목, 메일 본문   리턴타입 : void
//		MailClient.sendMail(member.getEmail(), subject, content);
		// --------------------------------------------
		// Autowired 로 주입시킨 MailClient - sendMail() 메서드 호출하여 메일 발송 요청
//		mailClient.sendMail(member.getEmail(), subject, content);
		// 단, 메일 발송 과정에서 메일 전송 상황에 따라 시간 지연이 발생할 수 있는데
		// 이 과정에서 다음 작업이 실행되지 못하고 발송 완료 시점까지 대기하게 된다.
		// (ex. 사용자 입장에서 가입 완료 화면이 표시되지 않고 요청 화면이 그대로 유지됨)
		// 따라서, 메일 발송 작업과 나머지 작업을 별도로 분리하여 동작시키기 위해
		// 메일 발송 메서드 호출 작업을 하나의 쓰레드(Thread)로 동작시키면 별도로 분리가 가능하다!
		// 즉, 메일 발송이 완료되지 않더라도 다음 작업 진행이 가능하다!
		
		// ------------
		// Thread 클래스 인스턴스를 생성하여 1회용 쓰레드 생성하기
		// => 이 때, 파라미터로 Runnable 인터페이스의 익명 객체를 생성하고
		//    오버라이딩 된 run() 메서드 내에 멀티쓰레딩으로 처리할 코드 기술
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				// 별도의 쓰레드로 수행할 작업 => 메일 발송 코드 기술
				mailClient.sendMail(map.get("email"), subject, content);
			}
			
		}).start(); // 주의! Thread 객체의 start() 메서드 호출 필수!
		
		// ============================================================================
		// 메일 발송에 사용한 이메일주소와 인증코드 정보를 MailAuthInfo 객체에 저장 후 리턴
		Map<String, String> mailAuthInfo = new HashMap<String, String>();
		mailAuthInfo.put("email", map.get("email"));
		mailAuthInfo.put("auth_code", auth_code);
		
		return mailAuthInfo;
	}
	
	 public String renderJSPToString(HttpServletRequest request, HttpServletResponse response, String email) throws ServletException, IOException {
	        // JSP 파일에서 사용할 데이터 설정
	        request.setAttribute("email", email);

	        // JSP를 실행하고 결과를 가져오기 위한 StringWriter 생성
	        StringWriter stringWriter = new StringWriter();
	        PrintWriter writer = new PrintWriter(stringWriter);
	        
	        // JSP 렌더링을 위한 RequestDispatcher 설정
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/member/mail/mail.jsp");
	        
	        // 응답 내용을 캐치할 Custom Response Wrapper 생성
	        HttpServletResponseWrapper responseWrapper = new HttpServletResponseWrapper(response) {
	            public PrintWriter getWriter() { return writer; }
	        };

	        // JSP 실행 및 결과 저장
	        dispatcher.include(request, responseWrapper);
	        writer.flush();
	        
	        return stringWriter.toString(); // JSP의 HTML을 문자열로 반환
	    }

	public Map<String, String> sendPasswdMail(Map<String, String> info) {
		String subject = "[Fundizzy] 비밀번호 재설정 안내";
		
		// 인증코드만 발송하여 사용자가 인증 페이지에서 직접 코드값을 입력해야할 경우 사용
		String content = "<!DOCTYPE html>" +
		        "<html lang='ko'>" +
		        "<head>" +
		        "    <meta charset='UTF-8'>" +
		        "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
		        "    <title>비밀번호 재설정 안내</title>" +
		        "    <style>" +
		        "        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; text-align: center; }" +
		        "        .container { max-width: 600px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }" +
		        "        .header { background-color: #1b1b1b; padding: 30px; border-radius: 10px 10px 0 0; }" +
		        "        .header h1 { color: mediumpurple; margin: 0; }" +
		        "        .footer { font-size: 12px; color: gray; margin-top: 20px; }" +
		        "        .footer a { color: #00a8ff; text-decoration: none; }" +
		        "        .notice { font-size: 12px; color: red; margin-top: 20px; }" +
		        "    </style>" +
		        "</head>" +
		        "<body>" +
		        "    <div class='container'>" +
		        "        <div class='header'>" +
		        "           <h1>Fundizzy</h1>" +
		        "        </div>" +

		        "        <h2 style='color: black;'>비밀번호 재설정 안내</h2>" +
		        "        <p style='color: black;'>Fundizzy를 이용해 주셔서 감사합니다.</p>" +
		        "        <p style='color: black;'>고객님의 개인정보 보호를 위해 비밀번호를 재설정합니다.<br>아래 버튼을 눌러서 다시 설정해 주세요.</p>" +

		        // ✅ 버튼을 <table>을 사용하여 안정적인 스타일 적용
		        "        <table align='center' role='presentation' cellspacing='0' cellpadding='0' border='0' style='margin-top: 20px;'>" +
		        "            <tr>" +
		        "                <td align='center' bgcolor='mediumpurple' style='border-radius: 5px;'>" +
		        "                    <a href='http://localhost:8081/PasswdUpdate?email=" + info.get("email") + "'" +
		        "                       style='display: inline-block; padding: 15px 30px; font-size: 16px; font-weight: bold; color: #ffffff;" +
		        "                              text-decoration: none; background-color: mediumpurple; border-radius: 5px;'>" +
		        "                        비밀번호 등록/변경" +
		        "                    </a>" +
		        "                </td>" +
		        "            </tr>" +
		        "        </table>" +

		        "        <p class='notice'>본 메일은 비밀번호 변경을 위해 발송한 전용 메일입니다.<br>문의사항은 고객센터로 문의해주세요.</p>" +
		        "        <p class='footer'>" +
		        "            펀디즈(주) | 사업자등록번호 258-87-01370 | 대표 정세현 | 고객센터 1001-1111 | " +
		        "            이메일 <a href='mailto:info@wadiz.kr'>info@wadiz.kr</a> | " +
		        "            주소 경기 성남시 분당구 판교로 242 PDC A동 402호" +
		        "        </p>" +
		        "    </div>" +
		        "</body>" +
		        "</html>";
		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				// 별도의 쓰레드로 수행할 작업 => 메일 발송 코드 기술
				mailClient.sendMail(info.get("email"), subject, content);
			}
			
		}).start();
		
        // 메일 발송에 사용한 정보를 Map으로 반환
        Map<String, String> sendPasswdMail = new HashMap<>();
        sendPasswdMail.put("email", info.get("email"));
        return sendPasswdMail;
	}

	public Map<String, String> sendQnaMail(Map<String, String> map) {
		String subject = "[Fundizzy] " + (map.get("content") != null ? map.get("content") : "문의사항") + "에 대한 답변입니다.";
		
		// 인증코드만 발송하여 사용자가 인증 페이지에서 직접 코드값을 입력해야할 경우 사용
		String content = "<!DOCTYPE html>" +
	            "<html lang='ko'>" +
	            "<head>" +
	            "<meta charset='UTF-8'>" +
	            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
	            "<title>펀디즈 고객센터 이메일</title>" +
	            "</head>" +
	            "<body style='font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4;'>" +
	            "<div style='width: 600px; background-color: f1f1f1; padding: 20px; border-radius: 8px; box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1); margin: auto;'>" +
	            "<div style='font-size: 16px; font-weight: bold; color: #000000;'>펀디즈 고객센터</div>" +
	            "<div style='font-size: 12px; color: #000000; margin-bottom: 10px;'>" + 
	            (map.get("dateTime") != null ? map.get("dateTime") : java.time.LocalDate.now()) + 
	            "</div>" +
	            "<div style='font-size: 14px; line-height: 1.6;'>" +
	            "<p style='margin: 0; color: #000000;'>안녕하세요.</p>" +
	            "<p style='margin: 0; color: #000000;'>펀디즈입니다.</p>" +
	            "<hr>" +
	            "<p style='margin: 10px 0; color: #000000;'>" + 
	            (map.get("replyContent") != null && !map.get("replyContent").trim().isEmpty() 
	                ? map.get("replyContent") 
	                : "문의 내용이 없습니다.") + 
	            "</p>" +
	            "<hr>" +
	            "<p style='margin: 10px 0; color: #000000;'>추가 문의 사항이 있으시면, 언제든지 고객센터로 연락 주시기 바랍니다.</p>" +
	            "<p style='margin: 10px 0; color: #000000;'>감사합니다.</p>" +
	            "<p style='font-weight: bold; color: #000000;'>- 펀디즈 드림 -</p>" +
	            "</div>" +
	            "<div style='margin-top: 20px; padding: 15px; background-color: #f1f1f1; border-radius: 5px; font-size: 12px;'>" +
	            "<p style='margin: 5px 0; color: #000000;'><strong>펀디즈 고객센터</strong></p>" +
	            "<p style='margin: 5px 0; color: #000000;'>운영 시간: 평일 오전 9시 ~ 오후 6시</p>" +
	            "<p style='margin: 5px 0; color: #000000;'>📍 부산광역시 동천로 199 삼한골든게이트 7층 펀디즈</p>" +
	            "</div>" +
	            "</div>" +
	            "</body>" +
	            "</html>";

		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				// 별도의 쓰레드로 수행할 작업 => 메일 발송 코드 기술
				mailClient.sendMail(map.get("email"), subject, content);
			}
			
		}).start();
		
        // 메일 발송에 사용한 정보를 Map으로 반환
        Map<String, String> sendPasswdMail = new HashMap<>();
        sendPasswdMail.put("email", map.get("email"));
        return sendPasswdMail;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
