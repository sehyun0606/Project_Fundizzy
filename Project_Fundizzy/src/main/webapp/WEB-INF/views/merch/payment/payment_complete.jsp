<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제-결제완료</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/payment/payment_complete.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		 <div class="container">
			<div class="reward-step">
		        <div class="step">리워드 선택</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 예약</div>
		        <span class="arrow">→</span>
		        <div class="step-here">결제 완료</div>
			</div>
	        <div class="payment-complete">
	           <h3>결제가 완료되었습니다.</h3>
      	       	<div class="section-product">
		            <h4>[울트라 얼리버드] 티타늄 세라믹 텀블러 싱글</h4>
		            <p>구성 - 티타늄 세라믹 텀블러 1세트<br>* 실리콘 스트로우 1개, 원터치 스트로우 1개</p>
		            <p>수량 1개 <span class="price">52,000원</span></p>
	        	</div>
       	        <div class="section-price">
		            <h4>결제 금액</h4>
		            <p>리워드 금액 <span class="price">52,000원</span></p>
		            <p>배송비 <span class="price">0원</span></p>
		            <p class="total">총 결제 금액 <span class="price">52,000원</span></p>
	        	</div>
	        	<div class="two-button">
		           <button onclick="location.href='http://localhost:8081/project_fundizzy/'">홈으로</button>
		           <button>마이페이지</button>
	        	</div>
	        </div>
	    </div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>