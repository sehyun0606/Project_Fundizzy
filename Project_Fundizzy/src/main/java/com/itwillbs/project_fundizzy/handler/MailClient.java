package com.itwillbs.project_fundizzy.handler;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// 메일 관련 작업을 처리하는 클래스
@Component
public class MailClient {
	@Autowired
	private MailAuthenticator authenticator;
	// ------------------------------------------------
	// 메일 발송에 사용될 설정 정보
	private final String HOST = "smtp.gmail.com"; // 메일 발송 서버 주소
	// => 메일 송신 프로토콜 : SMTP(Simple Mail Transfer Protocol) <-> 수신 프로토콜 : POP3, IMAP
	private final String PORT = "587"; // Gmail SMTP 서비스 포트번호(각 메일 서버마다 포트번호 다름)
	private final String SENDER_ADDRESS = "limhsb77@gmail.com"; // 발신자 메일 주소
	// ------------------------------------------------
	
	// 메일 발송 작업을 처리하는 sendMail() 메서드 정의
	public void sendMail(String email, String subject, String content) {
		try {
			// ----------------- 메일 전송에 필요한 정보 설정 -------------------
			// 1. 시스템(= 톰캣 서버)의 속성 정보(= 서버 정보)를 java.util.Properties 객체로 리턴받기
			Properties props = System.getProperties();
			
			// 2. Properties 객체를 활용하여 메일 전송에 필요한 기본 설정 정보를 추가
			// 메일 전송에 사용할 메일 서버에 대한 정보 설정(구글, 네이버, 네이트 등)
			props.put("mail.smtp.host", HOST); // SMTP 서버 주소
			props.put("mail.smtp.port", PORT); // SMTP 서비스 포트번호
			props.put("mail.smtp.auth", "true"); // SMTP 서비스 이용 과정에서 인증(로그인) 여부 설정
			// 메일 서버 인증 관련 추가 정보 설정(설정 내용에 따라 포트번호가 달라질 수 있음)
			props.put("mail.smtp.starttls.enable", "true"); // 인증 프로토콜로 TLS 프로토콜 사용 설정
			props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // TLS 프로토콜 버전 설정
			props.put("mail.smtp.ssl.trust", HOST); // SSL 인증에 사용할 신뢰 가능한 서버 주소 등록
			
			// 3. 메일 서버에 대한 인증(로그인) 정보를 관리하는 사용자 정의 클래스 타입 인스턴스 생성
			// => @Autowired 어노테이션을 통해 자동 주입
			
			// 4. 자바 메일 전송 작업을 하나의 객체로 다룰 때 사용할
//		Session mailSession = Session.getDefaultInstance(props, authenticator);
			
			// 5. 서버 정보와 인증 정보를 포함하여 전송할 메일 정보를 하나의 묶음으로 관리할
//		Message message = new MimeMessage(mailSession);
			Message message = new MimeMessage(Session.getDefaultInstance(props, authenticator));
			// ---------------------------------------------------------------------------------
			// 6. 전송할 메일에 대한 상세 내용 설정
			// 1) 발신자 정보 설정
			Address senderAddress = new InternetAddress(SENDER_ADDRESS, "Fundizy");
			
			// 2) 수신자 정보 설정
			Address receiverAddress = new InternetAddress(email);
			// => AddressException 예외 처리 필요
			
			// 3) 5번 과정에서 생성한 MimeMessage(Message) 객체를 활용하여 전송할 메일의 내용 설정
			// => MessagingException 예외 처리 필요
			// 3-1) 메일 헤더 정보 설정(생략 가능)
			message.setHeader("content-type", "text/html; charset=UTF-8");
			
			// 3-2) 발신자 설정
			message.setFrom(senderAddress);
			
			// 3-3) 수신자 설정
			// => Message 객체의 setRecipient() 메서드를 활용하여 단일 유저에게 메일을 발송하거나
			//    setRecipients() 메서드를 활용하여 복수 유저에게 메일을 발송할 수 있음
			// => 첫번째 파라미터로 전달할 수신 타입(RecipientType 객체)은 상수 활용
			//    RecipientType.TO : 수신자에게 직접 전송(메일을 직접 수신할 수신자 = 업무 담당자)
			//    RecipientType.CC : 참조(Carbon Copy 약자). 직접 수신자는 아니나 업무 참조용(= 업무 관계자)
			//    RecipientType.BCC : 숨은 참조(Blind CC 약자). 메일 수신자가 CC 여부를 알 수 없게 참조 수신자를 숨김 
			message.setRecipient(RecipientType.TO, receiverAddress);
			
			// 3-4) 메일 제목 설정
			message.setSubject(subject);
			
			// 3-5) 메일 본문 설정
			// => 파라미터 : 본문, 컨텐츠 타입
			message.setContent("<h3>" + content + "</h3>", "text/html; charset=UTF-8");
			// --------------------------------------------------
			// 7. 메일 전송
			// Transport 클래스의 static 메서드 send() 호출
			Transport.send(message);
			System.out.println("메일 발송 성공!");
		} catch (Exception e) {
			System.out.println("메일 발송 실패!");
			e.printStackTrace();
		}
		
	}

	
}











