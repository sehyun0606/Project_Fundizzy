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
					    	<c:if test="${param.searchType eq ''}"></c:if>
					        <select name="searchType" id="searchType" style="height: 29px; font-size: 10px;">
					            <option value="전체" <c:if test="${param.searchType eq '전체'}">selected</c:if>>전체</option>
					            <option value="미답변" <c:if test="${param.searchType eq '미답변'}">selected</c:if>>미답변</option>
					            <option value="펀디즈" <c:if test="${param.searchType eq '펀디즈'}">selected</c:if>>펀디즈</option>
					            <option value="서포터" <c:if test="${param.searchType eq '서포터'}">selected</c:if>>서포터</option>
					            <option value="메이커" <c:if test="${param.searchType eq '메이커'}">selected</c:if>>메이커</option>
					            <option value="비회원" <c:if test="${param.searchType eq '비회원'}">selected</c:if>>비회원</option>
					        </select>
					        <input type="text"  id="searchText" name="searchKeyword" value="${param.searchKeyword}">
					        <button type="submit" class="search-btn">검색</button>
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
			<section id="pageList" class="pageList">
				<%-- 검색어가 있을 경우 변수를 사용하여 '&searchType=타입&searchKeyword=키워드' 문자열 저장 --%>
				<%-- 페이지 이동 하이퍼링크 파라미터부분에 검색관련 파라미터 저장된 변수 결합 --%>
				<%-- 검색어가 없을 경우 변수가 생성되지 않으므로 널스트링("")이 결합되므로 변화 없음 --%>
				<c:if test="${not empty param.searchKeyword}">
					<c:set var="searchParam" value="&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}" />
				</c:if>
				<%-- [이전] 버튼 클릭 시 현재 페이지의 이전 페이지 요청(2 페이지 일 경우 1 페이지 요청) --%>
				<%-- 현재 목록의 페이지번호 - 1 값을 파라미터로 전달 --%>
				<%-- 단, 현재 페이지가 1 페이지일 경우 비활성화(disabled) --%>
				<input type="button" value="이전" 
					onclick="location.href='qnaBoardList?pageNum=${pageInfo.pageNum - 1}${searchParam}'" 
					<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
				
				<%-- 계산된 페이지 번호가 저장된 PageInfo 객체(pageInfo) 를 통해 페이지번호 반복 출력 --%>
				<%-- startPage 부터 endPage 까지 1씩 증가하면서 페이지번호 출력 --%>
				<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					<%-- 각 페이지번호 마다 하이퍼링크 설정 --%>
					<%-- 단, 현재 페이지(i값과 pageNum 동일)는 하이퍼링크 없이 굵게(<strong>) 표시 --%>
					<c:choose>
						<c:when test="${i eq pageInfo.pageNum}">
							<strong>${i}</strong>
						</c:when>
						<c:otherwise>
							<%-- 페이지번호 하이퍼링크 클릭 시 BoardList 서블릿 요청(파라미터 : 페이지번호) --%>
							<a href="qnaBoardList?pageNum=${i}${searchParam}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<%-- [다음] 버튼 클릭 시 현재 페이지의 다음 페이지 요청(2 페이지 일 경우 3 페이지 요청) --%>
				<%-- 현재 목록의 페이지번호 + 1 값을 파라미터로 전달 --%>
				<%-- 단, 현재 페이지가 최대 페이지 번호와 동일할 경우 비활성화(disabled) --%>
				<input type="button" value="다음" 
					onclick="location.href='qnaBoardList?pageNum=${pageInfo.pageNum + 1}${searchParam}'" 
					<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
			</section>
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
// 		document.addEventListener("DOMContentLoaded", function () {
// 		    document.getElementById("searchType").addEventListener("change", filterTable);
// 		    document.querySelector(".search-btn").addEventListener("click", filterTable);
// 		    document.getElementById("searchText").addEventListener("keyup", function (event) {
// 		        if (event.key === "Enter") {
// 		            filterTable();
// 		        }
// 		    });
// 		});
	
// 		// ✅ 필터링 기능 개선 (미답변/답변 리스트는 변경되지 않음)
// 		function filterTable() {
// 		    var selectedType = document.getElementById("searchType").value.trim();
// 		    var searchText = document.getElementById("searchText").value.trim().toLowerCase();
		    
// 		    // ✅ 검색 대상: "문의사항" 테이블 내부의 행들만 필터링
// 		    var rows = document.querySelectorAll("#qnaTable .qna-row");
	
// 		    rows.forEach(function (row) {
// 		        var category = row.getAttribute("data-category") ? row.getAttribute("data-category").trim() : "";
// 		        var email = row.getAttribute("data-email") ? row.getAttribute("data-email").trim().toLowerCase() : "";
// 		        var receiveEmail = row.cells[1] ? row.cells[1].textContent.trim().toLowerCase() : "";
// 		        var qnaContent = row.getAttribute("data-content") ? row.getAttribute("data-content").trim().toLowerCase() : "";
	
// 		        // ✅ 필터링 조건 (카테고리 또는 검색어 일치 여부)
// 		        var categoryMatch = (selectedType === "전체" || category === selectedType);
// 		        var textMatch = (searchText === "" || email.includes(searchText) || receiveEmail.includes(searchText) || qnaContent.includes(searchText));
	
// 		        // ✅ 검색 결과가 일치하는 경우만 보이기
// 		        row.style.display = (categoryMatch && textMatch) ? "table-row" : "none";
// 		    });
// 		}




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
