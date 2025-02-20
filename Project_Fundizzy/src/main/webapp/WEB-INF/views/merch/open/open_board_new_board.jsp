<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩새소식-글</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_board_new_board.css">
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
	       	<a href="OpenBoardSupporter" class="supporter">서포터</a>
	        <a href="OpenBoardRefund" class="refund">환불·정책</a>
	        <a href="OpenBoardReward" class="reward">리워드정보</a>
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
                <div class="company-info">
                   <h4>(주)붐코리아</h4><br>
<!--                    143,242명 팔로우 중 -->
                   <button class="btn-midium">♡ 팔로우</button>
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