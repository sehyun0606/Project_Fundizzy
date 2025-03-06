<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리워드 설계</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/projectMaker/project_reward.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/projectMaker/project_reward.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>	
	    <div class="container">
	    	<div class="title-section">
		        <h2 class="title">리워드 설계</h2>
		        <button class="button add-button">리워드 추가</button>
	    	</div>
	        <c:forEach items="${rewardList}" var="reward">
		        <div class="reward-card">
		        	<input type="hidden" class="reward_code" value="${reward.reward_code}">
		            <h3>${reward.price }원</h3>
		            <p><strong>${reward.product_name}</strong></p>
		            <p>${reward.product_desc}</p>
		            <p>배송비: <strong>${reward.delivery_fee}원</strong></p>
		            <p>제한 수량: <strong>${reward.product_limit}</strong></p>
		            <button class="button edit-button">수정</button>
		            <button class="button delete-button">삭제</button>
		        </div>
	        </c:forEach>
	    </div>
	</div>
	
	<div id="modal" class="modal">
        <div class="modal-content">
        	<div class="title-section">
	            <h2 class="title">리워드 추가</h2>
	            <span class="close">&times;</span>
        	</div>
              <form action="ProjectReward" method="POST">
              	
                <!-- 금액 입력 -->
                <label for="amount">금액</label>
                <div class="input-group">
                    <input type="number" id="amount" min="1000" value="1000" placeholder="금액을 입력해 주세요" name="price" required="required">
                    <span>원</span>
                </div>

                <!-- 리워드 명 -->
                <label for="rewardName">리워드 명</label>
                <input type="text" id="rewardName" placeholder="리워드 명을 입력해 주세요" maxlength="60" name="product_name" required="required">
                <small class="text-count">60자</small>

                <!-- 리워드 설명 -->
                <label for="rewardDesc">리워드 설명</label>
                <textarea id="rewardDesc" placeholder="리워드 구성과 혜택을 설명해 주세요" maxlength="400" name="product_desc" required="required"></textarea>
                <small class="text-count">400자</small>

                <!-- 제한 수량 -->
                <label for="limit">제한 수량</label>
                <div class="input-group">
                    <input type="number" id="limit" min="50" value="50" name="product_limit" required="required">
                    <span>개</span>
                </div>

                <!-- 배송비 -->
                <label for="shippingFee">배송비</label>
                <div class="input-group">
                    <input type="number" id="shippingFee" min="0" value="0" name="delivery_fee" required="required">
                    <span>원</span>
                </div>

                <!-- 버튼 -->
                <div class="button-group">
                    <button type="button" class="cancel-btn">취소</button>
                    <button type="submit" class="submit-btn">리워드 추가</button>
                </div>
            </form>
        </div>
    </div>
	<div id="modal2" class="modal">
        <div class="modal-content2">
        	<div class="title-section">
	            <h2 class="title">리워드 추가</h2>
	            <span class="close">&times;</span>
        	</div>
              <form action="ProjectRewardUpdate" method="POST">
              	<input type="hidden" name="reward_code" class="reward_code2">
                <!-- 금액 입력 -->
                <label for="amount">금액</label>
                <div class="input-group">
                    <input type="number" id="amount" class="amount2" min="1000" value="1000" placeholder="금액을 입력해 주세요" name="price" required="required">
                    <span>원</span>
                </div>

                <!-- 리워드 명 -->
                <label for="rewardName">리워드 명</label>
                <input type="text" id="rewardName" class="rewardName2" placeholder="리워드 명을 입력해 주세요" maxlength="60" name="product_name" required="required">
                <small class="text-count">60자</small>

                <!-- 리워드 설명 -->
                <label for="rewardDesc">리워드 설명</label>
                <textarea id="rewardDesc" class="rewardDesc2" placeholder="리워드 구성과 혜택을 설명해 주세요" maxlength="400" name="product_desc" required="required"></textarea>
                <small class="text-count">400자</small>

                <!-- 제한 수량 -->
                <label for="limit">제한 수량</label>
                <div class="input-group">
                    <input type="number" id="limit" class="limit2" min="50" value="50" name="product_limit" required="required">
                    <span>개</span>
                </div>

                <!-- 배송비 -->
                <label for="shippingFee">배송비</label>
                <div class="input-group">
                    <input type="number" id="shippingFee" class="deliveryFee2" min="0" value="0" name="delivery_fee" required="required">
                    <span>원</span>
                </div>

                <!-- 버튼 -->
                <div class="button-group">
                    <button type="button" class="cancel-btn">취소</button>
                    <button type="submit" class="submit-btn">리워드 수정</button>
                </div>
            </form>
        </div>
    </div>
    
    <script type="text/javascript">
    </script>
</body>
</html>
