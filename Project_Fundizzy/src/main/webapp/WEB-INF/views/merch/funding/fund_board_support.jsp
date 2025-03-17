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
					        <p>${support.support_tag}</p>
					        <fmt:formatDate value="${support.support_date}" pattern="yyyy-MM-dd"/><br>
					
					        <!-- 댓글 버튼 (support_num을 data 속성으로 추가) -->
					        <input type="button" value="댓글" class="reply-show" data-support-num="${support.support_num}"><br>
					
					        <!-- 댓글 폼 (support_num 별로 구별) -->
					        <form action="SupportReply" method="post" class="reply-form" data-support-num="${support.support_num}" style="display: none;">
					            <input type="hidden" value="${param.project_code}" name="project_code">
					            <input type="hidden" value="${support.support_num}" name="support_num">
					            <textarea name="reply_content"></textarea>
					            <input type="submit" value="등록" id="reply-submit-btn">
					        </form>
					    </div>
			        	<div class="reply-list">
<!-- 				        	작성된 댓글- 댓글 삭제상태가 1일 경우엔 표시하지 않기 -->
			        		<table>
							    <c:forEach var="reply" items="${ReplyList}" varStatus="status">
							        <tr class="replyTr">
							            <td class="replyContent"><input type="hidden" value ="${reply.reply_num}" id="replyDelete">${reply.reply_content}</td>
							            <td class="replyWriter">${reply.maker_email}</td>
							            <td class="replyRegDate"><fmt:formatDate value="${reply.reply_date}" pattern="yyyy-MM-dd"/></td>
						       			<td><button class="replyDelete" data-reply-num="${reply.reply_num}">
									    <img src="${pageContext.request.contextPath}/resources/images/fund/delete-icon.png" class="deleteImg" title="댓글삭제">
									</button></td>
							        </tr>
							    </c:forEach>
			        		</table>
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
                <p><strong>${fundStory.progress}</strong>% 달성</p>
                <div class="btn-group">
	                <input type="hidden" value="${sessionScope.sId }" id="keep_email">
	                <input type="hidden" value="${param.project_code}" id="keep_project_code">
	                <input type="hidden" value="${keep.email}" class="keep">
	                <c:choose>
	                	<c:when test="${empty keep.email}">
		                   <button class="btn-small" id="btn-like"><i class="fa fa-heart-o" style="font-size:24px"></i>찜</button>
	                	</c:when>
	                	<c:otherwise>
		                   <button class="btn-small clicked" id="btn-like"><i class="fa fa-heart" style="font-size:24px"></i>찜</button>
	                	</c:otherwise>
	                </c:choose>
                   <button class="btn-small" id="btn-support"><i class='far fa-handshake' style='font-size:24px'></i>지지</button>
                   <button class="purchase-btn">펀딩하기</button>
                </div>
            </div>
<!--             회사정보 div -->
            <div class="project-info">
                <div class="company-info">
                   <h4>${fundStory.business_name}</h4><br>
                </div>
   				 <button class="btn" onclick="openChatRoomWindow('${fundStory.representative_email}')">문의하기</button>
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
			               <p>배송비 ${reward.delivery_fee}</p>
			               <p>발송 시작일</p>
			               <p>제한수량 ${reward.product_limit}</p>
			               <hr>
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