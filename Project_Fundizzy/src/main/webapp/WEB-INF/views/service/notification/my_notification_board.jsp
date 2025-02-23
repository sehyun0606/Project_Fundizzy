<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 알림</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/service/notification/my_notification_board.css" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		<div id="title">
			알림
		</div>
		<div id="topGroup">
			<div>
				<select>
					<option>전체알림</option>
					<option>전체알림</option>
					<option>전체알림</option>
					<option>전체알림</option>
				</select>
			</div>
			<div>
				<label><input type="checkbox">전체선택</label>
				<input type="button" value="읽음으로 표시">
			</div>
		</div>
		<div id="notificationList">
		<c:forEach begin="1" end="20">
			<div class="notification">
				<div class="notificationHeader">
					<div class="notificationTitle">
						서포터알림
					</div>
					<div class="notificationDate">
						2025-02-15
					</div>
				</div>
				<div class="notificationBody">
					<div class="notificationContent">
						'목수장인 그릇 판매'프로젝트 리워드가 발송 되었습니다.
					</div>
					<div class="checkbox">
						<input type="checkbox">
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>