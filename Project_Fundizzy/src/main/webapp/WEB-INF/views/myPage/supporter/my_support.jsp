<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>찜한 상품</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        .container {
            width: 60%;
            margin: 50px auto;
        }
        
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
		.page_btn_group {
		    text-align: center;
		    margin-top: 20px;
		}
		
		.page_btn a, 
		.page_btn span {
		    display: inline-block;
		    padding: 8px 12px;
		    margin: 0 4px;
		    border-radius: 5px;
		    text-decoration: none;
		    font-size: 14px;
		    color: #6a0dad;
		    border: 1px solid #6a0dad;
		    transition: 0.2s;
		}
		
		.page_btn a:hover {
		    background-color: #6a0dad;
		    color: white;
		}
		
		.page_btn .active {
		    background-color: #6a0dad;
		    color: white;
		    font-weight: bold;
		    cursor: default;
		}
		
		.page_btn .disabled {
		    color: #ccc;
		    border: 1px solid #ccc;
		    cursor: not-allowed;
		}
		.img{
			width: inherit;
		}
		.content{
			display: flex;
			align-items: center;
			margin-left: 20px;
			justify-content: space-between;
			width: 100%;
		}
		.name{
			display: flex;
			align-items: center;
			margin-right: 20px;
		}
		.funding-box {
		   	width: 90%;
		    background: #f8f9fa;
		    padding: 30px;
		    text-align: center;
		    align-items: center;
		    border-radius: 8px;
		    display: flex;
		    justify-content: center;
		    font-size: 14px;
		    height: 150px;
		    color: #666;
		}
		.main {
			display: flex;
		}
		.support-post {
			border: 1px solid mediumpurple;
		    padding: 10px;
		    border-radius: 20px;
		    margin-bottom: 10px;
		}
		.support-title{
			margin: 0;
		}
		.custom-content {
			display: flex;
		}
		button{
			border: 1px solid black;
			background-color: white;
			font-size: 17px;
			border-radius: 5px;
			padding: 7px 14px; /* 내부 여백 추가 (가독성 향상) */
			margin-left: 2px;
			margin-right: 2px;
		    cursor: pointer; /* 버튼 클릭 가능하도록 설정 */
		    transition: border 0.2s ease-in-out;
		}	
		.content{
			margin: 0;
		}
    </style>
   	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
<div class="main">
	<div >
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>

	</div>
	<div class="container">
	    <div class="title">나의 지지서명</div>
		<c:if test="${empty supportList}">
    		<div class="funding-box">
	            나의 지지서명이 없어요. <br>
	            지금 바로 펀디지에서 프로젝트에 참해 보세요.
        	</div>
		</c:if>	    
	    <c:forEach items="${supportList}" var="support">
		   <div class="support-post">
		        <h4 class="support-title">${support.project_title}</h4>
		        <p class="content">${support.support_content}</p>
		        <div class="custom-content"></div>
		        <p class="support-tag" style="display: none;">${support.support_tag}</p>
		        <fmt:formatDate value="${support.support_date}" pattern="yyyy-MM-dd"/><br>
		
		
		    </div>
		    
	    </c:forEach>
		<div class="page_btn_group">
			    <div class="page_btn">
			        <c:if test="${pageInfo.maxPage != 0}">
			            <!-- 이전 페이지 버튼 -->
			            <c:choose>
			                <c:when test="${pageInfo.pageNum eq 1}">
			                    <span class="disabled">이전</span>
			                </c:when>
			                <c:otherwise>
			                    <a href="MySupport?pageNum=${pageInfo.pageNum - 1}">이전</a>
			                </c:otherwise>
			            </c:choose>
			
			            <!-- 페이지 숫자 버튼 -->
			            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			                <c:choose>
			                    <c:when test="${pageInfo.pageNum eq i}">
			                        <span class="active">${i}</span>
			                    </c:when>
			                    <c:otherwise>
			                        <a href="MySupport?pageNum=${i}">${i}</a>
			                    </c:otherwise>
			                </c:choose>
			            </c:forEach>
			
			            <!-- 다음 페이지 버튼 -->
			            <c:choose>
			                <c:when test="${pageInfo.pageNum eq pageInfo.maxPage}">
			                    <span class="disabled">다음</span>
			                </c:when>
			                <c:otherwise>
			                    <a href="MySupport?pageNum=${pageInfo.pageNum + 1}">다음</a>
			                </c:otherwise>
			            </c:choose>
			        </c:if>
			    </div>
			</div>			
	</div>
	
</div>
<script>
$(document).ready(function() {
    $(".support-post").each(function() {
        let tagValue = $(this).find(".support-tag").text().trim(); // support_tag 값 가져오기
        
        let customContent = $(this).find(".custom-content"); // 요소 찾기

        // 1이 포함된 경우
        if (tagValue.includes("1")) {
            customContent.append('<p>👍 취향저격</p>');
        }
        
        // 2가 포함된 경우
        if (tagValue.includes("2")) {
            customContent.append('<p>🔥 삶의 질 급상승</p>');
        }
        
        // 3이 포함된 경우
        if (tagValue.includes("3")) {
            customContent.append('<p>🛠️ 유용템</p>');
        }

        // 4가 포함된 경우
        if (tagValue.includes("4")) {
            customContent.append('<p>💰 가성비</p>');
        }

        // 5가 포함된 경우
        if (tagValue.includes("5")) {
            customContent.append('<p>📣 응원해요</p>');
        }
    });
});

</script>
</body>
</html>
