<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay_charge_result</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_charge.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div>
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
	</div>
	<div class="pay-container">
		<input type="hidden" value="${bank_tran_id}">
		<p>내 계좌로 <fmt:formatNumber pattern="#,###원 " value="${map.tran_amt}"></fmt:formatNumber>송금완료!</p>
		<p>페이잔액 : <fmt:formatNumber pattern="#,###원" value="${payBalance != null ? payBalance : 0}"></fmt:formatNumber></p>
		<p>받는계좌 : ${bank_tran_id}</p>
		<p>출금계좌 : 펀디지페이</p>
		<input type="button" value="페이홈으로" onclick="location.href='PayPage'">
	</div>
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
</body>
</html>
