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
				<div class="unAnswer">
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
				                    <tr class="qna-row" 
						                data-email="${unanswerQna.email}" 
						                data-category="${unanswerQna.qna_category}" 
						                data-content="${unanswerQna.qna_content}"
						                data-date="<fmt:formatDate value='${unanswerQna.qna_create}' pattern='yyyy-MM-dd HH:mm'/>"
						                data-status="${unanswerQna.qna_status}"  <%-- ✅ 답변 상태 추가 --%>
						                data-reply="${unanswerQna.reply_content}"  <%-- ✅ 관리자 답변 내용 추가 --%>
						                onclick="openModal(this)">
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
				<div class="answer">
				    <h2>답변한 문의사항</h2>
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
				                    <tr class="qna-row" 
						                data-email="${answerQna.email}" 
						                data-category="${answerQna.qna_category}" 
						                data-content="${answerQna.qna_content}"
						                data-date="<fmt:formatDate value='${answerQna.qna_create}' pattern='yyyy-MM-dd HH:mm'/>"
						                data-status="${answerQna.qna_status}"  <%-- ✅ 답변 상태 추가 --%>
						                data-reply="${answerQna.reply_content}"  <%-- ✅ 관리자 답변 내용 추가 --%>
						                onclick="openModal(this)">
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
		    <div class="qna">
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
				        <button type="button" class="search-btn">검색</button>
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
						    <tr class="qna-row" 
						        data-email="${qna.email}" 
						        data-category="${qna.qna_category}" 
						        data-content="${qna.qna_content}"
						        data-date="<fmt:formatDate value='${qna.qna_create}' pattern='yyyy-MM-dd HH:mm'/>"
						        data-status="${qna.qna_status}"
						        data-reply="${qna.reply_content}"
						        style="${status.index >= 6 ? 'display: none;' : ''}"
						        onclick="openModal(this)">
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
	<!-- 모달창 -->
	<div id="qnaModal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closeModal()">&times;</span>
	        <h2>문의 상세 정보</h2>
	
	        <p><strong>이메일:</strong> <span id="modalEmail"></span></p>
	        <p><strong>문의 유형:</strong> <span id="modalCategory"></span></p>
	        <p><strong>문의 내용:</strong> <span id="modalContent"></span></p>
	        <p><strong>문의 날짜:</strong> <span id="modalDate"></span></p>
	
	        <!-- ✅ 관리자 답변 입력 폼 -->
	        <div class="admin-reply">
			    <label for="replyContent"><strong>관리자 답변:</strong></label>
			    <textarea id="replyContent" placeholder="답변을 입력하세요"></textarea>
			    <p id="replyCompleted" style="display: none; color: green; font-weight: bold;">답변 완료</p>  <%-- ✅ 답변 완료 텍스트 추가 --%>
			    <button id="saveReplyBtn" onclick="saveReply()">답변 저장</button>
			</div>
	    </div>
	</div>

	
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function () {
		    document.getElementById("searchType").addEventListener("change", filterTable);
		    document.querySelector(".search-btn").addEventListener("click", filterTable);
		});
	
		// ✅ 필터링 및 검색 기능
		function filterTable() {
		    var selectedType = document.getElementById("searchType").value;
		    var searchText = document.getElementById("searchText").value.trim().toLowerCase();
		    var rows = document.querySelectorAll(".qna-row");
	
		    rows.forEach(function (row, index) {
		        var category = row.getAttribute("data-category") ? row.getAttribute("data-category").trim().toLowerCase() : "";
		        var email = row.cells[2].textContent.trim().toLowerCase();
		        var name = row.cells[1].textContent.trim().toLowerCase();
		        var qnaContent = row.cells[4].textContent.trim().toLowerCase();
	
		        // ✅ 검색 조건
		        var categoryMatch = (selectedType === "전체" || category === selectedType.toLowerCase());
		        var textMatch = (searchText === "" || email.includes(searchText) || name.includes(searchText) || qnaContent.includes(searchText));
	
		        // ✅ 조건이 모두 만족하면 보이도록 설정
		        if (categoryMatch && textMatch) {
		            row.style.display = "table-row";
		        } else {
		            row.style.display = "none";
		        }
		    });
		}


		// ✅ 모달창 열기
		function openModal(row) {
		    var email = row.getAttribute("data-email");
		    var category = row.getAttribute("data-category");
		    var content = row.getAttribute("data-content");
		    var date = row.getAttribute("data-date");
		    var status = row.getAttribute("data-status"); // ✅ 답변 상태 가져오기
		    var reply = row.getAttribute("data-reply"); // ✅ 관리자 답변 내용 가져오기

		    document.getElementById("modalEmail").textContent = email;
		    document.getElementById("modalCategory").textContent = category;
		    document.getElementById("modalContent").textContent = content;
		    document.getElementById("modalDate").textContent = date;

		    var replyContent = document.getElementById("replyContent");
		    var replyCompleted = document.getElementById("replyCompleted");
		    var saveReplyBtn = document.getElementById("saveReplyBtn");

		    if (status == "Y") { // ✅ 이미 답변 완료된 경우
		        replyContent.value = reply || "답변을 완료했습니다.";
		        replyContent.disabled = true; // ✅ 텍스트박스 비활성화
		        replyCompleted.style.display = "block"; // ✅ '답변 완료' 표시
		        saveReplyBtn.style.display = "none"; // ✅ 버튼 숨기기
		    } else { // ✅ 미답변인 경우
		        replyContent.value = "";
		        replyContent.disabled = false; // ✅ 텍스트박스 활성화
		        replyCompleted.style.display = "none"; // ✅ '답변 완료' 숨기기
		        saveReplyBtn.style.display = "block"; // ✅ 버튼 보이기
		    }

		    document.getElementById("qnaModal").style.display = "block";
		}

		// ✅ 모달창 닫기
		function closeModal() {
		    document.getElementById("qnaModal").style.display = "none";
		}

		// ✅ 답변 저장 기능 (AJAX 요청)
		function saveReply() {
		    var email = document.getElementById("modalEmail").textContent;
		    var replyContent = document.getElementById("replyContent").value;

		    if (replyContent.trim() === "") {
		        alert("답변을 입력해주세요.");
		        return;
		    }

		    // AJAX 요청으로 답변 저장
// 		    $.ajax({
// 		        type: "POST",
// 		        url: "saveReply",
// 		        data: {
// 		            email: email,
// 		            replyContent: replyContent
// 		        },
// 		        success: function(response) {
// 		            alert("답변이 저장되었습니다.");
// 		            closeModal();
// 		        },
// 		        error: function() {
// 		            alert("답변 저장에 실패했습니다.");
// 		        }
// 		    });
		}

		// ✅ ESC 키 눌렀을 때 모달 닫기
		window.addEventListener("keydown", function (event) {
		    if (event.key === "Escape") {
		        closeModal();
		    }
		});


	</script>
</body>
</html>
