<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 관리 페이지</title>
    <script src="resources/js/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="resources/css/admin/admin_home.css" />
    <link rel="stylesheet" href="resources/css/admin/project_management/project_status.css" />
</head>
<body>
	<!-- top.jsp -->
	<header>
		<jsp:include page="/WEB-INF/views/admin/inc/admin_top.jsp" />
	</header>
	<article>
		<!-- sidebar.jsp -->
		<jsp:include page="/WEB-INF/views/admin/inc/admin_sidebar.jsp" />
	
		<div class="main-content">
	    
		    <!-- 메인 콘텐츠 -->
		    <!-- 회원 정보 -->
		    <div class="member-info">
		        <h2>프로젝트 상태 관리</h2>
	        	<form action=""> 
			        <div class="search-bar">
			        	<select name="searchType" style="height: 29px;">
							<option value="" >프로젝트 이름</option>
							<option value="" >프로젝트 코드</option>
							<option value="" >이메일</option>
						</select>
			            <input type="text" placeholder="회원명">
			            <button class="search-btn">검색</button>
			        </div>
	            </form>
		
		        <table>
		            <thead>
		            <tr>
		                <th class="project_code">프로젝트 코드</th>
		                <th class="project_img">이미지</th>
		                <th class="project_title">프로젝트 제목</th>
		                <th class="proejct_date">신청 날짜</th>
		                <th class="project_status">상태</th>
		                <th></th>
		            </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="project" items="${projectList}" varStatus="status">
			                    <tr>
			                        <td>${project.project_code}</td>
			                        <td><img class="project_img" alt="" src="/resources/upload/${project.representative_picture}"></td>
			                        <td>${project.project_title}</td>
			                        <td>
			                            <fmt:formatDate value="${project.request_approve_date}" pattern="yyyy-MM-dd HH:mm"/>
			                        </td>
			                        <td>${project.approve_stat}</td>
			                    </tr>
			            </c:forEach>
		            </tbody>
		        </table>
		    </div>
		    <div class="page_btn_group">
	    		<div class="page_btn">
					<c:if test="${pageInfo.maxPage != 0}">
			            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
			            	onclick="location.href='AdminProjectStatus?pageNum=${pageInfo.pageNum - 1}'">
			            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			            	<c:choose>
			            		<c:when test="${pageInfo.pageNum eq i}">
			            			<b>${i}</b>
			            		</c:when>
			            		<c:otherwise>
			            			<a href="AdminProjectStatus?pageNum=${i}">${i}</a>
			            		</c:otherwise>
			            	</c:choose>
			            </c:forEach>
			            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
			            onclick="location.href='AdminProjectStatus?pageNum=${pageInfo.pageNum + 1}'">
					</c:if>
	       		</div>
			</div>
		</div>
	</article>
</body>
</html>
