<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발송·환불 관리</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="styleSheet" type="text/css" href="resources/css/projectState/shipment_refund.css" >
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>발송·환불 관리</h1>
			<h3>서포터 관리</h3>
		    <div class="status-container">
		        <div class="section">
		            <div class="title">발송·배송 상태</div>
		            <div class="status">
		                <div>
		                    <span>미발송</span>
		                    <span class="count">0<span>건</span></span>
		                </div>
		                <div>
		                    <span>배송 중</span>
		                    <span class="count">0<span>건</span></span>
		                </div>
		                <div>
		                    <span>배송 완료</span>
		                    <span class="count">3<span>건</span></span>
		                </div>
		            </div>
		        </div>
<!-- 		        <hr> -->
		        <div class="section">
		            <div class="title">환불 상태</div>
		            <div class="status">
		                <div>
		                    <span>신청</span>
		                    <span class="count">1<span>건</span></span>
		                </div>
		                <div>
		                    <span>완료</span>
		                    <span class="count">1<span>건</span></span>
		                </div>
		                <div>
		                    <span>거절</span>
		                    <span class="count">1<span>건</span></span>
		                </div>
		            </div>
		        </div>
		    </div>
	        <div class="note">
	            리워드 발송을 완료하면 발송 정보 입력을 통해 발송 처리를 진행해 주세요.<br>
	            상태 건수는 발송 받는 기준으로 계산돼요.
	        </div>
			
			<div class="order-summary">
				<span>목록</span>
				<span>총 <span>100</span>건</span>
			</div>
			<table class="list">
	            <tr>
	                <th width="6%">결제번호</th>
	                <th width="10%">서포터 정보</th>
	                <th width="7%">결제일</th>
	                <th width="7%">결제 금액</th>
	                <th width="7%">발송 정보</th>
	                <th width="7%">발송 예정일</th>
	                <th width="7%">발송 상태</th>
	                <th width="5%">발송 번호</th>
	                <th width="5%">환불</th>
	                <th width="3%"></th>
	            </tr>
	            <c:forEach var="order" begin="1" end="10">
		            <tr>
		                <td>${order}</td>
		                <td>
		                    오렌지<br>
		                    orange111@gmail.com<br>
		                    010-0000-0000
		                </td>
		                <td>2025-01-01</td>
		                <td>18,000원</td>
		                <td><input type="button" value="입력"></td>
		                <td>2025-01-01</td>
		                <td>배송 완료</td>
		                <td>010101011</td>
		                <td>신청</td>
		                <td class="toggle-btn">
		                	<button><img src="${pageContext.request.contextPath}/resources/images/projectState/arrow_right.png" style="width: 10px; height: 10px;"></button>
	                	</td>
		            </tr>
	            	<c:forEach var="kiki" begin="1" end="3">
			            <tr class="details">
			                <td colspan="10">
			                    <table>
			                        <tr>
			                            <th>리워드명</th>
			                            <th>리워드 금액</th>
			                            <th>수량</th>
			                            <th>환불 상태</th>
			                        </tr>
			                        <tr>
			                            <td>스페셜 기프트</td>
			                            <td>18,000원</td>
			                            <td>1개</td>
			                            <td>신청 중</td>
			                        </tr>
			                    </table>
			                </td>
			            </tr>
		            </c:forEach>
	            </c:forEach>
		    </table>
	    </div>
	</div>
	<script>
		$("toggle-btn").click(function() {
			$(this).closest("tr").next(".details").toggle();
			
		});
	</script>
	
	
</body>
</html>






















