<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizy 관리자 페이지</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="resources/css/admin/admin_home.css" />
</head>s
<body>
	<!-- top.jsp -->
	<header>
		<jsp:include page="/WEB-INF/views/admin/inc/admin_top.jsp" />
	</header>
	<article>
		<!-- sidebar.jsp -->
		<jsp:include page="/WEB-INF/views/admin/inc/admin_sidebar.jsp" />
		
	    <div class="content">
	        <div class="box">
	        	<b style="font-size: 20px;">총 프로젝트 현황</b><br>
	        	<canvas id="myPieChart1"></canvas><br>
	        	<input type="button" value="상세보기">
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">실시간 사용자 현황</b><br>
				<canvas id="myPieChart2"></canvas><br>
	        	<input type="button" value="상세보기">	        	
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">총 펀딩금액</b><br>
	        	<canvas id="myPieChart3"></canvas><br>
	        	<input type="button" value="상세보기">
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">사용자 수</b><br>
	        	<canvas id="myPieChart4"></canvas><br>
	        	<input type="button" value="상세보기">
	        </div>
	    </div>
	</article>
	<!-- chart.js -->
    <script src="resources/js/admin/main/chart.js"></script>
</body>
</html>
