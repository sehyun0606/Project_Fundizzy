<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>pay</title>
    <!-- js파일 로드 script -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mypage/supporter/pay_charge.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/pay_charge.css">
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div>
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
	</div>
	<div class="pay-container">
		<p>${sessionScope.sId} 님의 페이 충전</p>
		<form action="PayCharge" method="post">
			<div class="pay-info">
				<input type="search" id="fundizy-pay" name="tran_amt" placeholder="충전할 금액 입력">
				<div class="btn-list">
					<input type="button" id="50000" value="+5만">
					<input type="button"  id="100000" value="+10만">
					<input type="button"  id="300000" value="+30만">
				</div>
				<div>
				</div>
				<input type="submit" value="충전하기" id="charge-submit">
			</div>
		</form>
	</div>
<%-- 	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include> --%>
</body>
</html>
