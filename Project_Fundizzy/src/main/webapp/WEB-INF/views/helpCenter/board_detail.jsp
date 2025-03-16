<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy</title>
<link rel="stylesheet" type="text/css" href="resources/css/helpCenter/board_detail.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article class="main-container">
	    <section class="board-detail">
	        <!-- 🔹 해당 게시글 정보 불러오기 -->
	        <c:set var="currentBoard" value="" />
	        <c:forEach var="faq" items="${faqList}">
	            <c:if test="${faq.board_title eq param.title}">
	                <c:set var="currentBoard" value="${faq}" />
	            </c:if>
	        </c:forEach>

	        <!-- 🔹 제목 -->
	        <h1 class="board-title">📢 <c:out value="${currentBoard.board_title}" /></h1>

	        <!-- 🔹 작성자 및 날짜 -->
	        <div class="board-meta">
	            <span class="board-writer"><c:out value="${currentBoard.board_writer}" /></span>
	            <span class="board-date"><c:out value="${currentBoard.board_create}" /></span>
	        </div>

	        <!-- 🔹 본문 내용 -->
	        <div class="board-content">
	            <p><c:out value="${currentBoard.board_content}" escapeXml="false" /></p>
	        </div>

	        <!-- 🔹 반응 버튼 -->
	        <div class="board-reactions">
			    <button class="reaction-btn" id="like-btn" data-board-num="${currentBoard.board_num}">
			        <i class="fas fa-heart"></i> <span id="like-count"><c:out value="${currentBoard.board_like}" /></span>
			    </button>
			</div>

	        <!-- 🔹 같은 카테고리의 다른 게시글 -->
	        <div class="related-posts">
			    <h3>📢 같은 카테고리의 다른 게시글</h3>
			    <ul>
			        <c:set var="relatedCount" value="0" />
			        <c:forEach var="faq" items="${faqList}">
			            <c:if test="${faq.board_category eq currentBoard.board_category && faq.board_num ne currentBoard.board_num && relatedCount < 3}">
			                <li>
			                    <a href="BoardDetail?title=${faq.board_title}">
			                        <c:out value="${faq.board_title}" />
			                    </a>
			                    <span class="related-date"><c:out value="${faq.board_create}" /></span>
			                   	<input type="hidden" id="hiddenEmail" value="${sessionScope.sId }">
			                </li>
			                <c:set var="relatedCount" value="${relatedCount + 1}" />
			            </c:if>
			        </c:forEach>
			    </ul>
			</div>
	    </section>
	</article>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
	<script>
		$(document).ready(function() {
			var loginType = "${sessionScope.loginType}";
	        console.log("로그인 상태: " + loginType);
			var UserNickname = "";
			if(loginType == 'local') {
				var UserNickname = "${member.nickname}";
			} else if(loginType == 'kakao') {
				var UserNickname = "${DBKakaoUserInfo.nickname}";
			} else if(loginType == 'naver') {
				var UserNickname = "${DBNaverUserInfo.nickname}";
			}
			console.log("유저 닉네임 : " + UserNickname);				
		    let boardNum = $("#like-btn").data("board-num");
			var UserEmail = $("#hiddenEmail").val();
			console.log(UserEmail);
		    // 페이지 로드 시 현재 좋아요 상태 확인
		    $.ajax({
		        type: "GET",
		        url: "checkLikeStatus",
		        data: { 
		        	boardNum: boardNum
		        	, UserNickname: UserNickname
		        	, loginType: loginType
		        	, UserEmail: UserEmail
		        },
		        success: function(response) {
		        	console.log(response);
		            if (response.trim() == "true") {
		            	console.log(response.trim());
		                $("#like-btn").addClass("liked"); // 이미 좋아요 누른 경우 색상 변경
		            } 
		            return;
		        }
		    });
		
		    // 좋아요 버튼 클릭 이벤트
		    $("#like-btn").click(function() {
		        let likeBtn = $(this);
		        let likeCount = parseInt($("#like-count").text());
		
// 		        AJAX 요청으로 좋아요 상태 변경
		        $.ajax({
		            type: "GET",
		            url: "toggleLike",
		            data: { 
		            	boardNum: boardNum
		            	, UserNickname: UserNickname
			        	, loginType: loginType
			        	, UserEmail: UserEmail
		            },
		            success: function(response) {
		                if (response.trim() == "true") {
		                    $("#like-count").text(likeCount + 1); // 좋아요 증가
		                    likeBtn.addClass("liked"); // 스타일 변경
		                } else {
		                    $("#like-count").text(likeCount - 1); // 좋아요 감소
		                    likeBtn.removeClass("liked"); // 스타일 원래대로
		                }
		            }
		        });
		    });
		});
		</script>
</body>
</html>
