<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 정보 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bank/my_payment_info_manage.css" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		<div id="title">
			결제 정보 관리
		</div>
		<div id="accountInfo">
			<div class="subTitle">등록된 계좌정보</div>
			<div id="registAccountList">
				<div class="account">
					<div class="accountHeader">
						<div class="bankName">
							<img src="${pageContext.request.contextPath}/resources/images/bank/bankbook.png">  
							산업은행
						</div>
						<div class="delete">
							<img alt="계좌 삭제하기" src="${pageContext.request.contextPath}/resources/images/bank/trashcan.png">삭제
						</div>
					</div>
					<div class="accountInfo">
						계좌번호 : 3333-3333-333
					</div>
					<div class="accountBottom">
						<div class="registDate">
							계좌등록일 : 2025. 02. 01
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<div id="cardInfo">
			<div class="subTitle">간편결제카드</div>
			<div class="card">
				<div class="cardHeader">
					<div class="companyName">
						<img src="${pageContext.request.contextPath}/resources/images/bank/card.png">  
						신한카드
					</div>
					<div class="delete">
						<img alt="카드 삭제하기" src="${pageContext.request.contextPath}/resources/images/bank/trashcan.png">삭제
					</div>
				</div>
				<div class="cardInfo">
					계좌번호 : 3333-3333-333
				</div>
				<div class="registDate">
					계좌등록일 : 2025. 02. 01
				</div>
			</div>
		</div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>