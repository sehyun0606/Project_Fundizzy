<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 알림설정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/service/notification/my_notification_set.css" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		<div id="title">
			알림설정
		</div>
		<div id="receivingMethod">
			<div class="notifications">
				<div class="subTitle">
					회원・서비스 이벤트 혜택 알림 동의<br>
					<div class="explanation">이벤트, 혜택 등에 대한 정보를 이메일, SMS, 사이트알림으로 받아 볼 수 있습니다.</div>	
				</div>
				<label class="switch">
				  <input type="checkbox" id="siteCheck">
				  <span class="slider"></span>
				</label>
			</div>
			<div class="notifications">
				<div class="methodName">E-mail 수신</div>
				<label class="switch">
				  <input type="checkbox" id="emailCheck">
				  <span class="slider"></span>
				</label>
			</div>
			<div class="notifications">
				<div class="methodName">SMS 수신</div>
				<label class="switch">
				  <input type="checkbox" id="smsCheck">
				  <span class="slider"></span>
				</label>
			</div>
		</div>
		<div id="desiredNotifications">
			<div class="subTitle">
				알림 수신 설정<br>
				<div class="explanation">수신할 알림 항목을 선택 해 주세요</div>	
			</div>
			<div class="receivingitems">
				<div class="receiveItemName">Fundizzy 알림<br>
					<div class="explanation">Fundizzy 관련 최신 소식을 받아보세요</div>	
				</div>
				<label class="switch">
				  <input type="checkbox" id="fundizzyCheck">
				  <span class="slider"></span>
				</label>
			</div>
			<div class="receivingitems">
				<div class="receiveItemName">팔로잉 Maker 알림<br>
					<div class="explanation">팔로잉하는 Maker의 새로운 소식을 받아보세요</div>	
				</div>
				<label class="switch">
				  <input type="checkbox" id="makerCheck">
				  <span class="slider"></span>
				</label>
			</div>
			<div class="receivingitems">
				<div class="receiveItemName">찜한 Project 알림<br>
					<div class="explanation">찜한 프로젝트의 최신 소식을 받아보세요</div>	
				</div>
				<label class="switch">
				  <input type="checkbox" id="projectCheck">
				  <span class="slider"></span>
				</label>
			</div>
			<div class="receivingitems">
				<div class="receiveItemName">My Project 알림<br>
					<div class="explanation">내가 등록한 프로젝트에 대한 업데이트를 받아보세요</div>	
				</div>
				<label class="switch">
				  <input type="checkbox" id="myProjectCheck">
				  <span class="slider"></span>
				</label>
			</div>
			<div class="receivingitems">
				<div class="receiveItemName">참여한 Project 알림<br>
					<div class="explanation">내가 참여한 프로젝트에 대한 업데이트를 받아보세요</div>	
				</div>
				<label class="switch">
				  <input type="checkbox" id="myJoinProjectCheck">
				  <span class="slider"></span>
				</label>
			</div>
		</div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>