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
	<div>
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
	</div>
	<div class="pay-container">
		<p>${sessionScope.sId} 님의 페이 보내기</p>
		<form action="PayTransfer" method="post">
			<div>
				내가 등록한 계좌로 
			</div>
			<div class="pay-info">
				<input type="search" id="fundizy-pay" name ="tran_amt" placeholder="보낼 금액을 입력해주세요.">
				<div class="btn-list">
					<input type="button" value="+1만">
					<input type="button" value="+5만">
					<input type="button" value="+10만">
				</div>
				<input type="submit" value="보내기" id="transfer-submit">
			</div>
		</form>
	</div>
<%-- 	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include> --%>
</body>
</html>
