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
			<button class="back" onclick="location.href='FundBoardStory?project_code=${param.project_code}'">&lt; 스토리로 돌아가기</button>
			<div class="reward-step">
		        <div class="step-here">리워드 선택</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 예약</div>
		        <span class="arrow">→</span>
		        <div class="step">결제 완료</div>
			</div>
			
<!-- 			배송에 필요한 정보들 hidden값으로 받아와서 pay페이지로 넘기기 -->
			<form id="pay-form" action="PaymentPay" method="post">
				<input type="hidden" id="total_price" name="total_price" value="0">
			    <input type="hidden" id="project_code" name="project_code" value="${param.project_code}">
		
		        <div class="reward-selection-box">
		            <h2>수량 선택</h2>
		            <c:forEach var="reward" items="${reward}" varStatus="status">
			            <div class="reward-item">
			            	<input type="hidden" name="reward${status.count}" class="reward_code" value="${reward.reward_code}">
			                <span class="price"><fmt:formatNumber pattern="#,###" value="${reward.price}"/></span>
			                <p class="reward-title">${reward.product_name}</p>
			                <p class="reward-content">${reward.product_desc}</p>
	<!-- 		                수량 선택 박스 -->
			                <div class="ctrl_box">
								<button type="button" class="minus_btn" disabled>-</button>
								<input type="text" class="count" name ="rewardCount${status.count}" value="0" size="2" readonly>
								<button type="button" class="plus_btn">+</button>
								<input type="hidden" class="rewordPrice" value="${reward.price}">
							</div>
							<div class="reward_price"><div> 상품 누적 금액 :<span class="rewardSumPriceSapn"><fmt:formatNumber pattern="#,###" value="0"/></span></div>
							</div>
	           	  		</div>
		           	 </c:forEach>
	           	  		<div>총 결제금액 : <span class="totalPriceSapn"><fmt:formatNumber pattern="#,###" >0</fmt:formatNumber></span>원</div>
<!-- 		            잠시보류 -->
<!-- 		            <div class="privacy-section"> -->
<!-- 		                <p>공개여부(선택)</p> -->
<!-- 		                <p class="privacy-info">서포터 목록에 서포터 이름과 결제 금액이 공개됩니다. 조용히 참여하고 싶으면 비공개를 선택해주세요.</p> -->
<!-- 		                <label><input type="checkbox"> 이름 비공개</label> -->
<!-- 		                <label><input type="checkbox"> 금액 비공개</label> -->
<!-- 		            </div> -->
		            <button type="submit" id="next-button">다음단계</button>
<!-- 		    reward-selection-box -->
		        </div> 
      	 	</form>
    	</div> 
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>