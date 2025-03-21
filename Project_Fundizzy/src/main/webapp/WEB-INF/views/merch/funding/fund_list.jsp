<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_list.css">
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_default.css">
<!-- js 연결 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/merch/funding/fund_list.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
	    <div class="main-banner">
	    	 <div class="slide">
		        <img src="https://cdn3.wadiz.kr/studio/images/2025/02/19/8ce3d611-5f2d-4197-aea0-d6da6ff80d81.gif" alt="메인 이미지">
			</div>
			<div class="slide">
			    <img src="https://cdn3.wadiz.kr/studio/images/2025/02/11/31443868-d7c1-4f7a-a4e5-a8cbdfc3f6af.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="https://cdn3.wadiz.kr/studio/images/2025/02/19/786010d7-ac7a-4056-8157-0612d9041e94.gif" alt="메인 이미지">
			</div>
			<div class="slide">
				<img src="https://cdn3.wadiz.kr/studio/images/2025/02/24/9357fcf1-40d5-4609-8dda-26c0be0757d1.gif" alt="메인 이미지"> 
			</div>
			<div class="slide">
		    	<img src="https://cdn3.wadiz.kr/studio/images/2025/02/24/6e4f7f4c-2588-41a8-ae95-90b738a3d4b8.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="https://cdn3.wadiz.kr/studio/images/2025/03/05/72a0eb61-021f-4380-a8c9-df663f2f77d1.gif" alt="메인 이미지">
			</div>
			<div class="slide">
		    	<img src="https://cdn3.wadiz.kr/studio/images/2025/03/06/ba6d1480-9e6a-44ca-ba67-89ab0d6ae641.jpg/wadiz/resize/1200/format/jpg/quality/80/" alt="메인 이미지">
			</div>
			
	    </div>
		<div class="slide-button">
	        <button class="prev">&lt;</button>
		    <button class="next">&gt;</button>
		</div>
	    <nav class="category-nav">
		    <button onclick="location.href='/FundList'"><img alt="" src="resources/images/list/all.png">전체</button>
		    <button onclick="location.href='/FundList?cat=electric'"><img alt="" src="resources/images/list/electronic.png">테크·가전</button>
		    <button onclick="location.href='/FundList?cat=fashion'"><img alt="" src="resources/images/list/fashion.png">패션</button>
		    <button onclick="location.href='/FundList?cat=beauty'"><img alt="" src="resources/images/list/beauty.png">뷰티</button>
		    <button onclick="location.href='/FundList?cat=furniture'"><img alt="" src="resources/images/list/home.png">홈·리빙</button>
		    <button onclick="location.href='/FundList?cat=sports'"><img alt="" src="resources/images/list/sports.png">스포츠</button>
		    <button onclick="location.href='/FundList?cat=food'"><img alt="" src="resources/images/list/food.png">푸드</button>
		    <button onclick="location.href='/FundList?cat=book'"><img alt="" src="resources/images/list/book.png">도서</button>
		    <button onclick="location.href='/FundList?cat=electricBook'"name="e-book"><img alt="" src="resources/images/list/ebook.png">전자책·클래스</button>
		    <button onclick="location.href='/FundList?cat=animal'"><img alt="" src="resources/images/list/pet.png">반려동물</button>
		    <button onclick="location.href='/FundList?cat=art'"><img alt="" src="resources/images/list/art.png">아트</button>
		    <button onclick="location.href='/FundList?cat=charactor'"><img alt="" src="resources/images/list/character.png">캐릭터·굿즈</button>
		    <button onclick="location.href='/FundList?cat=movieMusic'"><img alt="" src="resources/images/list/movie.png">영화·음악</button>
	    </nav>
		<hr>
	    <div class="filter-nav">
	    	<select id="selectall" name="selectall">
	    		<option value="ing">진행중</option>
	    		<option value="all">전체</option>
	    		<option value="fin">종료된</option>
	    	</select>
	        <button>추천순</button>
	        <button>인기순</button>
	        <button>최신순</button>
	        <button>마감임박순</button>
	    </div>
<!-- 	제품들 출력 -->
	    <section class="product-list">
        	<c:forEach var="list" items="${fundList}">
        		<div class="product">
        			<input type="hidden" class ="project_code" value="${list.project_code}">
		            <img class="product-img" src="${list.representative_picture}">
		            <div class="product-info">
		                <p class="discount">${list.progress}% 달성!</p>
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
