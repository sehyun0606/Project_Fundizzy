<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산요청 관리</title>
<script src="resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="resources/css/admin/admin_home.css" />
<link rel="stylesheet" href="resources/css/admin/settlement_management/settlement_status.css" />
</head>
<body>
	<!-- top.jsp -->
	<header>
		<jsp:include page="/WEB-INF/views/admin/inc/admin_top.jsp" />
	</header>
	<article style="display: flex;">
		<!-- sidebar.jsp -->
		<jsp:include page="/WEB-INF/views/admin/inc/admin_sidebar.jsp" />
	
		<div class="main-content">
	    
		    <!-- 메인 콘텐츠 -->
		    <!-- 회원 정보 -->
		    <div class="member-info">
		        <h2>정산요청 승인</h2>
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
		                <th class="set_code" width="150px">정산 코드</th>
		                <th class="project_code" width="150px">프로젝트 코드</th>
		                <th class="project_title" width="400px">프로젝트 제목</th>
		                <th class="set_status" width="150px">정산 유형</th>
		                <th class="set_date" width="150px">신청 날짜</th>
		                <th class="set_detail" width="150px">상세보기</th>
		            </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="settlement" items="${settlementList}" varStatus="status">
		                    <tr>
		                        <td>${settlement.settlement_code}</td>
		                        <td class="project_code">${settlement.project_code}</td>
		                        <td>${settlement.project_title}</td>
		                        <td>
			                        <c:choose>
			                        	<c:when test="${settlement.settlement_status eq 'SET03'}">
			                        		선정산
			                        	</c:when>
			                        	<c:otherwise>
			                        		최종정산
			                        	</c:otherwise>
			                        </c:choose>
		                        </td>
		                        <td>
		                            <fmt:formatDate value="${settlement.pre_request_date}" pattern="yyyy-MM-dd HH:mm"/>
		                        </td>
		                        <td><input type="button" class="set-info" value="상세보기"></td>
		                    </tr>
			            </c:forEach>
		            </tbody>
		        </table>
		    </div>
		    <div class="page_btn_group">
	    		<div class="page_btn">
					<c:if test="${pageInfo.maxPage != 0}">
			            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
			            	onclick="location.href='SettlementManage?pageNum=${pageInfo.pageNum - 1}'">
			            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			            	<c:choose>
			            		<c:when test="${pageInfo.pageNum eq i}">
			            			<b>${i}</b>
			            		</c:when>
			            		<c:otherwise>
			            			<a href="AdminProjectManage?pageNum=${i}">${i}</a>
			            		</c:otherwise>
			            	</c:choose>
			            </c:forEach>
			            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
			            onclick="location.href='SettlementManage?pageNum=${pageInfo.pageNum + 1}'">
					</c:if>
	       		</div>
			</div>
		</div>
	</article>
	
		<!-- 모달 창 -->
	<div class="modal">
		<div id="pre-modal" class="modal-content">
			<div class="modal-close">x</div>
			<div class="modal-main">
				<h3>상세정보</h3>
				<form action="SetConfirm" method="post">
					<input type="hidden" name="project_code" class="project_code">
					<input type="hidden" name="email" class="email">
					<input type="hidden" name="pay_type" class="pay_type">
					<div class="table-container">
						<table class="detailTable">
							<tr>
								<th>프로젝트명</th>
								<td></td>
							</tr>
							<tr>
								<th>대표자명</th>
								<td></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td></td>
							</tr>
							<tr>
								<th>정산유형</th>
								<td></td>
							</tr>
						</table>
					</div>
					<div class="set-container">
						<div class="set-info" style="border-bottom:1px solid #ddd; padding-bottom:15px">
							<div class="title" id="titleStatus">정산 지급액</div>
							<div class="amount" id="set_amount"></div>
							<input type="hidden" name="pre_amount" class="pre_amount">
							<input type="hidden" name="final_amount" class="final_amount">
							<input type="hidden" name="refund_amount" class="refund_amount">
						</div>
						<div class="set-info">
							<div class="title">총 결제금액</div>
							<div class="amount" id="total_amount"></div>
						</div>
						<div class="set-info">
							<div class="title">수수료</div>
							<div class="amount" id="fee"></div>
							<div class="msg"></div>
						</div>
						<div class="set-info">
							<div class="title">환불금액</div>
							<div class="amount" id="refund_amount"></div>
						</div>
						<div class="buttonSection">
				        	<input type="submit" class="confirm" value="승인하기">
				        	<input type="button" class="close" value="닫기">
				        </div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="/resources/js/admin/settlement_management/settlement_status.js"></script>
</body>
</html>