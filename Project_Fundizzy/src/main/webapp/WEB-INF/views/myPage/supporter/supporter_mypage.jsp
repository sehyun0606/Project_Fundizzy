<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 대시보드</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/supporter_mypage.css">
<body>


<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>


<div class="container">

	<div >
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>

	</div>
    
    <!-- 메인 콘텐츠 -->
    <main class="main-content">
        
            <h2>(사용자성명자리) 님 안녕하세요 - 서포터 마이 페이지</h2> 
            <p></p>
            
            

        <div class="user-info-container"> 
	        <!-- 상단 프로필 정보 -->
	        <section class="user-info">
	            <div class="user-stats">
	                <div class="stat-item1">
	                	<img class="icon" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-cart-709782.png">
	                    <a href="FundingProd">펀딩</a><span>횟수</span>
	                </div>
	                <div class="stat-item2">
	                	<img class="icon2" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-business-people-8452029.png">
	                    <a href="SupporterPage">지지서명</a><span>횟수</span>
	                </div>
	                <div class="stat-item3">
	                	<img class="icon" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-heart-shape-outline-25424.png">
	                    <a href="SupporterPage">찜한상품</a><span>횟수</span>
	                </div>
	                <div class="stat-item4">
	                	<img class="icon" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-bell-alarm-7887462.png">
	                    <a href="SupporterPage">알림설정</a><span>횟수</span>
	                </div>
	            </div>    
	        </section>
	
	</div>



        <!-- 최근 본 프로젝트 -->
        <section class="recent-projects">
            <h3>최근 본 프로젝트</h3>
            <div class="project-list">
                <div class="project-card">상품 이미지와 정보 하트아이콘 가져오기</div>
                <div class="project-card"></div>
                <div class="project-card"></div>
                <div class="project-card"></div>
            </div>
        </section>

        <!-- 추천 상품 -->
        <section class="recommended-products">
            <h3>00님을 위한 특별한 상품</h3>
            <div class="product-list">
                <div class="product-card">상품 이미지와 정보 하트아이콘 가져오기</div>
                <div class="product-card"></div>
                <div class="product-card"></div>
                <div class="product-card"></div>
            </div>
        </section>

        <!-- 확인해 보세요 -->
        <section class="info-section">
            <h3>확인해 보세요</h3>
            <div class="info-list">
                <div class="info-card">광고 영역1</div>
                <div class="info-card">광고 영역2</div>
            </div>
        </section>
        
        
        <section class="blank-part"></section>
        
    </main>
    
</div>

<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>


</body>
</html>
