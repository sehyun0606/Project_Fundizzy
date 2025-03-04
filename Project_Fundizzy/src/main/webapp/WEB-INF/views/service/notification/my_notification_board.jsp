<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 알림</title>
<link rel="stylesheet" href="/resources/css/service/notification/my_notification_board.css" />
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
					<option value="">전체알림</option>
					<option value="NOT01">Fundizzy</option>
					<option value="NOT02">팔로잉메이커</option>
					<option value="NOT03">찜 프로젝트</option>
					<option value="NOT04">내 프로젝트</option>
					<option value="NOT05">참여 프로젝트</option>
				</select>
			</div>
			<div>
				<input type="checkbox" id="allCheck">
				<input type="button" id="allCheckBtn" value="전체선택">
				<input type="button" id="deleteBtn" value="알림삭제">
			</div>
		</div>
		<div id="notificationList">
		<c:forEach var="myNOT" items="${myNOTList}">
			<div class="notification">
				<div class="notificationHeader">
					<div class="notificationTitle">
						<c:choose>
							<c:when test="${myNOT.common_code eq 'NOT01'}">
								<img src="/resources/images/notification/siteNotIcon.png">
								Fundizzy 알림
							</c:when>
							<c:when test="${myNOT.common_code eq 'NOT02'}">
								<img src="/resources/images/notification/followingIcon.png">
								팔로잉 메이커 알림
							</c:when>
							<c:when test="${myNOT.common_code eq 'NOT03'}">
								<img src="/resources/images/notification/wishIcon.png">
								찜 프로젝트 알림
							</c:when>
							<c:when test="${myNOT.common_code eq 'NOT04'}">
								<img src="/resources/images/notification/myPorjectIcon.png">
								내 프로젝트 알림
							</c:when>
							<c:otherwise>
								<img src="/resources/images/notification/joinProjectIcon.png">
								참여 프로젝트 알림
							</c:otherwise>
						</c:choose>
					</div>
					<div class="notificationDate">
						${myNOT.regist_date}
					</div>
				</div>
				<div class="notificationBody">
					<div class="notificationContent">
						${myNOT.notification_content}
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
	<script src="/resourcex/js/service/my_notification_board.js"></script>
</body>
</html>