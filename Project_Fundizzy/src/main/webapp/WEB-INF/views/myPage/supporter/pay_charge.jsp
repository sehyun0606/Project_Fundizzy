<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_charge.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="pay-container">
		<p>${sessionScope.sId} 님의 페이 충전</p>
		<form action="PayCharge" method="post">
			<input type="hidden" name="charge_fintech_use_num" value="${accountDetail.fintech_use_num }">
			<input type="hidden" name="charge_account_client_name" value="${account_holder_name}">
			<div class="pay-info">
				<input type="search" id="fundizy-pay" placeholder="충전할 금액 입력">
				<div class="btn-list">
					<input type="button" value="+1만">
					<input type="button" value="+5만">
					<input type="button" value="+10만">
				</div>
				<div>
					내가 등록한 계좌 띄우기 
				</div>
				<input type="submit" value="충전하기" id="charge-submit">
			</div>
		</form>
	</div>
<%-- 	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include> --%>
</body>
</html>
