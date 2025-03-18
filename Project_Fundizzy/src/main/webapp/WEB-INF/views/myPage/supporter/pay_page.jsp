<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_page.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<!-- js연결 -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/mypage/supporter/pay_page.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div >
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
	</div>
	<div class="pay-container">
		<p>${sessionScope.sId} 님의 페이</p>
	  <div class="pay-info">
	  	<div class="fundizy-pay">Fundizy Pay</div> <br>
	  	<div class="pay-money"><fmt:formatNumber pattern="#,###원" value="${fundizzy_pay_info.pay_balance}"></fmt:formatNumber></div>  	
	  	<div class="button-div">
		  <input type="button" value="충전" id="charge" onclick="location.href='PayCharge'"> 
		  <input type="button" value="송금" id="transfer" onclick="location.href='PayTransfer'">
	  	</div>
<!-- 		  모달창으로 띄우기 -->
		  <input type="button" value="입출금 내역" id="Deposit_and_withdrawal_details"> 
	  </div>
	</div>
	
<!-- 	입출금 내역 모달창  -->
	<div class="Deposit_and_withdrawal" id="Deposit_and_withdrawal">
	    <div class="Deposit_and_withdrawal">
	        <div class="top">
	            <b class="subject">${sessionScope.sId} 님의 페이 입출금 내역 목록</b>
	            <button type="button" class="x">x</button><br>
	        </div>
	        <span id="explanation"><i class='far fa-check-square' style='font-size:24px'></i>CH: 충전 DE: 송금 PA: 결제 RE: 환불</span>
        <div class="account_list_table">
            <table>
                <tr>
                    <th class="pay_date">거래일자</th>
                    <th class="pay_type">거래타입</th>
                    <th>거래금액</th>
                    <th>페이잔액</th>
                </tr>
                <c:forEach var="account" items="${fundizzy_pay}">
                    <tr>
	                    <th>${account.pay_date}</th>
	                    <th>${account.pay_type}</th>
	                    <th><fmt:formatNumber pattern="#,###원" value="${account.pay_amt}"></fmt:formatNumber></th>
	                    <th><fmt:formatNumber pattern="#,###원" value="${account.pay_balance}"></fmt:formatNumber></th>
                    </tr>
                </c:forEach>
            </table>
   		 </div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
</body>
</html>
