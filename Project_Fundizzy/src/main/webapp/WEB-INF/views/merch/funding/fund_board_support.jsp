<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지지서명</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_board_support.css">
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_default.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/merch/funding/fund_board_support.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	<article>
		<div class="fund-top">
	        <a href="#" class="story">스토리</a>
	        <a href="#" class="new">새소식</a>
	        <a href="#" class="support">지지서명</a>
	       	<a href="#" class="supporter">서포터</a>
	        <a href="#" class="refund">환불·정책</a>
	 	</div>
	    <hr>
<!-- 	    지지서명 영역 -->
    <div class="container">
	    <div class="content-left">
	    	<h3>지지서명 </h3>
	    	<hr>
<!-- 	    	글이 없을 경우엔 등록된 지지서명이 존재하지 않습니다. 글이 있는경우엔 띄우기  -->
			<c:choose>
				<c:when test="${empty supportList}">
					등록된 지지서명이 존재하지 않습니다.
				</c:when>
				<c:otherwise>
					<c:forEach var="support" items="${supportList}">
					    <div class="support-post">
					        <h4>${support.email}</h4>
					        <p>${support.support_content}</p>
							<p>
							    <c:set var="tagText" value="" />
							    <c:if test="${fn:contains(support.support_tag, '1')}">
							        <c:set var="tagText" value="${tagText} <span class='tag-style'>취향저격</span>, " />
							    </c:if>
							    <c:if test="${fn:contains(support.support_tag, '2')}">
							        <c:set var="tagText" value="${tagText} <span class='tag-style'>삶의 질 급상승</span>, " />
							    </c:if>
							    <c:if test="${fn:contains(support.support_tag, '3')}">
							        <c:set var="tagText" value="${tagText} <span class='tag-style'>유용템</span>, " />
							    </c:if>
							    <c:if test="${fn:contains(support.support_tag, '4')}">
							        <c:set var="tagText" value="${tagText} <span class='tag-style'>가성비</span>, " />
							    </c:if>
							    <c:if test="${fn:contains(support.support_tag, '5')}">
							        <c:set var="tagText" value="${tagText} <span class='tag-style'>응원해요</span>, " />
							    </c:if>
							    <!-- 마지막 콤마 제거 -->
							    <c:set var="tagText" value="${fn:substring(tagText, 0, fn:length(tagText) - 2)}" />
							    <!-- 출력 -->
							    ${tagText}
							</p>
					        <p class="date" style="font-size: 14px; color: #aaa;">${support.support_date}</p>
					    </div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
	    </div>
	      <div class="content-right">
            <div class="purchase-section">
                <h3>${fundStory.project_title}</h3>
                <div class="purchase-content">
                   ${fundStory.project_content}
                </div>
                <p><strong>${fundHistory}</strong>명 참여</p>
                <p><strong>${progress}</strong>% 달성</p>
                <div class="btn-group">
	                <input type="hidden" value="${sessionScope.sId}" id="keep_email">
	                <input type="hidden" value="${param.project_code}" id="keep_project_code">
	                <input type="hidden" value="${keep.email}" class="keep">
	                <c:choose>
	                	<c:when test="${empty keep.email}">
		                   <button class="btn-small" id="btn-like"><i class="fa fa-heart-o" style="font-size:27px"></i></button>
	                	</c:when>
	                	<c:otherwise>
		                   <button class="btn-small clicked" id="btn-like"><i class="fa fa-heart" style="font-size:27px"></i></button>
	                	</c:otherwise>
	                </c:choose>
<!--                    <button class="btn-small" id="btn-support"><i class="fa fa-thumbs-o-up" style="font-size:27px"></i></button> -->
                   <button class="btn-small" id="btn-support"><img src="/resources/images/fund/support.png" width="30px" height="30px"></button>
                   <button class="purchase-btn">펀딩하기</button>
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
            
            <div class="reward-selection">
<!--             리워드 목록 -->
                <h3>리워드 목록</h3>
                <div class="reward-list">
                	<c:forEach var="reward" items="${reward}">
	                	<div class="reward">
		<!--             	해당 프로젝트 코드를 넘기기 위한 hidden 속성 -->
						   <input type="hidden" id="project_code" name="project_code" value="${reward.project_code}">
			               <h4><fmt:formatNumber pattern="#,###원 " value="${reward.price}"></fmt:formatNumber></h4>
			               <p>${reward.product_name}</p>
			               <p>${reward.product_desc}</p>
			               <hr>
			               <p>배송비 : <fmt:formatNumber pattern="#,###원 " value="${reward.delivery_fee}"></fmt:formatNumber></p>
			               <p>제한수량 : ${reward.product_limit} 개</p>
			            </div>
                	</c:forEach>
                </div>
            </div>
        </div>
    </div>
	</article>
	<div class="support_modal" id="support_modal">
		<form action="SupportSignature" method="POST" class="support_content">
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
			<button type ="submit" class="support-submit">지지서명하기</button>
		</form>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>