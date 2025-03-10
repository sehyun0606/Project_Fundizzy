<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_page.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="pay-container">
		<p>${sessionScope.sId} 님의 페이</p>
	  <div class="pay-info">
	  	<div class="fundizy-pay">Fundizy Pay</div> <br>
	  	<div class="pay-money">${fundizzy_pay.pay_amt}</div>  	
	  	<div class="button-div">
		  <input type="button" value="충전" id="charge" onclick="location.href='PayCharge'"> 
		  <input type="button" value="송금" id="transfer" onclick="location.href='PayTransfer'"> 
	  	</div>
	  </div>
	  <div class="pay-detail">
	  	입출금 내역 
	  
	  </div>
	</div>
<%-- 	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include> --%>
</body>
</html>
