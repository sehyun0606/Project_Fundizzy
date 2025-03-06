<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 정보 관리</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bank/mypayment_info_manage.css" />
<!-- 아이콘 -->
<!-- <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script> -->
<!-- js연결 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bank/mypayment_info_manage.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	<article>
		<div id="title">
			잔액조회
		</div>
		${sessionScope.sId} 서포터님의 계좌 정보
	</article>
	

	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>