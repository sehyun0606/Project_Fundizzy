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
	    	</div>
	        <c:forEach items="${rewardList}" var="reward">
		        <div class="reward-card">
		        	<input type="hidden" class="reward_code" value="${reward.reward_code}">
		            <h3>${reward.price }원</h3>
		            <p><strong>${reward.product_name}</strong></p>
		            <p>${reward.product_desc}</p>
		            <p>배송비: <strong>${reward.delivery_fee}원</strong></p>
		            <p>제한 수량: <strong>${reward.product_limit}</strong></p>
		        </div>
	        </c:forEach>
	    </div>
	</div>
	
</body>
</html>
