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
<link rel="stylesheet" type="text/css" href="resources/css/merch/open/fund_board_story.css">
<link rel="stylesheet" type="text/css" href="resources/css/merch/open/open_default.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- js파일 로드 script -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/merch/open/fund_board_story.js"></script>
<!--   지지서명 아이콘 관련 script -->
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article>
		<div class="fund-top">
	        <a href="#" class="story">스토리</a>
	        <a href="#" class="new">새소식</a>
	        <a href="#" class="support">지지서명</a>
	 	</div>
	    <hr>
    <div class="container">
        <div class="content-left">
           	<c:forEach var="projectStory"  items="${projectStoryList}">
				<div class="main-image">
				    <img src="${projectStory.representative_picture}" alt="메인 이미지">
				</div>
				
	           <div class="project-story">
	                <p>프로젝트 스토리</p>
	                ${projectStory.open_story}
<!-- 	                <button>스토리 더보기v</button> -->
	           </div>
           	</c:forEach>
            <div class="product-list">
            </div>
            <hr>
            <div class="product-list">
                <h3>펀딩 베스트 프로젝트</h3>
<!--                <div class="image-group"> -->
<!--                    <div> -->
<!--                        <img src="rec1.jpg" alt="추천 프로젝트 1"> -->
<!--                        <div class="product-info"> -->
<!--                          <p class="discount">4,541%달성 </p> -->
<!--                          <p class="name">[4차앵콜] 티타늄 텀블러 싱글</p> -->
<!--                          <p class="rating">⭐ 4.7(148)</p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                 </div> -->
                
                     <div class="trend-list">
		                <c:forEach var="pll" items="${projectLikeList}" begin="0" end="3">
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
        </div>
<!--         오른쪽 부분 -->
        <div class="content-right">
            <div class="purchase-section">
                <h3>${fundStory.project_title}</h3>
                <div class="purchase-content">
                   ${fundStory.project_content}
                </div>
                <input type="hidden" value="${sessionScope.sId}" id="sId">
                <p style="color: mediumpurple; font-weight: 600; margin-bottom: 30px"><strong style="font-size: 20px; font-weight: 700;"><fmt:formatDate value="${fundStory.project_start_date}" pattern="MM/dd(EEE)"/></strong> 오픈예정</p>
                <div class="btn-group">
	                <input type="hidden" value="${sessionScope.sId}" id="keep_email">
	                <input type="hidden" value="${param.project_code}" id="keep_project_code">
	                <input type="hidden" value="${keep.email}" class="keep">
                    <button class="btn-small" id="btn-support"><img src="/resources/images/fund/support.png" width="30px" height="30px"></button>
					<c:choose>
						<c:when test="${empty keep.email}">
							<input type="hidden" class="count" value="${keepCount}">
		                    <button class="purchase-btn" id="btn-like">오픈 알림 신청 &nbsp;<span style="font-size: 12px">${keepCount}명 기다려요</span></button>
						</c:when>
						<c:otherwise>
		                    <button class="purchase-btn clicked" id="btn-like">알림 신청 완료 &nbsp;<span style="font-size: 12px">${keepCount}명 기다려요</span></button>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
<!--             회사정보 div -->
             <div class="project-info">
                <div class="company-info">
                   <h4>${fundStory.maker_name}</h4><br>
                   <img class="profile_img" src="${fundStory.profile_img}">
                   <h3>${fundStory.maker_email}</h3>
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
            
        </div>
    </div>
	</article>
	<div class="support_modal" id="support_modal">
		<form action="SupportSignatureOpen" method="POST" class="support_content">
			<input type="hidden" id="project_code" name="project_code" value="${param.project_code}">
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
				<button type="button" class="littleMoney" value="littleMoney">가성비</button>
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