<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불정책</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/fund_board_refund.css">
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
	    	<h3>환불 / 정책</h3>
	    	<ul>
	    		<li>
	    			프로젝트 종료 전까지 언제든 결제 취소 가능해요.
	    		</li>
	    		<li>
	    			환불은 참여 내역에서 신청할 수 있어요.
	    		</li>
	    		<li>
	    			환불 신청은 리워드 수령 후 7일 이내 가능해요
	    		</li>
	    		<li>
	    			환불 신청 후 메이커와 소통하여 리워드를 발송해주세요.
	    		</li>
	    		<li>
	    			단순변심: 반품비 서포터 부담
	    		</li>
	    		<li>
	    			리워드 품질 하자: 반품비 메이커 부담
	    		<li>
	    			환불 정책에 따라 꼼꼼한 확인 절차를 통해 진행돼요.
	    		</li>
	    		<li>
	    			메이커가 리워드 발송 시작 예정일까지 리워드를 발송하지 않을 경우 환불 신청 이후 즉시 결제 취소돼요. (2-5 영업일 소요)
    			</li>
	    	</ul>
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
                   <button class="purchase-btn">구매하기</button>
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
                   <button class="purchase-btn">구매하기</button>
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
