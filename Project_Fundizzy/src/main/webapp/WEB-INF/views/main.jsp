<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy</title>
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
	    <div class="main-banner">
	        <div class="banner-box"></div>
	        <div class="banner-box"></div>
	        <div class="banner-box"></div>
	    </div>
	
	    <nav class="category-nav">
		    <button><img alt="" src="resources/images/list/all.png">전체</button>
		    <button><img alt="" src="resources/images/list/electronic.png">테크·가전</button>
		    <button><img alt="" src="resources/images/list/fashion.png">패션</button>
		    <button><img alt="" src="resources/images/list/beauty.png">뷰티</button>
		    <button><img alt="" src="resources/images/list/home.png">홈·리빙</button>
		    <button><img alt="" src="resources/images/list/sports.png">스포츠</button>
		    <button><img alt="" src="resources/images/list/food.png">푸드</button>
		    <button><img alt="" src="resources/images/list/book.png">도서</button>
		    <button name="e-book"><img alt="" src="resources/images/list/ebook.png">전자책·클래스</button>
		    <button><img alt="" src="resources/images/list/design.png">디자인</button>
		    <button><img alt="" src="resources/images/list/pet.png">반려동물</button>
		    <button><img alt="" src="resources/images/list/art.png">아트</button>
		    <button><img alt="" src="resources/images/list/character.png">캐릭터·굿즈</button>
		    <button><img alt="" src="resources/images/list/movie.png">영화·음악</button>
	    </nav>
		<hr>
	    <div class="filter-nav">
	    	<select id="selectall" name="selectall">
	    		<option value="all">전체</option>
	    		<option value="ing">진행중</option>
	    		<option value="fin">종료된</option>
	    	</select>
	        <button>추천순</button>
	        <button>인기순</button>
	        <button>최신순</button>
	        <button>마감임박순</button>
	    </div>
	
	    <section class="product-list">
	        <div class="product">
	            <div class="product-img"></div>
	            <div class="product-info">
	                <p class="discount">4,541%달성 </p>
	                <p class="name">[엑스트라 얼리버드] 티타늄 텀블러 싱글</p>
	                <p class="rating">⭐ 4.7(148)</p>
	            </div>
	        </div>
	        <div class="product">
	            <div class="product-img"></div>
	            <div class="product-info">
	                <p class="discount">41%달성 29600원</p>
	                <p class="name">[엑스트라 얼리버드] 티타늄 텀블러 싱글</p>
	                <p class="rating">⭐ 4.7(148)</p>
	            </div>
	        </div>
	        <div class="product">
	            <div class="product-img"></div>
	            <div class="product-info">
	                <p class="discount">41%달성 29600원</p>
	                <p class="name">[엑스트라 얼리버드] 티타늄 텀블러 싱글</p>
	                <p class="rating">⭐ 4.7(148)</p>
	            </div>
	        </div>
	        <div class="product">
	            <div class="product-img"></div>
	            <div class="product-info">
	                <p class="discount">41%달성 29600원</p>
	                <p class="name">[엑스트라 얼리버드] 티타늄 텀블러 싱글</p>
	                <p class="rating">⭐ 4.7(148)</p>
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
    </script>
</body>
</html>