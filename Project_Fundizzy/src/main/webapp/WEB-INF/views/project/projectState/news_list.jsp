<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새소식 목록</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="styleSheet" type="text/css" href="resources/css/projectState/news_list.css" >
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- <script src="resources/js/projectState/newsList.js"></script> -->
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
			
			<div class="content">
				<h1>새소식</h1>
				<input type="button" value="새소식 작성하기" class="makeNewsBtn">
				<div class="modal">
					<div class="modal_content">
						<div class="modal_close">x</div>
						<h1>새소식 작성하기</h1>
						<div class="news-container">
							<input type="text" placeholder="제목을 입력해 주세요">
							<textarea placeholder="내용을 입력해 주세요"></textarea>
							<div class="btn-container">
								<input type="button" value="임시저장" class="saveBtn">
								<input type="button" value="게시하기" class="postBtn">
							</div>
						</div>
					</div>
				</div>
				
				<h3>새소식 목록</h3>
				<div>새소식은 프로젝트 페이지 내 메이커님이 작성할 수 있는 공지 게시판으로, 
					프로젝트 공개 이후에도 추가적으로 소식을 전할 수 있는 공간이에요. 
					새소식 게시물을 작성하면 서포터님들에게 알림이 나가요.
				</div>
				<c:forEach var="list" begin="1" end="7">
					<div class="list-container">
						<div class="list-title">
							<h3><a href="">첫 번째 새소식 블라블라 제목입니다</a></h3>
							<div>2025.03.02</div>
						</div>
						<div class="btn-container">
							<input type="button" value="수정" class="modifyBtn">
							<input type="button" value="삭제" class="deleteBtn">
						</div>
					</div>
				</c:forEach>
		</div>
	</div>
	
	
	
	<script>
	        
// 	        // 새소식 작성하지 버튼 클릭 시 모달창 생성 
			$(".makeNewsBtn").click(function(e) {
				e.preventDefault();
				$(".modal").css("display", "block");
				$(".modal_content").css("display", "block");
			});
			
// 	        // x 버튼 클릭 시 모달창 닫힘
			$(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
	        
		</script>
</body>
</html>