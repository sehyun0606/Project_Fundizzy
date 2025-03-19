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
		    <!-- 전체 문의사항 -->
		    <div class="qna">
			    <h2>문의사항</h2>
			    	<form action="qnaBoardList" method="get">
					    <div class="search-bar">
					    	<c:if test="${param.searchType eq '전체'}"></c:if>
					        <select name="searchType" id="searchType" style="height: 29px; font-size: 10px;">
					            <option value="전체">전체</option>
					            <option value="펀디즈">펀디즈</option>
					            <option value="서포터">서포터</option>
					            <option value="메이커">메이커</option>
					            <option value="비회원">비회원</option>
					            <option value="기타">기타</option>
					        </select>
					        <input type="text"  id="searchText" name="searchKeyword" value="${param.searchKeyword}" required>
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
			        	<c:choose>
			        		<c:when test="${empty qnaList }">
					  			<tr><td colspan="4">게시물이 존재하지 않습니다</td></tr>	
			        		</c:when>
			        		<c:otherwise>
							    <c:forEach var="qna" items="${qnaList}" varStatus="status">
								    <tr class="qna-row" 
								    	data-qnaNum="${qna.qna_num}"
								    	data-receiveEmail="${qna.receive_email }"
								        data-email="${qna.email}" 
								        data-category="${qna.qna_category}" 
								        data-content="${qna.qna_content}"
								        data-date="<fmt:formatDate value='${qna.qna_create}' pattern='yyyy-MM-dd'/>"
								        data-status="${qna.qna_status}"
								        data-reply="${qna.qna_answer}"
		<%-- 						        style="${status.index >= 6 ? 'display: none;' : ''}" --%>
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
								            <fmt:formatDate value="${qna.qna_create}" pattern="yyyy-MM-dd"/>
								        </td>
								    </tr>
								</c:forEach>
			        		</c:otherwise>
			        	</c:choose>
					</tbody>
			    </table>
			</div>
			<nav class="d-flex justify-content-center">
				<ul class="pagination">
					<c:if test="${not empty param.searchKeyword}">
						<c:set var="searchParam" value="&serachType=${param.searchType}&serachKeyword=${param.searchKeyword}"></c:set>
					</c:if>
					<li class="page-item">
<%--                                     <a class="page-link" href="Notice?pageNum=${pageInfo.pageNum - 1}${searchParam}" <c:if test="${pageInfo.pageNum eq 1}" >disabled</c:if>>&#9664;</a> --%>
						<input type="button" class="page-link" value="&#9664;" onclick="location.href='Notice?pageNum=${pageInfo.pageNum - 1}${searchParam}'" 
						<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if> />
					</li>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq pageInfo.pageNum}">
								<a class="page-link"><b>${i}</b></a>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="Notice?pageNum=${i}${searchParam}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<li class="page-item">
						<input type="button" class="page-link" value="&#9654;" onclick="location.href='Notice?pageNum=${pageInfo.pageNum + 1}${searchParam}'" 
						<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}" >disabled</c:if>/>
					</li>
				</ul>
       		</nav>
		</div>
	</article>
	<!-- 모달창 -->
	<div id="qnaModal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closeModal()">&times;</span>
	        <h2 style="margin-top: 0px;">문의 상세 정보</h2>
	
	        <div class="modal-info">
	            <p><strong>문의 번호:</strong> <span id="modalQnaNum"></span></p>
	            <p><strong>이메일:</strong> <span id="modalEmail"></span></p>
	            <p><strong>답장 받을 이메일:</strong> <span id="modalReceiveEmail"></span></p>
	            <p><strong>문의 유형:</strong> <span id="modalCategory"></span></p>
	            <p><strong>문의 날짜:</strong> <span id="modalDate"></span></p>
	        </div>
	        <hr> <!-- ✅ 회색 구분선 추가 -->
	        <p><strong>문의 내용:</strong></p>
	        <div class="modal-textbox" id="modalContent"></div> <!-- ✅ 문의 내용 스크롤 가능 -->
	        <!-- ✅ 관리자 답변 입력 폼 -->
	        <div class="admin-reply">
	            <label for="replyContent"><strong>관리자 답변:</strong></label>
	            <textarea id="replyContent" placeholder="답변을 입력하세요"></textarea>
	            <p id="replyCompleted" style="display: none; color: green; font-weight: bold;">답변 완료</p>
	            <button id="saveReplyBtn" onclick="saveReply()">답변 보내기</button>
	        </div>
	    </div>
	</div>

	
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function () {
		    document.getElementById("searchType").addEventListener("change", filterTable);
		    document.querySelector(".search-btn").addEventListener("click", filterTable);
		    document.getElementById("searchText").addEventListener("keyup", function (event) {
		        if (event.key === "Enter") {
		            filterTable();
		        }
		    });
		});
	
		// ✅ 필터링 기능 개선 (미답변/답변 리스트는 변경되지 않음)
		function filterTable() {
		    var selectedType = document.getElementById("searchType").value.trim();
		    var searchText = document.getElementById("searchText").value.trim().toLowerCase();
		    
		    // ✅ 검색 대상: "문의사항" 테이블 내부의 행들만 필터링
		    var rows = document.querySelectorAll("#qnaTable .qna-row");
	
		    rows.forEach(function (row) {
		        var category = row.getAttribute("data-category") ? row.getAttribute("data-category").trim() : "";
		        var email = row.getAttribute("data-email") ? row.getAttribute("data-email").trim().toLowerCase() : "";
		        var receiveEmail = row.cells[1] ? row.cells[1].textContent.trim().toLowerCase() : "";
		        var qnaContent = row.getAttribute("data-content") ? row.getAttribute("data-content").trim().toLowerCase() : "";
	
		        // ✅ 필터링 조건 (카테고리 또는 검색어 일치 여부)
		        var categoryMatch = (selectedType === "전체" || category === selectedType);
		        var textMatch = (searchText === "" || email.includes(searchText) || receiveEmail.includes(searchText) || qnaContent.includes(searchText));
	
		        // ✅ 검색 결과가 일치하는 경우만 보이기
		        row.style.display = (categoryMatch && textMatch) ? "table-row" : "none";
		    });
		}




		$(document).ready(function () {
		    // ✅ 모달창 열기
		    function openModal(row) {
		        var $row = $(row);
		        var qnaNum = $row.data("qnanum");
		        var email = $row.data("email");
		        var receiveEmail = $row.data("receiveemail");
		        var category = $row.data("category");
		        var content = $row.data("content");
		        var date = $row.data("date");
		        var status = $row.data("status"); // ✅ 답변 상태
		        var reply = $row.data("reply"); // ✅ 관리자 답변 내용

		        $("#modalQnaNum").text(qnaNum);
		        $("#modalEmail").text(email);
		        $("#modalReceiveEmail").text(receiveEmail);
		        $("#modalCategory").text(category);
		        $("#modalContent").text(content);
		        $("#modalDate").text(date);

		        var $replyContent = $("#replyContent");
		        var $replyCompleted = $("#replyCompleted");
		        var $saveReplyBtn = $("#saveReplyBtn");

		        if (status === "Y") { // ✅ 답변 완료된 경우
		            $replyContent.val(reply).prop("disabled", true); // ✅ 비활성화
		            $replyCompleted.show(); // ✅ '답변 완료' 표시
		            $saveReplyBtn.hide(); // ✅ 버튼 숨기기
		        } else { // ✅ 미답변인 경우
		            $replyContent.val("").prop("disabled", false); // ✅ 활성화
		            $replyCompleted.hide(); // ✅ '답변 완료' 숨기기
		            $saveReplyBtn.show(); // ✅ 버튼 보이기
		        }

		        $("#qnaModal").fadeIn(); // ✅ 부드럽게 모달 표시
		    }

		    // ✅ 모달창 닫기
		    function closeModal() {
		        $("#qnaModal").fadeOut(); // ✅ 부드럽게 닫기
		    }

		    // ✅ 답변 저장 기능 (AJAX 요청)
		    function saveReply() {
		    	var qnaNum = $("#modalQnaNum").text();
		        var email = $("#modalReceiveEmail").text();
		        var content = $("#modalContent").text();
		        var replyContent = $("#replyContent").val().trim();

		        if (replyContent === "") {
		            alert("답변을 입력해주세요.");
		            return;
		        }
		        // ✅ AJAX 요청으로 답변 저장
		        $.ajax({
			        url: 'sendReply',
			        type: 'GET',
			        data: {
			        	qnaNum,
			        	email,
			        	content,
			        	replyContent
			        }
				}).done(function(result){
					if(result.trim() == "true") {
						alert("메일 발송 성공!")
						closeModal();
						location.reload();
					} else {
						alert("메일 전송 실패!")
					}
				}).fail(function(){
					alert("메일 전송 실패!");
				});
		    }

		    // ✅ ESC 키 눌렀을 때 모달 닫기
		    $(document).on("keydown", function (event) {
		        if (event.key === "Escape") {
		            closeModal();
		        }
		    });

		    // ✅ 이벤트 핸들러 연결
		    $(".qna-row").on("click", function () {
		        openModal(this);
		    });

		    $(".close").on("click", function () {
		        closeModal();
		    });

		    $("#saveReplyBtn").on("click", function () {
		        saveReply();
		    });
		});



	</script>
</body>
</html>
