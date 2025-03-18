<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay_charge_result</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_charge_result.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div>
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
	</div>
	<div class="pay-container">
		<div class="pay-info">
			<input type="hidden" value="${bank_tran_id}">
			<span id="span1">내 펀디지페이로 <fmt:formatNumber pattern="#,###원 " value="${chargeResult.tran_amt}"></fmt:formatNumber>충전완료!</span><br>
			<span id="span2">페이잔액 : <fmt:formatNumber pattern="#,###원" value="${payBalance != null ? payBalance : 0}"></fmt:formatNumber></span><br>
			<input type="button" id="home" value="페이홈으로" onclick="location.href='PayPage'">
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
</body>
</html>
