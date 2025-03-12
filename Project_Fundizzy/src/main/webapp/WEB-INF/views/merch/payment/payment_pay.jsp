<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제-결제예약</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/payment/payment_pay.css">
<!-- js파일 로드 script -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/merch/payment/payment_pay.js"></script>
<!-- 주소 api script -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 결제 관련 jQuery -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
  <style>
    .wrong_text{font-size:1rem;color:#f44e38;letter-spacing:-.2px;font-weight:300;margin:8px 0 2px;line-height:1em;display:none}
  </style>
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
			
			<form action="PaymentComplete" id="complete-form" method="post">
<!-- 			순서대로 프로젝트코드, 리워드코드 ,리워드명, 리워드설명 ,수량  -->
				<input type="hidden" id="project_code"  name = "project_code" value="${reward.project_code}"> 
				<input type="hidden" id="reward_code"  name="reward_code" value="${reward.reward_code}"> 
				<input type="hidden" id="product_name"  name="product_name" value="${reward.product_name}"> 
				<input type="hidden" id="product_desc"  name="product_desc" value="${reward.product_desc}"> 
				<input type="hidden" id="total_count" name="total_count" value="${total_count}"> 
				<input type="hidden" id="reward_price" name="reward_price" value="${reward.price}"> 
			</form>
	       <div class="section-product">
<!-- 	       완료 -->
	            <h3>${reward.product_name}</h3>
	            <p>${reward.product_desc}</p>
	            <p>수량: ${total_count}개<br><span id="total_price" class="totalPrice"><fmt:formatNumber pattern="#,###원" value="${total_price}"></fmt:formatNumber></span></p>
	        </div>
	        <div class="section-price">
<!-- 	        완료 -->
	            <h4>결제 금액</h4>
	            <p>리워드 금액 <span class="total_price"><fmt:formatNumber pattern="#,###원" value="${total_price}"></fmt:formatNumber></span></p>
	            <p>배송비 <span class="price">${reward.delivery_fee}원</span></p>
	            <p class="total">총 결제 금액 <span id="total_price_delivery"><fmt:formatNumber pattern="#,###원" value="${total_price + reward.delivery_fee}"></fmt:formatNumber></span></p>
	        </div>
	        <div class="support-ship">
		        <div class="section-supporter">
<!-- 		        완료 -->
		            <h4>서포터</h4>
		            <p>닉네임 ${member.nickname}</p>
		            <p>휴대폰 ${member.phone}</p>
		            <p>이메일 ${member.email}</p> 
		        </div>
		        <div class="section-shipment">
<!-- 		        완료 -->
		            <h4>리워드 배송지</h4>
		            <span class="notice">* 회원정보를 기반으로 생성한 배송지 입니다.</span><br>
		            <div id="div_address">
		            	<input type="radio" name="address" id="address" value="최근 배송지" checked="checked">
		            	<label for="address">
			            	<input type="text" id="ship-name" placeholder="배송 받으실 분 이름을 입력해주세요." required="required"><br>
	            	        <span id="ship-phone">${member.phone}</span><br>
					        <span id="ship-postcode">(${member.post_code})</span> 
					        <span id="ship-address1">${member.address1}</span> 
					        <span id="ship-address2">${member.address2}</span>
		             	</label>
	             	</div>
		            <div id="div_new_address">
<!-- 		            해야함 -->
			            <input type="radio" value="새로운 입력" name="address" id="new_address">
			            <label for="new_address">새로입력</label>
			            <div class="new_address_box">
			            	<span id="ship-new-name">이름</span><input type="text" id="ship-new-name" required="required"><br>
			            	<span id="ship-new-phone">휴대폰</span><input type="text" id="ship-new-phone" required="required"><br> 
			            	<span id="address_add">주소
			            		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			            	</span>
			            	<input type="text" id="sample6_postcode" placeholder="우편번호" required="required"><br>
							<input type="text" id="sample6_address" placeholder="주소" required="required"><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소" required="required">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목" required="required">
			            </div>
		             </div>
		            <input type="text" id="shipment-box" placeholder="배송 시 요청사항(선택)">
		        </div>
	        </div>
	        
	        <div class="section-reservation">
	            <h4>예약 결제</h4>
	            <label><input type="radio" name="payment" checked> 펀디지 페이</label>
	          <div class="upload-box">
			     <p class="fundizzy-pay">Fundizzy Pay</p>
			     <span id="pay_amt"><fmt:formatNumber pattern="#,###원" value="${fundizzy_pay.pay_balance}"></fmt:formatNumber></span>
			     <input type="button" id="charge-btn" value="충전" onclick="location.href='PayCharge'"> 
			 </div>

	        </div>
	        <div class="section-now">
	            <h4>지금 결제</h4>
	            <label><input type="radio" class="pay" name="payment"> 네이버 페이</label>
	            <label><input type="radio" class="pay" name="payment"> 카카오 페이</label>
	            <label><input type="radio" class="pay" name="payment"> 신용/체크카드</label>
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
				<div class="checkbox-container"><input type="checkbox" required="required" id="agree1"><label for="agree1">결제 진행 필수 동의 (필수)</label><br></div>
				<div class="checkbox-container"><input type="checkbox" required="required" id="agree2"><label for="agree2">구매조건, 결제 진행 및 결제 대행 서비스 동의 (필수)</label><br></div>
				<div class="checkbox-container"><input type="checkbox" required="required" id="agree3"><label for="agree3">개인정보 제3자 제공 동의 (필수)</label><br></div>
				<button id="PaymentComplete">결제하기</button>
			</div>
				       
	    </div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>