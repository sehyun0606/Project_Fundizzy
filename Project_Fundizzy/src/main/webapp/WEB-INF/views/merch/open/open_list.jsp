<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/open/fund_list.css">
<!-- js 연결 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/merch/open/fund_list.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
	    <div class="main-banner">
	    	 <div class="slide">
		        <img alt="img" src="https://cdn3.wadiz.kr/studio/images/2025/02/13/555f80e2-81d9-47d1-9a7d-e3534841b408.gif" data-src="https://cdn3.wadiz.kr/studio/images/2025/02/13/555f80e2-81d9-47d1-9a7d-e3534841b408.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="https://cdn3.wadiz.kr/studio/images/2025/02/20/efc81494-3d99-4f0c-92c5-f13f3f13e6ae.gif" alt="메인 이미지">
			</div>
			<div class="slide">
				<img src="https://cdn2.wadiz.kr/2022/06/09/514bb6eb-beed-4910-bae2-e3ecbbed454a.gif" alt="메인 이미지"> 
			</div>
			<div class="slide">
			    <img src="https://cdn3.wadiz.kr/studio/images/2025/02/17/4f9e156f-cdf0-42cc-9a7d-18ee839c89af.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="https://cdn3.wadiz.kr/studio/images/2025/03/10/e3242979-c639-4bfc-8187-70381e17c4f8.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="https://cdn2.wadiz.kr/2022/11/22/ee45d7ba-b7b2-4f51-aa68-f8f263a70321.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="	https://cdn2.wadiz.kr/2023/11/21/30005099-941c-4ddb-899e-97eaae082c7b.gif" alt="메인 이미지">
			</div>
	    </div>
		<div class="slide-button">
	        <button class="prev">&lt;</button>
		    <button class="next">&gt;</button>
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
<!-- 	제품들 출력 -->
	    <section class="product-list">
        	<c:forEach var="list" items="${openList}">
        		<div class="product">
        			<input type="hidden" class ="project_code" value="${list.project_code}">
		            <div class="product-img">${list.representative_picture}</div>
		            <div class="product-info">
		                <p class="discount">${list.progress}%</p>
		                <p class="name">${list.project_title}</p>
		            </div>
       			 </div>
        	</c:forEach>
	    </section>
	    
	    
	    
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>
