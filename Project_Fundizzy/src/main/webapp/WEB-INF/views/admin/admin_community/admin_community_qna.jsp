<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 관리 페이지</title>
    <script src="resources/js/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="resources/css/admin/community/community_qna.css" />
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
				    <h2>미답변 문의사항</h2>
				    <table>
				        <thead>
				            <tr>
				                <th>이메일</th>
				                <th>문의유형</th>
				                <th>문의내용</th>
				                <th>문의 날짜</th>
				            </tr>
				        </thead>
				        <tbody style="font-size: 12px;">
				            <c:forEach var="unanswerQna" items="${unanswerQnaList}" varStatus="status">
				                <c:if test="${status.index < 5}"> <%-- 0~4 번째 요소(5개)만 출력 --%>
				                    <tr onclick="location.href='#'">
				                        <td>${unanswerQna.email}</td>
				                        <td>${unanswerQna.qna_category}</td>
				                        <td>${unanswerQna.qna_content}</td>
				                        <td>
				                            <fmt:formatDate value="${unanswerQna.qna_create}" pattern="yyyy-MM-dd HH:mm"/>
				                        </td>
				                    </tr>
				                </c:if>
				            </c:forEach>
				        </tbody>
				    </table>
				</div>
				<!-- 최근 탈퇴자 -->
				<div class="recent-leave">
				    <h2>문의사항</h2>
				    <table>
				        <thead>
				            <tr>
				                <th>이메일</th>
				                <th>문의유형</th>
				                <th>문의내용</th>
				                <th>문의 날짜</th>
				            </tr>
				        </thead>
				        <tbody style="font-size: 12px;">
				            <c:forEach var="answerQna" items="${answerQnaList}" varStatus="status">
				                <c:if test="${status.index < 5}"> <%-- 0~4 번째 요소(5개)만 출력 --%>
				                    <tr onclick="location.href='#'">
				                        <td>${answerQna.email}</td>
				                        <td>${answerQna.qna_category}</td>
				                        <td class="truncate">
				                            <c:choose>
				                                <c:when test="${fn:length(answerQna.qna_content) > 20}">
				                                    ${fn:substring(answerQna.qna_content, 0, 20)}...
				                                </c:when>
				                                <c:otherwise>
				                                    ${answerQna.qna_content}
				                                </c:otherwise>
				                            </c:choose>
				                        </td>
				                        <td>
				                            <fmt:formatDate value="${answerQna.qna_create}" pattern="yyyy-MM-dd HH:mm"/>
				                        </td>
				                    </tr>
				                </c:if>
				            </c:forEach>
				        </tbody>
				    </table>
				</div>
			</div>
	    
		    <!-- 메인 콘텐츠 -->
		    <!-- 회원 정보 -->
		    <div class="member-info">
			    <h2>문의사항</h2>
			    <form id="searchForm"> 
			        <div class="search-bar">
			            <select name="searchType" id="searchType" style="height: 29px; font-size: 10px;">
			                <option value="전체">전체</option>
			                <option value="펀디즈">펀디즈</option>
			                <option value="서포터">서포터</option>
			                <option value="메이커">메이커</option>
			                <option value="비회원">비회원</option>
			                <option value="기타">기타</option>
			            </select>
			            <input type="text" id="searchText" placeholder="회원명">
			            <button type="button" class="search-btn" onclick="filterTable()">검색</button>
			        </div>
			    </form>
			
			    <table>
			        <thead>
			            <tr>
			                <th>문의 번호</th>
			                <th>답장 받을 이메일</th>
			                <th>펀디즈 계정 이메일</th>
			                <th>문의유형</th>
			                <th>문의내용</th>
			                <th>답변 상태</th>
			                <th>문의 날짜</th>
			            </tr>
			        </thead>
			        <tbody id="qnaTable" style="font-size: 12px;">
					    <c:forEach var="qna" items="${qnaList}" varStatus="status">
					        <tr class="qna-row" data-category="${qna.qna_category}" style="${status.index >= 6 ? 'display: none;' : ''}">
					            <td>${qna.qna_num}</td>
					            <td>${qna.receive_email}</td>
					            <td>${qna.email}</td>
					            <td>${qna.qna_category}</td>
					            <td class="truncate">
					                <c:choose>
					                    <c:when test="${fn:length(qna.qna_content) > 20}">
					                        ${fn:substring(qna.qna_content, 0, 20)}...
					                    </c:when>
					                    <c:otherwise>
					                        ${qna.qna_content}
					                    </c:otherwise>
					                </c:choose>
					            </td>
					            <td>${qna.qna_status}</td>
					            <td>
					                <fmt:formatDate value="${qna.qna_create}" pattern="yyyy-MM-dd HH:mm"/>
					            </td>
					        </tr>
					    </c:forEach>
					</tbody>
			    </table>
			</div>
		</div>
	</article>
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function () {
		    document.getElementById("searchType").addEventListener("change", filterTable);
		});
	
		function filterTable() {
		    var selectedType = document.getElementById("searchType").value;
		    var rows = document.querySelectorAll(".qna-row");
	
		    rows.forEach(function (row, index) {
		        var category = row.getAttribute("data-category");
	
		        if (selectedType === "전체") {
		            // 전체 선택 시 최근 10개만 보이게 설정
		            row.style.display = index < 6 ? "table-row" : "none";
		        } else {
		            // 특정 카테고리 선택 시 해당 카테고리만 보이게
		            row.style.display = (category === selectedType) ? "table-row" : "none";
		        }
		    });
		}

		document.addEventListener("DOMContentLoaded", function () {
		    document.getElementById("searchType").addEventListener("change", filterTable);
		    document.querySelector(".search-btn").addEventListener("click", filterTable);
		});

		function filterTable() {
		    var selectedType = document.getElementById("searchType").value;
		    var searchText = document.getElementById("searchText").value.trim().toLowerCase();
		    var rows = document.querySelectorAll(".qna-row");

		    rows.forEach(function (row, index) {
		        var category = row.getAttribute("data-category");
		        var email = row.cells[2].textContent.trim().toLowerCase(); // 펀디즈 계정 이메일 컬럼
		        var name = row.cells[1].textContent.trim().toLowerCase(); // 답장 받을 이메일 컬럼
		        var qnaContent = row.cells[4].textContent.trim().toLowerCase(); // 문의 내용 컬럼

		        // 검색 조건
		        var categoryMatch = (selectedType === "전체" || category === selectedType);
		        var textMatch = (searchText === "" || email.includes(searchText) || name.includes(searchText) || qnaContent.includes(searchText));

		        if (categoryMatch && textMatch) {
		            row.style.display = "table-row";
		        } else {
		            row.style.display = "none";
		        }
		    });
		}

	</script>
</body>
</html>
