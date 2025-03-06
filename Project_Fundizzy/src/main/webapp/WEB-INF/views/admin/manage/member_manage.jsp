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
    <link rel="stylesheet" href="resources/css/admin/admin_member_manage.css" />
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
		    <div class="flex-container">
		        <!-- 최근 가입자 -->
				<div class="recent-join">
				    <h2>최근 가입자</h2>
				    <table>
				        <thead>
				            <tr>
				                <th>이메일</th>
				                <th>가입 날짜</th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:forEach var="member" items="${recentRegDate}" varStatus="status">
				                <c:if test="${status.index < 5}"> <%-- 0~4 번째 요소(5개)만 출력 --%>
				                    <tr onclick="location.href='#'">
				                        <td>${member.email}</td>
				                        <td>
				                            <fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
				                        </td>
				                    </tr>
				                </c:if>
				            </c:forEach>
				        </tbody>
				    </table>
				</div>
				<!-- 최근 탈퇴자 -->
				<div class="recent-leave">
				    <h2>최근 탈퇴자</h2>
				    <table>
				        <thead>
				            <tr>
				                <th>이메일</th>
				                <th>가입 날짜</th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:forEach var="member" items="${recentWithdrawDate}" varStatus="status">
				                <c:if test="${status.index < 5}"> <%-- 0~4 번째 요소(5개)만 출력 --%>
				                    <tr onclick="location.href='#'">
				                        <td>${member.email}</td>
				                        <td>
				                            <fmt:formatDate value="${member.withdraw_date}" pattern="yyyy-MM-dd HH:mm"/>
				                        </td>
				                    </tr>
				                </c:if>
				            </c:forEach>
				        </tbody>
				    </table>
				</div>
				<!-- 휴면계정 -->
				<div class="dormant-account">
				    <h2>휴면계정</h2>
				    <table>
				        <thead>
				            <tr>
				                <th>이메일</th>
				                <th>가입 날짜</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr onclick="location.href='#'">
				                <td>naver@naver.com</td>
				                <td>2025.02.17</td>
				            </tr>
				        </tbody>
				    </table>
				</div>
			</div>
	    
		    <!-- 메인 콘텐츠 -->
		    <!-- 회원 정보 -->
		    <div class="member-info">
		        <h2>회원 정보</h2>
		        <div class="search-bar">
		            <input type="text" placeholder="회원명">
		            <button>검색</button>
		        </div>
		
		        <table>
		            <thead>
		            <tr>
		                <th>이메일</th>
		                <th>가입 날짜</th>
		                <th>상태</th>
		                <th>이미지</th>
		            </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="member" items="${memberInfo}" varStatus="status">
			                <c:if test="${status.index < 8}"> <%-- 0~4 번째 요소(5개)만 출력 --%>
			                    <tr onclick="location.href='#'">
			                        <td>${member.email}</td>
			                        <td>
			                            <fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
			                        </td>
			                        <td>${member.login_type}</td>
			                        <td>${member.profile}</td>
			                    </tr>
			                </c:if>
			            </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</div>
	</article>
</body>
</html>
