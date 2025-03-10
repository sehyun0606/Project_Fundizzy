<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩 새소식</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_board_new.css">
<!-- js파일 로드 script -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/merch/funding/fund_board_new.js"></script>
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
	          <div class="content-left-top">
	             <h3>새소식</h3>
	             <select>
	                <option>최신순</option>
	                <option>과거순</option>
	             </select>
	          </div>
	          <hr>
	           <div class="post">
	               <h4>리워드 안내</h4>
	               <p>결제 오류 조치 완료 안내</p>
	               <p>3시간 전</p>
	           </div>
	           <div class="post">
	               <h4>리워드 안내</h4>
	               <p>결제 오류 조치 완료 안내</p>
	               <p>3시간 전 </p>
	           </div>
	           <div class="post">
	               <h4>리워드 안내</h4>
	               <p>결제 오류 조치 완료 안내</p>
	               <p>3시간 전 </p>
	           </div>
	           <div class="post">
	               <h4>리워드 안내</h4>
	               <p>결제 오류 조치 완료 안내</p>
	               <p>3시간 전 </p>
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
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>