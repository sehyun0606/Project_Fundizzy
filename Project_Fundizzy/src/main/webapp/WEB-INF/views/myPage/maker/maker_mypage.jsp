<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 대시보드</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="dashboard-container">
    
    <!-- 좌측 사이드바 -->
    <aside class="sidebar">
        <div class="profile-section">
            <img src="profile.jpg" alt="프로필 사진" class="profile-img">
            <p class="username">민기님</p>
            <a href="#" class="edit-profile">프로필 수정</a>
        </div>
        
        <nav class="menu">
            <ul>
                <li><a href="#">🏠 홈</a></li>
                <li><a href="#">📂 내 프로젝트</a></li>
                <li><a href="#">💰 후원 내역</a></li>
                <li><a href="#">❤️ 찜한 상품</a></li>
                <li><a href="#">🔔 알림 설정</a></li>
                <li><a href="#">📞 고객센터</a></li>
                <li><a href="#">⚙ 설정</a></li>
            </ul>
        </nav>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
        
        <!-- 상단 프로필 정보 -->
        <section class="user-info">
            <h2>민기님 안녕하세요</h2>
            <p>정말 깔끔하고 완벽한 페이지입니다.</p>
            <div class="user-stats">
                <div class="stat-item">
                    <p>장바구니</p><span>2</span>
                </div>
                <div class="stat-item">
                    <p>자식기부</p><span>1</span>
                </div>
                <div class="stat-item">
                    <p>찜한상품</p><span>7</span>
                </div>
                <div class="stat-item">
                    <p>알림설정</p><span>108</span>
                </div>
            </div>
        </section>

        <!-- 최근 본 프로젝트 -->
        <section class="recent-projects">
            <h3>최근 본 프로젝트</h3>
            <div class="project-list">
                <div class="project-card">100% 달성</div>
                <div class="project-card">75% 달성</div>
                <div class="project-card">95% 달성</div>
            </div>
        </section>

        <!-- 추천 상품 -->
        <section class="recommended-products">
            <h3>민기님을 위한 특별한 상품</h3>
            <div class="product-list">
                <div class="product-card">100% 달성</div>
                <div class="product-card">75% 달성</div>
                <div class="product-card">90% 달성</div>
                <div class="product-card">95% 달성</div>
            </div>
        </section>

        <!-- 확인해 보세요 -->
        <section class="info-section">
            <h3>확인해 보세요</h3>
            <div class="info-list">
                <div class="info-card">크라우드 펀딩이란?</div>
                <div class="info-card">크라우드 펀딩 실제 사례</div>
            </div>
        </section>
        
    </main>
</div>

</body>
</html>
