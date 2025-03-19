<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩새소식-글</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/open/fund_board_new_board.css">
<link rel="stylesheet" type="text/css" href="resources/css/merch/open/open_default.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		<div class="fund-top">
	        <a href="OpenBoardStory" class="story">스토리</a>
	        <a href="OpenBoardNew" class="new">새소식</a>
	        <a href="OpenBoardSupport" class="support">지지서명</a>
	 	</div>
	    <hr>
    <div class="container">
        <div class="content-left">
            <div class="project-story">
               <button class="list-btn">목록으로 이동</button>
                <p>앵콜펀딩 + 1차 펀딩 서포터분들의 리얼리뷰</p>
                2025.2.12
                <img src="story.jpg" alt="프로젝트 스토리 이미지">
            </div>
            <div class="product-list">
                <h3>펀딩/프리오더 베스트 프로젝트</h3>
               <div class="image-group">
                   <div>
                       <img src="rec1.jpg" alt="추천 프로젝트 1">
                       <div class="product-info">
                         <p class="discount">4,541%달성 </p>
                         <p class="name">[4차앵콜] 티타늄 텀블러 싱글</p>
                         <p class="rating">⭐ 4.7(148)</p>
                     </div>
                  </div>
                   <div>
                       <img src="rec1.jpg" alt="추천 프로젝트 2">
                       <div class="product-info">
                         <p class="discount">4,541%달성 </p>
                         <p class="name">[4차앵콜] 티타늄 텀블러 싱글</p>
                         <p class="rating">⭐ 4.7(148)</p>
                     </div>
                  </div>
                   <div>
                       <img src="rec1.jpg" alt="추천 프로젝트 3">
                       <div class="product-info">
                         <p class="discount">4,541%달성 </p>
                         <p class="name">[4차앵콜] 티타늄 텀블러 싱글</p>
                         <p class="rating">⭐ 4.7(148)</p>
                     </div>
                  </div>
                   <div>
                       <img src="rec1.jpg" alt="추천 프로젝트 4">
                       <div class="product-info">
                         <p class="discount">4,541%달성 </p>
                         <p class="name">[4차앵콜] 티타늄 텀블러 싱글</p>
                         <p class="rating">⭐ 4.7(148)</p>
                     </div>
                  </div>
                </div>
            </div>
        </div>
        <div class="content-right">
            <div class="purchase-section">
                <h3>[소재혁명] 빈틈없는 편안함! 고온세척&건조 가능한 반영구 통실리콘 베개</h3>
                <div class="purchase-content">
                   이렇게 목과 머리를 제대로 잡아주는데, 심지어 스팀 살균, 건조기까지 사용이 가능하다구? 해외에서 각광받는 베개,
                   22년 침구 기술력을 온전히 담아낸 통실리콘 베개를 소개합니다. 
                </div>
                <p><strong>139</strong>명 참여</p>
                <p><strong>50,000</strong>원 달성</p>
                <div class="btn-group">
                   <button class="btn-small">♡찜</button>
                   <button class="btn-small">지지</button>
                   <button class="purchase-btn">예약구매하기</button>
                </div>
            </div>
            <div class="project-info">
                 <div class="project-info">
	                <div class="company-info">
	                   <h4>${fundStory.maker_name}</h4><br>
	                   <img class="profile_img" src="${fundStory.profile_img}">
	                   <h3>${fundStory.representative_email}</h3>
	                   <c:if test="!${empty fundStory.facebook_address }">
		                   <p>페이스북 : <a href="${fundStory.facebook_address }" >${fundStory.facebook_address}</a></p>
	                   </c:if>
	                   <c:if test="!${empty fundStory.twitter_address }">
		                   <p>트위터 : <a href="${fundStory.twitter_address }" >${fundStory.twitter_address}</a></p>
	                   </c:if>
	                   <c:if test="!${empty fundStory.instagram_address }">
		                   <p>인스타그램 : <a href="${fundStory.instagram_address }" >${fundStory.instagram_address}</a></p>
	                   </c:if>
	                </div>
	                <button class="btn" onclick="openChatRoomWindow('${fundStory.representative_email}')"
	                	<c:if test="${sessionScope.sId == fundStory.representative_email || empty sessionScope.sId}">disabled</c:if>><i class="fa fa-comments-o" style="font-size:24px, margin-right:2px"></i>문의하기</button>
	            	</div>
                <p>프로젝트 설명</p>
                   <button class="btn">문의하기</button>
            </div>
            <div class="reward-selection">
                <h3>리워드 선택</h3>
                <div class="reward-list">
                    <img src="reward1.jpg" alt="리워드 1">
                    <img src="reward2.jpg" alt="리워드 2">
                    <img src="reward3.jpg" alt="리워드 3">
                </div>
                <div class="btn-group">
                   <button class="btn-small">♡ 찜</button>
                   <button class="btn-small">지지</button>
                   <button class="purchase-btn">예약구매하기</button>
                </div>
            </div>
        </div>
    </div>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>