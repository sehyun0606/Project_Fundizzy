<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 정보 설정</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/profile_settings.css">
</head>

<body>
<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
<div class="main">
<div class="profile-container">
    <h1 class="profile-title">프로필 정보 설정</h1>

    <!-- 프로필 이미지 업로드 -->
    <div class="profile-image-section">
        <div class="profile-image-placeholder">
            <img src="default-profile.png" alt="프로필 이미지">
        </div>
        <div class="profile-buttons">
            <button class="upload-btn">등록하기</button>
            <button class="delete-btn">삭제하기</button>
        </div>
    </div>

    <!-- 관심사 선택 -->
    <div class="interest-section">
        <h2>관심사</h2>
        <p class="sub-text">최소 1개 이상 관심사를 선택해주세요.</p>
        <div class="interest-grid">
            <span class="interest-item">📌 교육·키즈</span>
            <span class="interest-item">📌 홈리빙·디자인소품</span>
            <span class="interest-item">📌 스포츠·모빌리티</span>
            <span class="interest-item">📌 반려동물</span>
            <span class="interest-item">📌 패션·잡화·뷰티</span>
            <span class="interest-item">📌 공연·전시</span>
            <span class="interest-item">📌 출판</span>
            <span class="interest-item">📌 테크·가전</span>
        </div>
    </div>

    <!-- 입력 필드 -->
    <div class="input-section">
        <label>회사 / 직책</label>
        <div class="input-group">
            <input type="text" placeholder="회사">
            <input type="text" placeholder="직책">
        </div>

        <label>학교 / 전공</label>
        <div class="input-group">
            <input type="text" placeholder="학교">
            <input type="text" placeholder="전공">
        </div>

        <label>간단한 한 마디로 나를 소개해주세요</label>
        <textarea placeholder=""></textarea>
    </div>

    <!-- 버튼 -->
    <div class="button-group">
        <button class="cancel-btn">취소</button>
        <button class="confirm-btn">확인</button>
    </div>
</div>
</div>
</body>
</html>
