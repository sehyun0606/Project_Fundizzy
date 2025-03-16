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
		        <a href="Supporter" class="nav-category">공지사항</a> 
		    </nav>
	        
	        <!-- 시작 -->
			<c:set var="categoryCount" value="0" />
			<c:forEach var="faq" items="${faqList}">
			    <c:if test="${faq.board_category eq '공지사항'}">
			        <c:set var="categoryCount" value="${categoryCount + 1}" />
			    </c:if>
			</c:forEach>
			
			<!-- 카테고리 제목 -->
			<h2 class="supporter-title">공지사항</h2>
			
			<!-- 🔹 FAQ 리스트 (최대 6개만 표시) -->
			<div class="supporter-faq-list">
			    <c:set var="faqCounter" value="0" />
			    <c:forEach var="faq" items="${faqList}" varStatus="status">
			        <c:if test="${faq.board_category eq '공지사항'}">
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
	    </section>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>