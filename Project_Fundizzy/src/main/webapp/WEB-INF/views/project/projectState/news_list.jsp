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
<script src="resources/js/projectState/news_list.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>새소식</h1>
			<input type="button" value="새소식 작성하기" class="makeNewsBtn">
			<div class="modal">
				<div class="modal-content">
					<div class="modal-close">x</div>
					<h1>새소식 작성하기</h1>
					<form action=NewsBoard method="post">
						<div class="news-container">
							<div class="board-container">
								<div class="title-container">
									<input type="text" name="news_title" class="news_title" placeholder="제목을 입력해 주세요" maxlength="32" required>
									<div class="char-count">32자 남음</div>
								</div>
								<textarea name="news_content" class="news_content" placeholder="내용을 입력해 주세요" maxlength="1000" required></textarea>
							</div>
							<div class="btn-container">
								<input type="button" value="임시저장" class="saveBtn">
								<input type="submit" value="게시하기" class="postBtn">
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal2">
				<div class="modal-content2">
					<div class="modal-close">x</div>
					<h1>새소식 수정하기</h1>
					<form action=NewsModify method="post">
						<input type="hidden" name="news_code" class="news_code">
						<div class="news-container">
						</div>
					</form>
				</div>
			</div>
			
			<div class="notice">
				<h3>새소식 목록</h3>
				<div>새소식은 프로젝트 페이지 내 메이커님이 작성할 수 있는 공지 게시판으로, 
					프로젝트 공개 이후에도 추가적으로 소식을 전할 수 있는 공간이에요.<br>
					새소식 게시물을 작성하면 서포터님들에게 알림이 나가요.
				</div>
			</div>
			<div class="content-container">
				<c:if test="${empty newsList}">
					<div>등록된 새소식이 없습니다</div>
				</c:if>
				<c:forEach var="news" items="${newsList}">
						<c:if test="${news.news_status eq 'Y'}">
							<div class="list-container">
								<input type="hidden" name="news_code" class="news_code" value="${news.news_code}">
								<div class="list-title">
									<h3><a href="FundBoardNew?project_code=${news.project_code}">${news.news_title}</a></h3>
									<div>${news.news_date}</div>
								</div>
								<div class="btn-container">
									<input type="button" value="수정" class="modifyBtn">
									<input type="button" value="삭제" class="deleteBtn" onclick="confirmDelete(${news.news_code})">
								</div>
							</div>
						</c:if>
				</c:forEach>
				<div class="page_btn_group">
		       		<div class="page_btn">
						<c:if test="${pageInfo.maxPage != 0}">
				            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
				            	onclick="location.href='NewsList?pageNum=${pageInfo.pageNum - 1}'">
				            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				            	<c:choose>
				            		<c:when test="${pageInfo.pageNum eq i}">
				            			<b>${i}</b>
				            		</c:when>
				            		<c:otherwise>
				            			<a href="NewsList?pageNum=${i}">${i}</a>
				            		</c:otherwise>
				            	</c:choose>
				            </c:forEach>
				            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
				            onclick="location.href='NewsList?pageNum=${pageInfo.pageNum + 1}'">
						</c:if>
		       		</div>
		        </div>
        	</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	<script>
		$(document).ready(function() {
			// 새소식 작성하기 버튼 클릭 시 모달창 생성 
			$(".makeNewsBtn").click(function(e) {
				e.preventDefault();
				 $(".modal").fadeIn(200);
				 $(".modal-content").fadeIn(200);
			});
			
	      	// x 버튼 클릭 시 모달창 닫힘
			$(".modal-close").click(function() {
				 $(".modal").fadeOut(200);
				 $(".modal-content").fadeOut(200, function() {
					location.reload();
				});
			});
			
		});   
		
		// 새소식 게시글 삭제 함수
		function confirmDelete(newsCode) {
			console.log(newsCode + ", " + typeof(newsCode));
			if(confirm("삭제하시겠습니까?")) {
				location.href = "NewsDelete?news_code=" + newsCode + "&pageNum=${param.pageNum}";
			}
		}
	</script>
</body>
</html>

















