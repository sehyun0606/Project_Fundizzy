<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	        
	        <div class="reward-card">
	            <h3>1000원</h3>
	            <p><strong>리워드 이름이 들어가는 곳</strong></p>
	            <p>리워드 설명이 들어가는 곳</p>
	            <p>배송비: <strong>100원</strong></p>
	            <p>제한 수량: <strong>100개</strong></p>
	            <button class="button edit-button">수정</button>
	            <button class="button delete-button">삭제</button>
	        </div>
	        <div class="reward-card">
	            <h3>1000원</h3>
	            <p><strong>리워드 이름이 들어가는 곳</strong></p>
	            <p>리워드 설명이 들어가는 곳</p>
	            <p>배송비: <strong>100원</strong></p>
	            <p>제한 수량: <strong>100개</strong></p>
	            <button class="button edit-button">수정</button>
	            <button class="button delete-button">삭제</button>
	        </div>
	        <div class="reward-card">
	            <h3>1000원</h3>
	            <p><strong>리워드 이름이 들어가는 곳</strong></p>
	            <p>리워드 설명이 들어가는 곳</p>
	            <p>배송비: <strong>100원</strong></p>
	            <p>제한 수량: <strong>100개</strong></p>
	            <button class="button edit-button">수정</button>
	            <button class="button delete-button">삭제</button>
	        </div>
	    </div>
	</div>
	
	<div id="modal" class="modal">
        <div class="modal-content">
        	<div class="title-section">
	            <h2 class="title">리워드 추가</h2>
	            <span class="close">&times;</span>
        	</div>
              <form>
                <!-- 금액 입력 -->
                <label for="amount">금액</label>
                <div class="input-group">
                    <input type="number" id="amount" placeholder="금액을 입력해 주세요">
                    <span>원</span>
                </div>

                <!-- 리워드 명 -->
                <label for="rewardName">리워드 명</label>
                <input type="text" id="rewardName" placeholder="리워드 명을 입력해 주세요" maxlength="40">
                <small class="text-count">40자</small>

                <!-- 리워드 설명 -->
                <label for="rewardDesc">리워드 설명</label>
                <textarea id="rewardDesc" placeholder="리워드 구성과 혜택을 설명해 주세요" maxlength="800"></textarea>
                <small class="text-count">800자</small>

                <!-- 제한 수량 -->
                <label for="limit">제한 수량</label>
                <div class="input-group">
                    <input type="number" id="limit" min="0" value="0">
                    <span>개</span>
                </div>

                <!-- 배송비 -->
                <label for="shippingFee">배송비</label>
                <div class="input-group">
                    <input type="number" id="shippingFee" min="0" value="0">
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
</body>
</html>
