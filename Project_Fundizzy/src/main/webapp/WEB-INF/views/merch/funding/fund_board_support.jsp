<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지지서명</title>
<link rel="stylesheet" type="text/css" href="resources/css/merch/funding/fund_board_support.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/merch/funding/fund_board_support.js"></script>
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
<!-- 	    지지서명 영역 -->
    <div class="container">
	    <div class="content-left">
<!-- 	    임시로 프로젝트 코드 값 줌  -->
	    	<input type="hidden" value="83652PRO01">
	    	<h3>지지서명 -글 개수 출력</h3>
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
				            <p>${support.support_tag}</p>
				            <fmt:formatDate value="${support.support_date}" pattern="yyyy-MM-dd"/>
				        </div>
<!-- 				        댓글영역 -->
				        <div>
				        	<input type="button" value="댓글" class="reply-show"><br>
				        	<form action="SupportReply" method="post">
					        	<div class="reply-write ${sessionScope.sId eq admin ? 'show' : 'hide'}">
<%-- 					        		<c:choose> --%>
<%-- 					        			<c:when test="${sessionScope.sId eq admin}"> --%>
					        				<input type="hidden" value="${support.reply_num}" name="reply_num">
					        				<input type="hidden" value="${support.project_code}" name="project_code">
					        				<input type="hidden" value="${support.maker_email}" name="maker_email">
					        				<input type="hidden" value="${support.reply_writer_ip}" name="reply_writer_ip">
					        				<input type="hidden" value="${support.support_num}" name="support_num">
								        	<textarea name="reply_content"></textarea>
								        	<input type="submit" value="등록" id ="reply-submit-btn">
<%-- 					        			</c:when> --%>
<%-- 					        			<c:otherwise> --%>
<%-- 					        				<input type="hidden" value="${support.support_num}"> --%>
<!-- 								        	<textarea disabled="disabled" placeholder="관리자만 작성 가능합니다."></textarea> -->
<!-- 								        	<input type="submit" value="등록" id ="reply-submit-btn" disabled="disabled"> -->
<%-- 					        			</c:otherwise> --%>
<%-- 				        			</c:choose> --%>
					        	</div>
				        	</form>
				        	<div class="reply-list">
				        		<table>
								    <c:forEach var="reply" items="${ReplyList}" varStatus="status">
<!-- 								    	댓글 삭제상태가 1일 경우엔 표시하지 않기 -->
								        <tr>
								            <td class="replyContent">${reply.reply_content}</td>
								            <td class="replyWriter">${reply.maker_email}</td>
								            <td class="replyRegDate"><fmt:formatDate value="${reply.reply_date}" pattern="yyyy-MM-dd"/></td>
								            <a href=""><img src="${pageContext.request.contextPath }/resources/images/fund/delete-icon.png" title="댓글삭제"></a>
								        </tr>
								    </c:forEach>
				        		</table>
				        	</div>
				        </div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
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
                   <button class="purchase-btn">펀딩하기</button>
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
                   <button class="purchase-btn">펀딩하기</button>
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