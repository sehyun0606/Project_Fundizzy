<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy</title>
<link rel="stylesheet" type="text/css" href="resources/css/helpCenter/board_list.css">
<link rel="stylesheet" type="text/css" href="resources/css/helpCenter/board_sidebar.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article class="supporter-container">
	    <!-- 🔹 왼쪽 사이드바 -->
		<jsp:include page="/WEB-INF/views/helpCenter/board_sidebar.jsp" />
			
	    <!-- 🔹 오른쪽 컨텐츠 -->
	    <section class="supporter-content">
	        <nav class="supporter-breadcrumb">
		        <a href="HelpCenter" class="nav-helpCenter">펀디즈 도움말 센터</a> / 
		        <a href="Supporter" class="nav-category">메이커</a> 
		    </nav>
	        
	        <!-- 시작 -->
			<c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '개설(예비메이커)'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
			
			<!-- 카테고리 제목 -->
			<h2 class="supporter-title">개설(예비메이커)</h2>
			
			<!-- 🔹 FAQ 리스트 (최대 6개만 표시) -->
			<div class="supporter-faq-list">
			    <c:set var="faqCounter" value="0" />
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
			        <c:if test="${faq.board_category eq '개설(예비메이커)' && faqCounter < 4}">
			            <div class="supporter-faq-item">
			                <div class="supporter-faq-text" onclick="location.href='BoardDetail?title=${faq.board_title}&content=${faq.board_content}'">
			                    <h3>${faq.board_title}</h3>
			                    <p><span class="supporter-faq-icon">✅</span> ${faq.board_content}</p>
			                </div>
			                <span class="supporter-faq-arrow">›</span>
			            </div>
			            <c:set var="faqCounter" value="${faqCounter + 1}" />
			        </c:if>
			    </c:forEach>
			</div>
			
			<!-- 🔹 전체 보기 링크 -->
			<div class="supporter-view-all">
			    <a href="MakerSelect?category=개설(예비메이커)" class="view-all-link">
			        <b>문서 ${categoryCount}개 모두 보기</b> →
			    </a>
			</div>
	        <!-- 끝 -->
	        
	        <!-- 시작 -->
			<c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '심사'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
			
			<!-- 카테고리 제목 -->
			<h2 class="supporter-title">심사</h2>
			
			<!-- 🔹 FAQ 리스트 (최대 6개만 표시) -->
			<div class="supporter-faq-list">
			    <c:set var="faqCounter" value="0" />
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
			        <c:if test="${faq.board_category eq '심사' && faqCounter < 4}">
			            <div class="supporter-faq-item">
			                <div class="supporter-faq-text" onclick="location.href='BoardDetail?title=${faq.board_title}&content=${faq.board_content}'">
			                    <h3>${faq.board_title}</h3>
			                    <p><span class="supporter-faq-icon">✅</span> ${faq.board_content}</p>
			                </div>
			                <span class="supporter-faq-arrow">›</span>
			            </div>
			            <c:set var="faqCounter" value="${faqCounter + 1}" />
			        </c:if>
			    </c:forEach>
			</div>
			
			<!-- 🔹 전체 보기 링크 -->
			<div class="supporter-view-all">
			    <a href="MakerSelect?category=심사" class="view-all-link">
			        <b>문서 ${categoryCount}개 모두 보기</b> →
			    </a>
			</div>
	        <!-- 끝 -->
	        
	        <!-- 시작 -->
			<c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '광고'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
			
			<!-- 카테고리 제목 -->
			<h2 class="supporter-title">광고</h2>
			
			<!-- 🔹 FAQ 리스트 (최대 6개만 표시) -->
			<div class="supporter-faq-list">
			    <c:set var="faqCounter" value="0" />
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
			        <c:if test="${faq.board_category eq '광고' && faqCounter < 4}">
			            <div class="supporter-faq-item">
			                <div class="supporter-faq-text" onclick="location.href='BoardDetail?title=${faq.board_title}&content=${faq.board_content}'">
			                    <h3>${faq.board_title}</h3>
			                    <p><span class="supporter-faq-icon">✅</span> ${faq.board_content}</p>
			                </div>
			                <span class="supporter-faq-arrow">›</span>
			            </div>
			            <c:set var="faqCounter" value="${faqCounter + 1}" />
			        </c:if>
			    </c:forEach>
			</div>
			
			<!-- 🔹 전체 보기 링크 -->
			<div class="supporter-view-all">
			    <a href="MakerSelect?category=광고" class="view-all-link">
			        <b>문서 ${categoryCount}개 모두 보기</b> →
			    </a>
			</div>
	        <!-- 끝 -->

	    </section>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>