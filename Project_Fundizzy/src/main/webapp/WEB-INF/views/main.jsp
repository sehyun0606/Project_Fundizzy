<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- 		        <div class="category-selector"> -->
<!-- 		            <span class="category-number">6</span> -->
<!-- 		            <span class="category-text">보조배터리</span> -->
<!-- 		            <i class="fas fa-chevron-down dropdown-icon"></i> -->
<!-- 		        </div> -->
		    </div>
		</section>
	
	    <!-- ✅ 카테고리 리스트 -->
	    <section class="category-section">
	        <div class="category-container">
	            <div class="category-list">
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2024:10:11:15846656-cd1a-4c10-8825-8812f95aee64.png" alt="슈퍼러브">
	                    <p>슈퍼러브</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2025:03:10:704ed1fb-0790-4721-9c50-c9fc483f91f1.png" alt="무료 피부 분석">
	                    <p>무료 피부완성</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2025:03:06:d0aa72df-efb1-44a1-9c2e-cce272bc3127.png" alt="와디즈 에디션">
	                    <p>와디즈에디션</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2024:08:22:59c29447-2e0e-46b1-bd4d-d029e1b1d097.png" alt="냄새없는 패드">
	                    <p>냄새없는패드</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2025:03:05:a41ef24a-f65a-40f5-a393-74c25f832dcc.png" alt="한입 샐러드">
	                    <p>한입샐러드</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2025:02:28:fe36ff8d-9566-4351-9dcb-3c60f883ec25.png" alt="우리집 꾸미기">
	                    <p>우리집꾸미기</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2025:03:17:a307a45f-8969-4eb0-836d-f83bb5d29f59.png" alt="클린 플라이스">
	                    <p>클린프라이스</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2025:03:11:62f39c8a-cbf7-43e0-844a-0c448158fea9.png" alt="마감임박">
	                    <p>마감임박</p>
	                </div>
	                <div class="category-item">
	                    <img src="https://cdn3.wadiz.kr/main/quickmenu/2024:06:10:90e92565-0f67-4564-946a-b57ab1807ab1.png" alt="펀딩 체험단">
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
		        	<c:forEach var="cg" items="${category}">
			            <span onclick="location.href='FundList?cat=${cg.code_name}'">${cg.code_name}</span>
		        	</c:forEach>
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
		                <c:forEach var="pRl" items="${projectRandomList }" begin="0" end="5">
		                    <img src="https://cdn.wadiz.kr/ft/images/live-adm02/2025/0314/20250314180051256_7746.jpg/wadiz/resize/900/format/jpg/quality/85/" class="banner-img" alt="배너 이미지">
		                    <button class="banner-prev">&lt;</button>
		                    <button class="banner-next">&gt;</button>
		                </c:forEach>
	                </div>
	            </section>
	
	            <!-- ✅ 취향 맞춤 프로젝트 -->
	            <section class="custom-project-section">
	                <h2>취향 맞춤 프로젝트</h2>
	                <div class="project-list">
		                <c:forEach var="pRl" items="${projectRandomList }" begin="0" end="8">
		                    <div class="project-item">
		                        <img src="${pRl.representative_picture}" alt="프로젝트1" onclick="location.href='FundBoardStory?project_code=${pRl.project_code}'">
		                        <p class="rank-highlight">
		                        	<fmt:formatNumber value="${pRl.progress}" type="number"/>% 달성!
		                        </p>
		                        <span>${pRl.project_title}</span>
		                    </div>
	                    </c:forEach>
	                </div>
	            </section>
	        </div>
	        <div class="divider2"></div>
	
	        <!-- ✅ 오른쪽: 실시간 랭킹 -->
	        <aside class="ranking-section">
	            <h2>실시간 랭킹</h2>
	            <div class="ranking-tabs">
	                <span class="active">펀딩/프리오더</span>
	            </div>
	            <ul class="ranking-list">
	            	<c:forEach var="ppl" items="${projectProgressList }" varStatus="status" begin="0" end="7">
	                	<li onclick="location.href='FundBoardStory?project_code=${ppl.project_code}'">
		                    <span class="rank-number">${status.index + 1}</span>
		                    <div class="rank-content">
		                        <p>${ppl.project_title}</p>
		                        <span class="rank-highlight">
		                        	<fmt:formatNumber value="${ppl.progress}" type="number"/>% 달성!
		                        	<input type="hidden" value="${ppl.project_code }">
		                        </span>
		                    </div>
		                    <img src="${ppl.representative_picture}" alt="순위1">
		                </li>
	                </c:forEach>
	            </ul>
	            <!-- 🔹 실시간 랭킹 아래 배너 영역 -->
				<section class="ranking-banner-section">
				    <div class="ranking-banner">
				        <img src="https://cdn2.wadiz.kr/2024/07/23/8c71eb8d-9c9a-47fd-ad26-1c46d3e4e959.png/wadiz/resize/400/format/jpg/quality/85/&quot;" alt="와디즈 체험단 이벤트">
				        <div class="banner-text">
				            <span class="badge">기획전</span>
				        </div>
				    </div>
				    <div class="ranking-banner">
				        <img src="https://cdn.wadiz.kr/ft/images/green001/2024/0723/20240723144319342_null.png/wadiz/resize/400/format/jpg/quality/85/&quot;" alt="출판 제작비 지원">
				        <div class="banner-text">
				        </div>
				    </div>
				</section>
	        </aside>
	    </div>

		<div class="divider1"></div> 	
	    
	    <!-- ✅ 트렌드 섹션 -->
		<section class="trend-section">
		    <h2 class="trend-title">트렌드</h2>
		
		    <div class="trend-wrapper">
		        <!-- 🔹 급상승 프로젝트 -->
		        <div class="trend-category">
		            <h3><span style="color: mediumpurple;">#급상승</span> 프로젝트</h3>
		            <div class="trend-list">
		            	<c:forEach var="pl" items="${projectList }" begin="0" end="5">
			                <div class="trend-item">
			                    <img src="${pl.representative_picture}" alt="프로젝트 이미지">
			                    <p class="trend-success">
			                    	<fmt:formatNumber value="${pl.progress}" type="number"/>% 달성!
			                    </p>
			                    <span>${pl.project_title}</span>
			                </div>
		            	</c:forEach>
		            </div>
		        </div>
		
		        <!-- 🔹 세로 구분선 -->
		        <div class="divider-trend"></div>
		
		        <!-- 🔹 사람들이 좋아한 프로젝트 -->
		        <div class="trend-category">
		            <h3>오늘 가장 많은 사람들이 <span style="color: mediumpurple;">#좋아한</span> 프로젝트</h3>
		            <div class="trend-list">
		                <c:forEach var="pll" items="${projectLikeList }" begin="0" end="5">
			                <div class="trend-item">
			                    <img src="${pll.representative_picture}" alt="프로젝트 이미지">
			                    <p class="trend-success">
			                    	<fmt:formatNumber value="${pll.progress}" type="number"/>% 달성!
			                    </p>
			                    <span>${pll.project_title}</span>
			                </div>
		            	</c:forEach>
		            </div>
		        </div>
		
		        <!-- 🔹 세로 구분선 -->
		        <div class="divider-trend"></div>
		
		        <!-- 🔹 지지서명한 프로젝트 -->
		        <div class="trend-category">
		            <h3>오늘 가장 많은 사람들이 <span style="color: mediumpurple;">#지지서명한</span> 프로젝트</h3>
		            <div class="trend-list">
		                <c:forEach var="pRl" items="${projectRandomList }" begin="0" end="5">
			                <div class="trend-item">
			                    <img src="${pRl.representative_picture}" alt="프로젝트 이미지">
			                    <p class="trend-success">
			                    	<fmt:formatNumber value="${pRl.progress}" type="number"/>% 달성!
			                    </p>
			                    <span>${pRl.project_title}</span>
			                </div>
		            	</c:forEach>
		            </div>
		        </div>
		    </div>
		</section>


			    
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