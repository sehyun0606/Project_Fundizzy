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
    <link rel="stylesheet" href="resources/css/admin/manage/member_manage.css" />
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
				        <tbody style="font-size: 12px;">
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
				        <tbody style="font-size: 12px;">
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
				        <tbody style="font-size: 12px;">
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
			    <form id="searchForm"> 
			        <div class="search-bar">
			            <select name="searchType" id="searchType" style="height: 29px; font-size: 10px;">
			                <option value="전체">전체</option>
			                <option value="email">이메일</option>
			                <option value="닉네임">닉네임</option>
			                <option value="카카오">카카오</option>
			                <option value="네이버">네이버</option>
			            </select>
			            <input type="text" id="searchMember" placeholder="회원명">
			            <button type="button" class="search-btn">검색</button>
			        </div>
			    </form>
			
			    <table>
			        <thead>
			            <tr>
			                <th>이메일</th>
			                <th>닉네임</th>
			                <th>가입 날짜</th>
			                <th>로그인 방식</th>
			                <th>이미지</th>
			            </tr>
			        </thead>
			        <tbody id="memberTable" style="font-size: 12px;">
			            <c:forEach var="member" items="${memberInfo}" varStatus="status">
			                <tr class="member-row" data-category="${member.login_type.trim().toLowerCase()}"
			                    data-email="${member.email.trim().toLowerCase()}"
			                    data-nickname="${member.nickname.trim().toLowerCase()}"
			                    style="${status.index >= 6 ? 'display: none;' : ''}">
			                    <td>${member.email}</td>
			                    <td>${member.nickname}</td>
			                    <td>
			                        <fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
			                    </td>
			                    <td>${member.login_type}</td>
			                    <td>${member.profile}</td>
			                </tr>
			            </c:forEach>
			        </tbody>
			    </table>
			</div>
		</div>
	</article>
	<script>
		document.addEventListener("DOMContentLoaded", function () {
		    document.getElementById("searchType").addEventListener("change", filterTable);
		    document.querySelector(".search-btn").addEventListener("click", filterTable);
		});
	
		function filterTable() {
		    var selectedType = document.getElementById("searchType").value.trim().toLowerCase();
		    var searchText = document.getElementById("searchMember").value.trim().toLowerCase();
		    var rows = document.querySelectorAll(".member-row");
	
		    rows.forEach(function (row) {
		        var category = row.getAttribute("data-category").trim().toLowerCase();
		        var email = row.getAttribute("data-email").trim().toLowerCase();
		        var nickname = row.getAttribute("data-nickname").trim().toLowerCase();
	
		        // 필터링 조건
		        var categoryMatch = (selectedType === "전체" || category === selectedType);
		        var textMatch = (searchText === "" || email.includes(searchText) || nickname.includes(searchText));
	
		        // 조건에 맞는 경우만 표시
		        row.style.display = (categoryMatch && textMatch) ? "table-row" : "none";
		    });
		}
	</script>
</body>
</html>
