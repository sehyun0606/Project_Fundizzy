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
        
        .product-box {
            border: 1px solid #c69df1;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            position: relative;
            display: flex;
        }
        
        .category {
            font-size: 20px;
            display: flex;
		    align-items: center;
		    margin-left: 20px;
        }
        
        .status {
            font-size: 14px;
            color: #8a2be2;
            font-weight: bold;
        }
        
        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin: 5px 0;
        }
        
        .company {
            font-size: 14px;
            color: black;
        }
        
        .payment-info {
            font-size: 14px;
            color: black;
        }
        
        .refund {
            position: absolute;
            right: 20px;
            top: 20px;
            color: #8a2be2;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        
        .pagination a {
            text-decoration: none;
            color: black;
            padding: 8px 12px;
            margin: 0 5px;
            border-radius: 5px;
        }
        
        .pagination a.active {
            background-color: black;
            color: white;
        }
        
        .pagination a:hover {
            background-color: #ddd;
        }
        
        .main{
        	display: flex;
        }
        
        .img-section{
        	width: 100px;
        }
        
        .info{
	        display: flex;
		    justify-content: space-between;
        }
        
        .payment-info {
        	margin-top: auto;
        }
        
        .modal {
            display: none; 
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 300px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .close-btn {
            cursor: pointer;
            padding: 5px 10px;
            background: #ff4d4d;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .submit-btn {
            cursor: pointer;
            padding: 5px 10px;
            background: black;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .button-section{
        	display: flex;
        	justify-content: space-between;
        	width: 290px;
        }
        form {
		    display: flex;
		    flex-direction: column;
		}
		
		label {
		    font-weight: bold;
		    margin-top: 10px;
		}
		
		/* input-group: 단위(원, 개)를 오른쪽에 표시 */
		.input-group {
		    display: flex;
		    align-items: center;
		}
		
		.input-group span {
		    margin-left: 10px;
		}
		.text-count{
			display: flex;
			color: #bbb;
		}
		#rewardDesc{
			height: 100px;
			resize: none;
		}
		/* 페이지네이션 버튼 그룹 */
		.page_btn_group {
		    position: relative;
		}
		
		/* 페이지네이션 버튼 컨테이너 */
		.page_btn {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 10px;
		    margin-top: 20px;
		    
		}
		
		/* 페이지네이션 숫자 & 링크 스타일 */
		.page_btn a, .page_btn b {
		    padding: 5px;
		    font-size: 16px;
		    text-decoration: none;
		    color: black;
		}
		
		/* 현재 페이지 강조 */
		.page_btn b {
		    font-weight: bold;
		    color: mediumpurple;
		}
		
		/* 페이지 버튼 스타일 */
		.page_btn input[type="button"] {
		    padding: 10px;
		    border: 1px solid #aaa;
		    background-color: #fff;
		    cursor: pointer;
		    border-radius: 3px;
		    width: fit-content;
		}
		
		/* 비활성화된 버튼 */
		.page_btn input[type="button"]:disabled {
		    background-color: #ddd;
		    cursor: not-allowed;
		    width: fit-content;
		}
		
/* 		.underContainer { */
/* 			display: flex; */
/* 			justify-content: flex-end; */
/* 		} */
		
		/* 배송완료, 배송조회 버튼 */
		.ship {
			display: flex;
			justify-content: flex-end;
			gap: 10px;
		}
		
		.shipCompleteBtn, .shipCheckBtn {
			margin: 0;
			width: unset;
			cursor: pointer;
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
	    <div class="title">찜한 프로젝트</div>
		<c:if test="${empty likeList}">
    		<div class="funding-box">
	            찜한 프로젝트가 없어요. <br>
	            지금 바로 펀디지에서 프로젝트에 참해 보세요.
        	</div>
		</c:if>	    
	    <c:forEach items="${likeList}" var="like">
		    <div class="product-box">
		    	<input type="hidden" value="${like.project_code}" class="code">
		        <div class="info">
		        	<div class="img-section">
		        		<img class="img" src="/resources/upload/${like.representative_picture }"/>
		        	</div>
		        </div>
		        <div class="category">${like.project_title}</div>
		        <div class="content">
		        	<span>${like.project_content}</span>
		        	<div class="name">${like.representative_name}</div>
		        </div>
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
			                    <a href="LikeHistory?pageNum=${pageInfo.pageNum - 1}">이전</a>
			                </c:otherwise>
			            </c:choose>
			
			            <!-- 페이지 숫자 버튼 -->
			            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			                <c:choose>
			                    <c:when test="${pageInfo.pageNum eq i}">
			                        <span class="active">${i}</span>
			                    </c:when>
			                    <c:otherwise>
			                        <a href="LikeHistory?pageNum=${i}">${i}</a>
			                    </c:otherwise>
			                </c:choose>
			            </c:forEach>
			
			            <!-- 다음 페이지 버튼 -->
			            <c:choose>
			                <c:when test="${pageInfo.pageNum eq pageInfo.maxPage}">
			                    <span class="disabled">다음</span>
			                </c:when>
			                <c:otherwise>
			                    <a href="LikeHistory?pageNum=${pageInfo.pageNum + 1}">다음</a>
			                </c:otherwise>
			            </c:choose>
			        </c:if>
			    </div>
			</div>			
	</div>
	
</div>
   
<script type="text/javascript">
	$(document).ready(function(){
		$(".product-box").click(function(){
			let projectCode = $(this).children("input.code").val();
			location.href = "FundBoardStory?project_code=" + projectCode;
		});
	});
</script>
</body>
</html>
