<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설정</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/myPage/supporter/setting_main.css">
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
	
<!-- 	    비밀번호 등록 -->
<!-- 	    <div class="settings-section" onclick="location.href='PasswordSettings'"> -->
<!-- 	        <h2>비밀번호 등록</h2> -->
<!-- 	        <p>계정 비밀번호 등록</p> -->
<!-- 	    </div> -->
	
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
	        <a id="openModal">회원 탈퇴</a>
	    </div>
	</div>
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h2>회원탈퇴</h2>
           	<div class="model-text">
           		<h4>탈퇴시 유의사항</h4>
           		<p>회원탈퇴가 완료되면 아래와 같이 진행됩니다</p>
           		<p>탈퇴 후 계정의 모든 정보가 삭제됩니다</p>
           		<p>탈퇴한 계정은 재사용할 수 없습니다</p>
           		<p>탈퇴후 작성한 모든 개시글은 수정,삭제가 불가능합니다</p>
           	</div>
           	<div class="check-section">
	           	<label for="withdraw-check">상기 내용을 이해했습니다</label>
	           	<input type="checkbox" class="withdraw-check">
           	</div>
           	<button class="withdraw">탈퇴하기</button>
        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    // 모달 열기
    $("#openModal").click(function() {
        $("#myModal").fadeIn();
    });

    // 모달 닫기 (X 버튼)
    $(".close-btn").click(function() {
        $("#myModal").fadeOut();
    });

    // 모달 바깥 영역 클릭 시 닫기
    $(window).click(function(event) {
        if ($(event.target).is("#myModal")) {
            $("#myModal").fadeOut();
        }
    });
    $(".withdraw").prop("disabled", true);

    // 체크박스 상태 변경 시 이벤트 처리
    $(".withdraw-check").change(function() {
        if ($(this).is(":checked")) {
            $(".withdraw").prop("disabled", false); 
        } else {
            $(".withdraw").prop("disabled", true); 
        }
    });
    
    $(".withdraw").click(function(){
    	location.href="MemberWithdraw";
    });
});
	
</script>
</body>
</html>
