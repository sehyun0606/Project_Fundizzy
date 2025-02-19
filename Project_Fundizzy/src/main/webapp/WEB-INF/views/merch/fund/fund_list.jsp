<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_list.css">
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
		    <button>전체</button>
		    <button>테크·가전</button>
		    <button>패션</button>
		    <button>뷰티</button>
		    <button>홈·리빙</button>
		    <button>스포츠</button>
		    <button>푸드</button>
		    <button>도서</button>
		    <button name="e-book">전자책·클래스</button>
		    <button>디자인</button>
		    <button>반려동물</button>
		    <button>아트</button>
		    <button>캐릭터·굿즈</button>
		    <button>영화·음악</button>
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
</body>
</html>
