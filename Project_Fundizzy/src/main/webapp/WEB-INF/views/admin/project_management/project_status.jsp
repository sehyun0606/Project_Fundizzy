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
		        <h2>프로젝트 승인</h2>
	        	<form action=""> 
			        <div class="search-bar">
			        	<select name="searchType" style="height: 29px;">
							<option value="" >프로젝트 제목</option>
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
		                <th class="project_status">상세보기</th>
		            </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="project" items="${projectList}" varStatus="status">
			                    <tr>
			                        <td class="project_code">${project.project_code}</td>
			                        <td><img class="project_img" alt="" src="/resources/upload/${project.representative_picture}"></td>
			                        <td>${project.project_title}</td>
			                        <td>
			                            <fmt:formatDate value="${project.request_approve_date}" pattern="yyyy-MM-dd HH:mm"/>
			                        </td>
			                        <td><input type="button" class="project-info" value="상세보기"></td>
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
	
		<!-- 모달 창 -->
	<div class="modal-overlay" id="modal">
	    <div class="modal-content">
	        <!-- 모달 탑 섹션 (카테고리 탭) -->
	        <div class="modal-header">
	            <button class="tab-btn active" data-tab="basic-info">기본 정보</button>
	            <button class="tab-btn" data-tab="review-history">심사 내역</button>
	            <button class="tab-btn" data-tab="extra-info">기타 정보</button>
	            <button class="close-btn">닫기</button>
	        </div>
	
	        <!-- 모달 컨텐츠 -->
	        <div class="modal-body">
	            <!-- 기본 정보 탭 -->
				<div id="basic-info" class="tab-content active">
				    <h3>기본 정보</h3>
				    <table class="info-table">
				        <tr>
				            <th>프로젝트 제목</th>
				            <td id="project-title"></td>
				        </tr>
				        <tr>
				            <th>카테고리</th>
				            <td id="category"></td>
				        </tr>
				        <tr>
				            <th>세부 카테고리</th>
				            <td id="sub-category"></td>
				        </tr>
				        <tr>
				            <th>서비스 타입</th>
				            <td id="service-type"></td>
				        </tr>
				        <tr>
				            <th>목표 금액</th>
				            <td id="target-amount"></td>
				        </tr>
				        <tr>
				            <th>성인 여부</th>
				            <td id="adult-check"></td>
				        </tr>
				        <tr>
				            <th>대표 이미지</th>
				            <td><img id="representative-picture" src="" alt="대표 이미지" class="modal-img"></td>
				        </tr>
				    </table>
				</div>
					            
	            <div id="review-history" class="tab-content">
	                <h3>심사 내역</h3>
	                <p>심사 내역 관련 내용을 여기에 표시합니다.</p>
	            </div>
	            <div id="extra-info" class="tab-content">
	                <h3>기타 정보</h3>
	                <p>추가적인 정보를 여기에 표시합니다.</p>
	            </div>
	        </div>
	    </div>
	</div>

	
	<script type="text/javascript">
		 $(document).ready(function() {
			 let projectCode;
	         // 모달 열기
	         $(".project-info").click(function() {
	             $("#modal").fadeIn();
	             projectCode = $(this).closest("tr").find(".project_code").text();
	             console.log(projectCode)
	             
	              $.ajax({
		  			url : "AdminGetProjectInfo",
					type : "GET",
					data : {
						projectCode
					},
					dataType: "json",  
        			contentType: "application/json; charset=UTF-8"
				}).done(function(result){
					console.log("응답 받은 데이터: ", result);
					
				}).fail(function(){
					console.log("실패..")
				})
	         });
	
	         // 모달 닫기 (닫기 버튼 클릭)
	         $(".close-btn").click(function() {
	             $("#modal").fadeOut();
	         });
	
	         // 모달 닫기 (배경 클릭)
	         $(".modal-overlay").click(function(event) {
	             if (event.target === this) {
	                 $(this).fadeOut();
	             }
	         });
	         
	         // 탭 버튼 클릭 시 내용 변경
	         $(".tab-btn").click(function() {
	             let tabId = $(this).data("tab");
				console.log(projectCode)				
	             // 모든 탭 버튼과 콘텐츠에서 active 제거
	             $(".tab-btn").removeClass("active");
	             $(".tab-content").removeClass("active");
	
	             // 선택한 탭 버튼과 콘텐츠에 active 추가
	             $(this).addClass("active");
	             $("#" + tabId).addClass("active");
	         });
	     });
	</script>
</body>
</html>
