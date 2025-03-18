<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/mypage/supporter/pay_transfer.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_transfer.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div>
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
	</div>
	<div class="pay-container">
		<span id="title">${sessionScope.sId} 님의 페이 보내기</span>
		<form action="PayTransfer" method="post">
			<div class="pay-info">
				<input type="search" id="fundizy-pay" name ="tran_amt" placeholder="보낼 금액을 입력해주세요."><br>
				<div class="pay-money">잔액: <fmt:formatNumber pattern="#,###원" value="${fundizzy_pay_info.pay_balance}"></fmt:formatNumber></div>
				<div class="btn-list"> 
					<input type="button" id="10000" value="+1만">
					<input type="button" id="50000" value="+5만">
					<input type="button" id="100000" value="+10만">
				</div>
				<input type="submit" value="보내기" id="transfer-submit">
			</div>
		</form>
	</div>
</body>
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
</html>
