<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펀딩스토리</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_board_story.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- js파일 로드 script -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/merch/funding/fund_board_story.js"></script>
<!--   지지서명 아이콘 관련 script -->
  <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		<div class="fund-top">
	        <a href="FundBoardStory" class="story">스토리</a>
	        <a href="FundBoardNew" class="new">새소식</a>
	        <a href="FundBoardSupport" class="support">지지서명</a>
	       	<a href="FundBoardSupporter" class="supporter">서포터</a>
	        <a href="FundBoardRefund" class="refund">환불·정책</a>
	        <a href="FundBoardReward" class="reward">리워드정보</a>
	 	</div>
	    <hr>
    <div class="container">
        <div class="content-left">
			<div class="main-image">
			    <img src="resources/images/fund/image2.jpg" alt="메인 이미지">
			    <img src="resources/images/fund/image5.jpg" alt="메인 이미지">
			    <img src="resources/images/fund/image3.jpg" alt="메인 이미지">
			</div>
            <div class="content-left-under">
                 <div class="content-left-under1">
                    <img src="" alt="특별구성">
               </div>
                 <div class="content-left-under2">
                    <img src="" alt="프리오더">
               </div>
            </div>
            <div class="project-story">
                <p>프로젝트 스토리</p>
                <img src="story.jpg" alt="프로젝트 스토리 이미지">
                <button>스토리 더보기v</button>
            </div>
            <div class="product-list">
                <h3>같이 보면 좋은 프로젝트</h3>
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
                <br>
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
            <hr>
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
                <h3>${fundStory.project_title}</h3>
                <div class="purchase-content">
                   ${fundStory.project_content}
                </div>
                <p><strong>139</strong>명 참여</p>
                <p><strong>50,000</strong>원 달성</p>
                <div class="btn-group">
                   <button class="btn-small" id="btn-like"><i class="fa fa-heart" style="font-size:24px"></i>찜</button>
                   <button class="btn-small" id="btn-support"><i class='far fa-handshake' style='font-size:24px'></i>지지</button>
                   <button class="purchase-btn" onclick="location.href='PaymentReward'">펀딩하기</button>
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
				  	<div class="reward">
		               <h4>13,900원</h4>
		               <p>헤어스타일러 외 4종 스타일링 툴</p>
		               <p>드라이기 + 고속노즐 + 일반노즐 + 스타일링 빗</p>
		               <hr>
		               <p>배송비 </p>
		               <p>발송 시작일</p>
		               <p>제한 수량</p>
		            </div>
                </div>
                <div class="btn-group">
                   <button class="btn-small" id="btn-like"><i class="fa fa-heart" style="font-size:24px"></i>찜</button>
                   <button class="btn-small" id="btn-support"><i class='far fa-handshake' style='font-size:24px'></i>지지</button>
                   <button class="purchase-btn" onclick="location.href='PaymentReward'">펀딩하기</button>
                </div>
            </div>
        </div>
    </div>
	</article>
	<div class="support_modal" id="support_modal">
		<form action="SupportSignature" method="POST" class="support_content">
			<input type="hidden" id="project_code" name="project_code" value="83652PRO01">
			<input type="hidden" id="sessionUserEmail" name="email" value="${sessionScope.sId}">
			
			<div class="top">
			    <b class="subject">지지 서명으로 메이커에게 힘이 돼주세요</b>
			    <button type="button" class="x">x</button>
			</div>
			<p>ㆍ키워드는 최대 3개까지 선택 가능해요.</p>
			<div class="btn-support-list">
				<button type="button" class="like" value="like">취향저격</button>
				<button type="button" class="life" value="life">삶의질급상승</button>
				<button type="button" class="useful"  value="useful">유용템</button>
				<button type="button" class="littleMoney"  value="littleMoney">가성비</button>
				<button type="button" class="cheerup"  value="cheerup">응원해요</button>
				<input type="checkbox" class="like-check" name="like" style="display: none;">
				<input type="checkbox" class="life-check" name="life" style="display: none;">
				<input type="checkbox" class="useful-check" name="useful" style="display: none;">
				<input type="checkbox" class="littleMoney-check" name="littleMoney" style="display: none;">
				<input type="checkbox" class="cheerup-check" name="cheerup" style="display: none;">
			</div>
			<textarea id="supportContent" name="support_content" placeholder="응원의 글을 남겨주세요"></textarea><br>
			<button class="support-submit">지지서명하기</button>
		</form>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>