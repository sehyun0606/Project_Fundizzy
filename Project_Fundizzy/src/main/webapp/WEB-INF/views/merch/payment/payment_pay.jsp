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
			<button class="back" onclick="location.href='PaymentReward?project_code=${param.project_code}'">&lt; 스토리로 돌아가기</button>
			<div class="reward-step">
		        <div class="step">리워드 선택</div>
		        <span class="arrow">→</span>
		        <div class="step-here">결제 예약</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 완료</div>
			</div>
			
			<form action="PaymentComplete" id="complete-form" method="post">
				<input type="hidden" id="project_code"  name="project_code" value="${param.project_code}"> 
				<input type="hidden" id="delivery_fee" name="delivery_fee" value="${project_info.delivery_fee}">
				<input type="hidden" id="payment_price" name="payment_price" value="${total_price + selectedReward.delivery_fee}">
				
		       <div class="section-product">
	       			<c:forEach var="rewardList" items="${rewardList}" varStatus="status">
	       				<input type="hidden" name="reward${status.count}" value="${rewardList.reward_code}">
	       				<input type="hidden" name="rewardCount${status.count}" value="${rewardList.product_count}">
			            <h3>${rewardList.product_name}</h3>
			            <p>${rewardList.product_desc}</p>
			            <p>수량: ${rewardList.product_count}개<br><span id="product_price" class="product_price"><fmt:formatNumber pattern="#,###원" value="${rewardList.price}"></fmt:formatNumber></span></p>
	       			</c:forEach>
		        </div>
		        <div class="section-price">
		            <h4>결제 금액</h4>
		            <p>리워드 금액 <span class="total_price"><fmt:formatNumber pattern="#,###원" value="${total_price}"></fmt:formatNumber></span></p>
		            <p>배송비 <span class="price"><fmt:formatNumber pattern="#,###원" value="${project_info.delivery_fee}"></fmt:formatNumber></span></p>
		            <p class="total">총 결제 금액 <span id="total_price_delivery"><fmt:formatNumber pattern="#,###원" value="${total_price + project_info.delivery_fee}"></fmt:formatNumber></span></p>
		        </div>
		        <div class="support-ship">
			        <div class="section-supporter">
			            <h4>서포터</h4>
			            <p>닉네임 ${member.nickname}</p>
			            <p>휴대폰 ${member.phone}</p>
			            <p>이메일 ${member.email}</p> 
			        </div>
			        <div class="section-shipment">
		            	<div id="div_new_address">
								<!-- 			            <input type="radio" value="새로운 입력" name="addressRadio" id="new_address"> -->
			            <h4>배송지 입력</h4>	
			            <div class="new_address_box">
			            	<span id="ship-new-name">이름</span><input type="text" name="name" class="addressInfo" id="ship-newName" required="required"><br>
			            	<span id="ship-new-phone">휴대폰</span><input type="text" name="phone_num" value="${member.phone}" id="ship-newPhone" class="addressInfo" required="required"><br> 
			            	<span id="address_add">주소
			            		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			            	</span>
			            	<input type="text" class="addressInfo" id="sample6_postcode" placeholder="우편번호" name="post_code" value="${member.post_code}" required="required"><br>
							<input type="text" class="addressInfo" id="sample6_address" placeholder="주소" name="address1" value="${member.address1}" required="required"><br>
							<input type="text" class="addressInfo" id="sample6_detailAddress" placeholder="상세주소"  name="address2" value="${member.address2}" required="required">
							<input type="text" class="addressInfo" id="sample6_extraAddress" placeholder="참고항목" name="extra_address" value=""> 
			            </div>
		             </div>
			            <input type="text" id="shipment-box" name="delivery_req" placeholder="배송 시 요청사항(선택)">
			        </div>
		        </div>
		        
		        <div class="section-reservation">
		            <h4>페이 결제</h4>
		            <label><input type="radio" name="common_code" value="PAY01" checked> 펀디지 페이</label>
		          <div class="upload-box">
				     <p class="fundizzy-pay">Fundizzy Pay</p>
				     <span id="pay_amt"><fmt:formatNumber pattern="#,###원" value="${fundizzy_pay.pay_balance}"></fmt:formatNumber></span>
				     <input type="button" id="charge-btn-modal" value="충전"> 
				 </div>
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
					<button type="submit" id="PaymentComplete">결제하기</button>
				</div>
			</form>
	    </div>
	</article>
	<!-- 	충전 모달창  -->
	<div class="charge_modal" id="Deposit_and_withdrawal">
	    <div class="charge_modal">
	        <div class="top">
	            <button type="button" class="x">x</button><br>
	        </div>
			<div class="pay-container">
			    <p>${sessionScope.sId} 님의 페이 충전</p>
			    <form id="payChargeForm">
			        <div class="pay-info">
			            <input type="search" id="fundizy-pay" name="tran_amt" placeholder="충전할 금액 입력">
			            <div class="btn-list">
			                <input type="button" id="50000" value="+5만" onclick="addAmount(50000)">
			                <input type="button" id="100000" value="+10만" onclick="addAmount(100000)">
			                <input type="button" id="300000" value="+30만" onclick="addAmount(300000)">
			            </div>
			            <input type="button" value="충전하기" id="charge-submit-modal">
			        </div>
			    </form>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>