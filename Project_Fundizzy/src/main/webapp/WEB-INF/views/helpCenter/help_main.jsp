<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy</title>
<link rel="stylesheet" type="text/css" href="resources/css/helpCenter/helpCenter_main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article class="help-center">
	    <!-- 상단 배경 및 검색바 -->
	    <div class="hero">
	        <div class="hero-content">
	            <h2>일상과 새로운 가능성을 그려가는 곳,<br> 펀디지 도움말 센터입니다.</h2>
	            <form action="">
		            <div class="search-box">
					    <input type="text" placeholder="궁금한 내용을 입력해주세요">
					    <i class="fas fa-search search-icon"></i> 
					</div>
	            </form>
	        </div>
	    </div>
	
	    <!-- 자주 묻는 질문 -->
	    <section class="faq-section">
	        <h2 class="faq-title">자주 묻는 질문</h2>
	
	        <!-- ✅ 서포터 / 메이커 탭 -->
			<div class="faq-tabs">
			    <span class="tab-btn active" data-target="supporter">서포터</span>
			    <span class="tab-btn" data-target="maker">메이커</span>
			</div>
	
<!-- 	        카테고리 버튼 -->
<!-- 	        <div class="faq-categories"> -->
<!-- 	            <button>회원정보</button> -->
<!-- 	            <button>결제</button> -->
<!-- 	            <button>상품/배송</button> -->
<!-- 	            <button>서비스 이용</button> -->
<!-- 	            <button>사이트 위치/기능 문의</button> -->
<!-- 	        </div> -->
	
	        <!-- ✅ 서포터 FAQ 리스트 -->
	        <c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '회원정보'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
			<div class="faq-list tab-content active" id="supporter">
				<c:set var="faqCounter" value="0" />
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
			        <c:if test="${faq.board_category eq '회원정보' && faqCounter < 6}">
					    <div class="faq-item" onclick="location.href='BoardDetail?title=${faq.board_title}&content=${faq.board_content}'">
					        <h3>📌 ${faq.board_title}</h3>
					        <p>A. <span class="check-icon">✔</span> ${faq.board_content}</p>
					    </div>
				    <c:set var="faqCounter" value="${faqCounter + 1}" />
			    	</c:if>
			    </c:forEach>
			</div>
			
			<!-- ✅ 메이커 FAQ 리스트 -->
			<c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '개설(예비메이커)'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
			<div class="faq-list tab-content" id="maker">
				<c:set var="faqCounter" value="0" />
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
		        	<c:if test="${faq.board_category eq '개설(예비메이커)' && faqCounter < 6}">
					    <div class="faq-item" onclick="location.href='BoardDetail?title=${faq.board_title}&content=${faq.board_content}'">
					        <h3>📌 ${faq.board_title}</h3>
					        <p>A. <span class="check-icon">✔</span> ${faq.board_content}</p>
					    </div>
				    	<c:set var="faqCounter" value="${faqCounter + 1}" />
			    	</c:if>
			    </c:forEach>
			</div>
	
	        <!-- 전체 보기 버튼 -->
	        <div class="view-more">
	            <button onclick="location.href='Supporter'">전체 보기</button>
	        </div>
	    </section>
	
    	<!-- 공지사항 & 문의 등록 -->
	    <section class="bottom-section">
		    <!-- 공지사항 -->
		    <c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '공지사항'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
		    <div class="notice-box">
		    	<c:set var="faqCounter" value="0" />
		        <h3>공지사항</h3>
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
		        	<c:if test="${faq.board_category eq '공지사항' && faqCounter < 3}">
				        <ul>
				            <li>${faq.board_title} <span><fmt:formatDate value='${faq.board_create}' pattern='yy-MM'/></span></li>
				        </ul>
		        		<c:set var="faqCounter" value="${faqCounter + 1}" />
			    	</c:if>
			    </c:forEach>
		        <a href="Notice">더 보기 ></a>
		    </div>
		
		    <!-- 고객센터 -->
		    <div class="customer-center">
		        <h3>고객센터</h3>
		        <p class="phone-number">📞 <b>1001-2233</b></p>
		        <p class="center-info">상담 가능시간: 평일 오전 9시 ~ 오후 6시 <br> (주말, 공휴일 제외)</p>
		    </div>
		
		    <!-- 문의 등록 -->
		    <div class="inquiry-box">
		        <h3>문의 등록하기</h3>
		        <ul>
		            <li><a href="QnaForm">펀디즈 서비스 문의하기 ></a></li>
		            <li><a href="#">서포터 서비스 문의하기 ></a></li>
		            <li><a href="#">메이커 서비스 문의하기 ></a></li>
		        </ul>
		    </div>
		</section>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
	
	<script>
	    $(document).ready(function () {
	        // ✅ 탭 버튼 클릭 시 FAQ 리스트 변경
	        $(".tab-btn").click(function () {
	            $(".tab-btn").removeClass("active"); // 기존 active 제거
	            $(this).addClass("active"); // 클릭된 탭에 active 추가
	            
	            let target = $(this).data("target"); // 클릭한 탭의 data-target 값 가져오기
	            $(".faq-list").removeClass("active"); // 기존 FAQ 리스트 숨기기
	            $("#" + target).addClass("active"); // 클릭된 탭에 해당하는 FAQ 리스트 보이기
	        });
	    });
	</script>
</body>
</html>