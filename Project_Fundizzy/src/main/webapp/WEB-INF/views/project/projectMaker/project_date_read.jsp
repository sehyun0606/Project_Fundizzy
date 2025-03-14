<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 기간 설정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            height: 100vh;
            margin: 0px;
            display: flex;
        }
        .container {
            width: 50%;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
        }
        .footer{
        	display: none;
        }
        h2 {
            color: #6a1b9a;
            text-align: left;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            color: #4a148c;
        }
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ce93d8;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: #7b1fa2;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background: #4a148c;
        }
        p {
            margin-top: 15px;
            font-size: 16px;
            color: #6a1b9a;
        }
        .main{
            width: 100%;
        }
        .container{
            margin: 5%; 
            margin-top: 0px;
        }
       	.title-section{
        	display: flex;
        	width: 100%;
        	justify-content: space-between;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="/resources/js/projectMaker/project_date.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
    <div class="main">
        <jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
        <div class="container">
            <div class="title-section">
	            <h2>프로젝트 기간 확인</h2>
            </div>
           
            <h4>오픈예정 기간 확인</h4>
            <label for="startDate">시작 날짜</label>
            <p><fmt:formatDate value="${date.open_start_date}" pattern="yyyy-MM-dd"/></p>
            <label for="endDate">종료 날짜</label>
            <p><fmt:formatDate value="${date.open_end_date}" pattern="yyyy-MM-dd"/></p>
    
            
            <h4>펀딩 기간 설정</h4>
            <label for="startDate">시작 날짜</label>
            <p><fmt:formatDate value="${date.project_start_date}" pattern="yyyy-MM-dd"/></p>
    
            <label for="endDate">종료 날짜</label>
            <p><fmt:formatDate value="${date.project_end_date}" pattern="yyyy-MM-dd"/></p>
    
        </div>
    </div>
    
</body>
</html>
