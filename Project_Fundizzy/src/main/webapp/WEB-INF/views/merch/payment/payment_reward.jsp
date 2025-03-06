<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제-리워드 선택</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/payment/payment_reward.css">
<!-- js파일 로드 script -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/merch/payment/payment_reward.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		 <div class="container">
			<button class="back" onclick="location.href='FundBoardStory'">&lt; 스토리로 돌아가기</button>
			<div class="reward-step">
		        <div class="step-here">리워드 선택</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 예약</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 완료</div>
			</div>
			<form action="">
		        <div class="reward-selection-box">
		            <h2>수량 선택</h2>
		            <hr>
		            <div class="reward-item">
		            	<input type="hidden" name="sell_price" value="${reward.price}" style="width:30px;">
		                <span class="price">${reward.price}</span>
		                <p class="reward-title">${reward.product_name}</p>
		                <div class="ctrl_box">
							<button type="button" class="minus_btn" value="${schedule.showtime_type}">-</button>
							<input type="text" class="totalCount" value="1" size="2" readonly)>
							<button type="button" class="plus_btn" value="${schedule.showtime_type}">+</button>
						</div>
						<div class="totalAmount">최종 가격 : totalPrice </div>
		           	 </div>
		            <div class="privacy-section">
		                <p>공개여부(선택)</p>
		                <p class="privacy-info">서포터 목록에 서포터 이름과 결제 금액이 공개됩니다. 조용히 참여하고 싶으면 비공개를 선택해주세요.</p>
		                <label><input type="checkbox"> 이름 비공개</label>
		                <label><input type="checkbox"> 금액 비공개</label>
		            </div>
		            <button class="next-button" onclick="location.href='PaymentPay'">다음 단계</button>
		        </div>
	        </form>
	    </div> 
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>