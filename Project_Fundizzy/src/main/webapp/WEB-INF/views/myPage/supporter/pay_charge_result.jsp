<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay_charge_result</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_charge.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="pay-container">
		<input type="hidden" value="${bank_tran_id}">
		<p>내 펀디지페이로 ${chargeResult.tran_amt}원 충전완료</p>
		<p>페이잔액 : ${fundizzy_pay.pay_balance}원</p>
		<input type="button" value="페이홈으로">
	</div>
<%-- 	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include> --%>
</body>
</html>
