<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설정</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/setting_main.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
<div class="main">
	<div class="settings-container">
		<h1 class="settings-title">설정</h1>
	
	    <!-- 프로필 정보 설정 -->
	    <div class="settings-section" onclick="location.href='ProfileSettings'">
	        <h2>프로필 정보 설정</h2>
	        <p>프로필 사진, 경력, 학력, 관심분야</p>
	    </div>
	
	    <!-- 기본 정보 설정 -->
	    <div class="settings-section" onclick="location.href='MemberInfo'">
	        <h2>기본 정보 설정</h2>
	        <p>이름, 이메일, 휴대폰, SNS 연동 등</p>
	    </div>
	
	    <!-- 비밀번호 등록 -->
	    <div class="settings-section" onclick="location.href='passwordSettings.jsp'">
	        <h2>비밀번호 등록</h2>
	        <p>계정 비밀번호 등록</p>
	    </div>
	
	    <!-- 알림 설정 -->
	    <div class="settings-section" onclick="location.href='NotificationSetPage'">
	        <h2>알림 설정</h2>
	        <p>혜택, 활동 소식 알림 설정</p>
	    </div>
	
	    <!-- 간편 결제 설정 -->
	    <div class="settings-section" onclick="location.href='ManageMyPaymentInfo'">
	        <h2>간편결제</h2>
	        <p>간편결제 설정</p>
	    </div>
	
	    <!-- 회원 탈퇴 -->
	    <div class="delete-account">
	        <a href="deleteAccount.jsp">회원 탈퇴</a>
	    </div>
	</div>
    
</div>

</body>
</html>
