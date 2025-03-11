<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		            <h4>${reward.product_name}</h4>
		            <p>${reward.product_desc}</p>
		            <p>수량: ${total_count}개<br><span id="total_price" class="totalPrice"><fmt:formatNumber pattern="#,###원" value="${total_price}"></fmt:formatNumber></span></p>
	        	</div>
       	        <div class="section-price">
		            <h4>결제 금액</h4>
		             <p>리워드 금액 <span class="total_price"><fmt:formatNumber pattern="#,###원" value="${total_price}"></fmt:formatNumber></span></p>
		             <p>배송비 <span class="price">${reward.delivery_fee}원</span></p>
		             <p class="total">총 결제 금액 <span id="total_price_delivery"><fmt:formatNumber pattern="#,###원" value="${total_price + reward.delivery_fee}"></fmt:formatNumber></span></p>
	        	</div>
	        	<div class="two-button">
		           <button onclick="location.href='http://localhost:8081/'">홈으로</button>
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