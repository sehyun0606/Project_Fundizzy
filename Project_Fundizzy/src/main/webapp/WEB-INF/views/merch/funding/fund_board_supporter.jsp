<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>참여하는 서포터</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_board_supporter.css">
<!-- js파일 로드 script -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/merch/funding/fund_board_supporter.js"></script>
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
	       	<a href="#" class="supporter">서포터</a>
	        <a href="#" class="refund">환불·정책</a>
	        <a href="#" class="reward">리워드정보</a>
	 	</div>
	    <hr>
    <div class="container">
    	    	<input type="button" id="project_code" value="${param.project_code}">
	    <div class="content-left">
	    	<h3>참여하는 서포터</h3>
	    	<hr>
	        <div class="post">
	            <p>이재영님이 71,212원 예약구매 했어요</p>
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
                    <img src="reward1.jpg" alt="리워드 1">
                    <img src="reward2.jpg" alt="리워드 2">
                    <img src="reward3.jpg" alt="리워드 3">
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
			<input type="hidden" id="project_code" name="project_code" value="${param.project_code }">
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
