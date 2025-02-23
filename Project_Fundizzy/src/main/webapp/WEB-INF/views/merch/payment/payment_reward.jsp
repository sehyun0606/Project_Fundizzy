<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제-리워드 선택</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/payment/payment_reward.css">
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
	        <div class="reward-selection-box">
	            <h2>리워드 선택</h2>
	            <hr>
	            <div class="reward-item">
	                <input type="checkbox">
	                <span class="price">52,000원</span>
	                <p class="reward-title">[울트라 얼리버드] 티타늄 세라믹 텀블러 싱글</p>
	                <p class="reward-details">구성 - 티타늄 세라믹 텀블러 1세트<br>* 실리콘 스트로우 1개, 원터치 스트로우 1개</p>
	            </div>
	            <div class="reward-item">
	                <input type="checkbox" >
	                <span class="price">52,000원</span>
	                <p class="reward-title">[울트라 얼리버드] 티타늄 세라믹 텀블러 싱글</p>
	                <p class="reward-details">구성 - 티타늄 세라믹 텀블러 1세트<br>* 실리콘 스트로우 1개, 원터치 스트로우 1개</p>
	            </div>
	            <div class="reward-item">
	                <input type="checkbox">
	                <span class="price">52,000원</span>
	                <p class="reward-title">[울트라 얼리버드] 티타늄 세라믹 텀블러 싱글</p>
	                <p class="reward-details">구성 - 티타늄 세라믹 텀블러 1세트<br>* 실리콘 스트로우 1개, 원터치 스트로우 1개</p>
	            </div>
	            <div class="privacy-section">
	                <p>공개여부(선택)</p>
	                <p class="privacy-info">서포터 목록에 서포터 이름과 결제 금액이 공개됩니다. 조용히 참여하고 싶으면 비공개를 선택해주세요.</p>
	                <label><input type="checkbox"> 이름 비공개</label>
	                <label><input type="checkbox"> 금액 비공개</label>
	            </div>
	            <button class="next-button" onclick="location.href='PaymentPay'">다음 단계</button>
	        </div>
	    </div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>