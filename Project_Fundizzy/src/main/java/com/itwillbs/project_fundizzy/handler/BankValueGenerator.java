package com.itwillbs.project_fundizzy.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

// 금융결제원 API 활용에 필요한 다양한 값을 생성하는 용도의 클래스 정의
public class BankValueGenerator {
	// 거래고유번호(참가기관) 자동 생성 메서드
	// => API 문서 - 3.11. 거래고유번호(참가기관) 생성 안내 참고
	// => 형식 : 이용기관코드(10자리) + 생성주체구분코드("U") + 이용기관 부여번호(9자리)
	public static String getBankTranId(String client_use_code) {
		// 이용기관 부여번호 9자리 생성 => 난수 활용
		// 미리 정의된 GenerateRandomCode - getRandomCode(int) 메서드 재사용
		// => 파라미터 : 생성할 난수 길이(9) 전달
		// => 주의! API 명세서에 bank_tran_id 값의 타입이 AN(20) 으로 표기되어 있음
		//    이 때 AN(20) = 알파벳 + 숫자 조합 10자리 이며, 반드시 알파벳은 대문자 사용
		//    따라서, getRandomCode() 메서드를 통해 리턴받은 알파벳+숫자 난수를 대문자 변환 필수!
		return client_use_code + "U" + GenerateRandomCode.getRandomCode(9).toUpperCase();
	}

	// 작업요청일시(거래시간 등) 자동 생성 메서드
	// => 현재 시스템 날짜 및 시각 기준 14자리 숫자로 된 문자열 생성(yyyyMMddHHmmss 형식 - 포맷팅 필요)
	// => java.time.LocalDateTime 클래스 활용(포맷팅은 DateTimeFormatter 활용)
	public static String getTranDTrime() {
		// LocalDateTime 클래스의 static 메서드 now() 호출하여 현재 시각 및 날짜 정보 가져오기
		LocalDateTime localDateTime = LocalDateTime.now();
		
		// LocalXXX 클래스에 대한 포맷팅 전용 클래스인 
		// java.time.DateTimeFormatter 의 static 메서드 ofPattern() 메서드 호출하여
		// 변환할 날짜 및 시각의 포맷 형식 문자열 패턴(yyyyMMddHHmmss) 전달
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		// LocalDateTime 객체의 format() 메서드 호출하여 포맷 문자열을 파라미터로 전달하여
		// 시스템 날짜 및 시각 정보를 포맷팅 후 변환된 문자열 그대로 리턴
		return localDateTime.format(dateTimeFormatter);
	}
	
	// 자체 거래 관리용 고유번호(tran_id)값 생성하는 메서드
	public static String getTranId() {
		// 현재 시스템의 날짜 및 시각정보를 문자열로 변환하는 getTranDTime() 메서드 재사용
		// 또한, UUID 에서 앞자리 8자리 추출하여 대문자로 변환 후 결합
		return getTranDTrime() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
	}

}










