<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제-결제예약</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/payment/payment_pay.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		 <div class="container">
			<button class="back" onclick="location.href='PaymentReward'">&lt; 스토리로 돌아가기</button>
			<div class="reward-step">
		        <div class="step">리워드 선택</div>
		        <span class="arrow">→</span>
		        <div class="step-here">결제 예약</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 완료</div>
			</div>
	       <div class="section-product">
	            <h3>[울트라 얼리버드] 티타늄 세라믹 텀블러 싱글</h3>
	            <p>구성 - 티타늄 세라믹 텀블러 1세트<br>* 실리콘 스트로우 1개, 원터치 스트로우 1개</p>
	            <p>수량 1개 <span class="price">52,000원</span></p>
	        </div>
	        <div class="section-price">
	            <h4>결제 예약 금액</h4>
	            <p>리워드 금액 <span class="price">52,000원</span></p>
	            <p>배송비 <span class="price">0원</span></p>
	            <p class="total">총 결제 금액 <span class="price">52,000원</span></p>
	        </div>
	        <div class="support-ship">
		        <div class="section-supporter">
		            <h4>서포터</h4>
		            <p>이름 정유나</p>
		            <p>휴대폰 010-2442-5478</p>
		            <p>이메일 yuyu1503@naver.com</p>
		        </div>
		        <div class="section-shipment">
		            <h4>리워드 배송지(최근배송지)</h4>
		            <p>정유나 010-2242-5478<br>부산시 수영구 반송로 (우미마을 120 1937)</p>
		            <div class="tag">새로운 입력</div>
		            <input type="text" class="shipment-box" placeholder="배송 시 요청사항 (선택)">
		        </div>
	        </div>
	        <div class="section-reservation">
	            <h4>예약 결제</h4>
	            <label><input type="radio" name="payment" checked> 와디즈 간편결제</label>
<!-- 	            <div class="upload-box">+</div> -->
	            <label><input type="radio" name="payment" checked> 직접입력</label>
	        </div>
	        <div class="section-now">
	            <h4>지금 결제</h4>
	            <label><input type="radio" name="final-payment"> 네이버 페이</label>
	            <label><input type="radio" name="final-payment"> 카카오 페이</label>
	            <label><input type="radio" name="final-payment"> 신용/체크카드</label>
	        </div>
	      	<div class="payment-notice">
	      		<h4>결제 유의사항</h4>
				<ul>
			        <li>장기할부는 상품금액이 30만원 이상, 일부 프로젝트 유형에 한해서만 제공됩니다.</li>
			        <li>예약 결제의 경우 결제 실행일에 결제자 귀책사유(한도초과, 이용정지 등)로 인하여 결제가 실패할 수 있으니, 결제수단이 유효한지 확인해주세요.</li>
			        <li>예약 결제의 경우 1차 결제 실패 시 다음날 재 결제를 실행합니다.</li>
			        <li>예약 결제 이후, 결제 정보를 변경하려면 마이페이지 &gt; 참여 내역 상세에서 결제 정보를 변경해주세요.</li>
			        <li>지금 결제를 한 경우에도 프로젝트가 종료되기 전까지 언제든 결제를 취소할 수 있어요.</li>
			    </ul>
			</div>
			<div class="payment-pay">
				<h4>약관동의</h4>
				<input type="checkbox">결제 진행 필수 동의<br>
				<input type="checkbox">구매조건, 결제 진행 및 결제 대행 서비스 동의(필수)<br>
				<input type="checkbox">개인정보 제3자 제공 동의 (필수)<br>
				<button onclick="location.href='PaymentComplete'">결제하기</button>
			</div>
				       
	    </div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>