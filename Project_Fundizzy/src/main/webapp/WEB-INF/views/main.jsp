<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy</title>
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/main_top.jsp" />
	</header>
	<article class="main-container">
	    <!-- ✅ 검색 바 -->
	   	<section class="search-section">
		    <div class="search-container">
		        <!-- ✅ 검색 바 -->
				<div class="search-box">
				    <input type="text" class="search-input" placeholder="검색">
				    <i class="fas fa-search search-icon"></i> <!-- ✅ 돋보기 아이콘 추가 -->
				</div>

		
		        <!-- ✅ 검색 바 옆 카테고리 (숫자 + 텍스트 + 화살표) -->
		        <div class="category-selector">
		            <span class="category-number">6</span>
		            <span class="category-text">보조배터리</span>
		            <i class="fas fa-chevron-down dropdown-icon"></i>
		        </div>
		    </div>
		</section>
	
	    <!-- ✅ 카테고리 리스트 -->
	    <section class="category-section">
	        <div class="category-container">
	            <div class="category-list">
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="슈퍼러브">
	                    <p>슈퍼러브</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="무료 피부 분석">
	                    <p>무료 피부완성</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="와디즈 에디션">
	                    <p>와디즈에디션</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="냄새없는 패드">
	                    <p>냄새없는패드</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="한입 샐러드">
	                    <p>한입샐러드</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="우리집 꾸미기">
	                    <p>우리집꾸미기</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="클린 플라이스">
	                    <p>클린프라이스</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="마감임박">
	                    <p>마감임박</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="이벤트 추천">
	                    <p>이벤트추천</p>
	                </div>
	                <div class="category-item">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" alt="펀딩 체험단">
	                    <p>펀딩체험단</p>
	                </div>
	            </div>
	        </div>
	    </section>
	
	    <!-- ✅ 하위 카테고리 -->
	    <section class="sub-category-section">
		    <button class="sub-scroll-btn left">&lt;</button>
		    <div class="sub-category-wrapper">
		        <div class="sub-category">
		            <span>테크·가전</span>
		            <span>패션</span>
		            <span>뷰티</span>
		            <span>홈·리빙</span>
		            <span>스포츠·아웃도어</span>
		            <span>푸드</span>
		            <span>도서</span>
		            <span>전자책·클래스</span>
		            <span>디자인</span>
		            <span>반려동물</span>
		            <span>아트</span>
		            <span>캐릭터·굿즈</span>
		            <span>영화·음악</span>
		            <span>키즈</span>
		            <span>키즈</span>
		            <span>키즈</span>
		            <span>키즈</span>
		            <span>키즈</span>
		            <span>키즈</span>
		            <span>키즈</span>
		            <span>키즈</span>
		        </div>
		    </div>
		    <button class="sub-scroll-btn right">&gt;</button>
		</section>
		<!-- ✅ 연한 회색 구분선 -->
		<div class="divider1"></div> 	
	    <!-- ✅ 여기에 계속 새로운 요소 추가 가능 -->
		<div class="content-wrapper">
	        <!-- ✅ 왼쪽: 배너 + 취향 맞춤 프로젝트 -->
	        <div class="left-content">
	            <!-- ✅ 배너 -->
	            <section class="banner-section">
	                <div class="banner-container">
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_04.jpg" class="banner-img" alt="배너 이미지">
	                    <button class="banner-prev">&lt;</button>
	                    <button class="banner-next">&gt;</button>
	                </div>
	            </section>
	
	            <!-- ✅ 취향 맞춤 프로젝트 -->
	            <section class="custom-project-section">
	                <h2>취향 맞춤 프로젝트</h2>
	                <p>지금 함께 만드는 성공</p>
	                <div class="project-list">
	                    <div class="project-item">
	                        <img src="/resources/images/main/KakaoTalk_20241113_223306690_10.jpg" alt="프로젝트1">
	                        <p class="rank-highlight">42% 달성</p>
	                        <span>커피 애호가를 위한 특별한 경험!</span>
	                    </div>
	                    <div class="project-item">
	                        <img src="/resources/images/main/KakaoTalk_20241113_223306690_10.jpg" alt="프로젝트2">
	                        <p class="rank-highlight">3,302% 달성</p>
	                        <span>고카페인 콜드브루 커피</span>
	                    </div>
	                    <div class="project-item">
	                        <img src="/resources/images/main/KakaoTalk_20241113_223306690_10.jpg" alt="프로젝트3">
	                        <p class="rank-highlight">16,662% 달성</p>
	                        <span>대용량 앵콜! 스마트한 주방 필수템</span>
	                    </div>
	                    <div class="project-item">
	                        <img src="/resources/images/main/KakaoTalk_20241113_223306690_10.jpg" alt="프로젝트3">
	                        <p class="rank-highlight">16,662% 달성</p>
	                        <span>대용량 앵콜! 스마트한 주방 필수템</span>
	                    </div>
	                </div>
	            </section>
	        </div>
	        <div class="divider2"></div>
	
	        <!-- ✅ 오른쪽: 실시간 랭킹 -->
	        <aside class="ranking-section">
	            <h2>실시간 랭킹</h2>
	            <div class="ranking-tabs">
	                <span class="active">펀딩/프리오더</span>
	                <span>스토어</span>
	            </div>
	            <ul class="ranking-list">
	                <li>
	                    <span class="rank-number">1</span>
	                    <div class="rank-content">
	                        <p>[1.7억] 속눈썹 램핑밤</p>
	                        <span class="rank-highlight">13,622% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위1">
	                </li>
	                <li>
	                    <span class="rank-number">2</span>
	                    <div class="rank-content">
	                        <p>미친 개발자의 555만톤 세럼</p>
	                        <span class="rank-highlight">351명 참여</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위2">
	                </li>
	                <li>
	                    <span class="rank-number">3</span>
	                    <div class="rank-content">
	                        <p>비싼 시술 왜 해? 미백팩!</p>
	                        <span class="rank-highlight">4,582% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위3">
	                </li>
	                <li>
	                    <span class="rank-number">3</span>
	                    <div class="rank-content">
	                        <p>비싼 시술 왜 해? 미백팩!</p>
	                        <span class="rank-highlight">4,582% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위3">
	                </li>
	                <li>
	                    <span class="rank-number">3</span>
	                    <div class="rank-content">
	                        <p>비싼 시술 왜 해? 미백팩!</p>
	                        <span class="rank-highlight">4,582% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위3">
	                </li>
	                <li>
	                    <span class="rank-number">3</span>
	                    <div class="rank-content">
	                        <p>비싼 시술 왜 해? 미백팩!</p>
	                        <span class="rank-highlight">4,582% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위3">
	                </li>
	                <li>
	                    <span class="rank-number">3</span>
	                    <div class="rank-content">
	                        <p>비싼 시술 왜 해? 미백팩!</p>
	                        <span class="rank-highlight">4,582% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위3">
	                </li>
	                <li>
	                    <span class="rank-number">3</span>
	                    <div class="rank-content">
	                        <p>비싼 시술 왜 해? 미백팩!</p>
	                        <span class="rank-highlight">4,582% 달성</span>
	                    </div>
	                    <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="순위3">
	                </li>
	            </ul>
	            <!-- 🔹 실시간 랭킹 아래 배너 영역 -->
				<section class="ranking-banner-section">
				    <div class="ranking-banner">
				        <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="와디즈 체험단 이벤트">
				        <div class="banner-text">
				            <span class="badge">기획전</span>
				        </div>
				    </div>
				    <div class="ranking-banner">
				        <img src="/resources/images/main/KakaoTalk_20241113_223306690_12.jpg" alt="출판 제작비 지원">
				        <div class="banner-text">
				        </div>
				    </div>
				</section>
	        </aside>
	    </div>
	    
	</article>



	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
	
	<script>
		let secretCode = "adminpage";  // 관리자 코드
		let inputSequence = "";  // 사용자가 입력한 시퀀스
		let adminWindow = null;  // 관리자 페이지 창 객체
	
		document.addEventListener('keydown', function(event) {
		    inputSequence += event.key;
	
		    if (inputSequence == secretCode) {
		        // "adminpage"가 입력되면 새 창으로 관리자 페이지 열기
		        if (adminWindow == null || adminWindow.closed) {
		            adminWindow = window.open('adminPageLoginNoInputUser', '_blank');  // 새 창으로 관리자 페이지 열기
		        } else {
		            adminWindow.focus();  // 기존 창으로 포커스 이동
		        }
				
		        inputSequence = "";
		        // 기본 동작 방지 (페이지 리로드 방지)
		        event.preventDefault();
		    }
	
		    // 너무 긴 문자열은 초기화
		    if (inputSequence.length > secretCode.length) {
		        inputSequence = inputSequence.slice(-secretCode.length);
		    }
		});
		
		// 서브 카테고리 스크롤
		document.addEventListener("DOMContentLoaded", function() {
		    const subCategoryWrapper = document.querySelector(".sub-category-wrapper");
		    const leftBtn = document.querySelector(".sub-scroll-btn.left");
		    const rightBtn = document.querySelector(".sub-scroll-btn.right");
		
		    function updateButtons() {
		        const scrollLeft = subCategoryWrapper.scrollLeft;
		        const maxScrollLeft = subCategoryWrapper.scrollWidth - subCategoryWrapper.clientWidth;
		
		        // 🚀 왼쪽 끝이면 `<` 버튼 숨김
		        if (scrollLeft <= 0) {
		            leftBtn.style.display = "none";
		        } else {
		            leftBtn.style.display = "block";
		        }
		
		        // 🚀 오른쪽 끝이면 `>` 버튼 숨김
		        if (scrollLeft >= maxScrollLeft - 1) {
		            rightBtn.style.display = "none";
		        } else {
		            rightBtn.style.display = "block";
		        }
		    }
		
		    // ✅ 처음 로딩 시 왼쪽 정렬 유지 & 버튼 업데이트
		    subCategoryWrapper.scrollLeft = 0;
		    updateButtons();
		
		    // ✅ 스크롤할 때마다 버튼 업데이트
		    subCategoryWrapper.addEventListener("scroll", updateButtons);
		
		    // ✅ 버튼 클릭 시 처음 또는 끝으로 이동 (부드러운 스크롤)
		    leftBtn.addEventListener("click", () => {
		        subCategoryWrapper.scrollTo({ left: 0, behavior: "smooth" });
		    });
		
		    rightBtn.addEventListener("click", () => {
		        const maxScrollLeft = subCategoryWrapper.scrollWidth - subCategoryWrapper.clientWidth;
		        subCategoryWrapper.scrollTo({ left: maxScrollLeft, behavior: "smooth" });
		    });
		});



    </script>
</body>
</html>