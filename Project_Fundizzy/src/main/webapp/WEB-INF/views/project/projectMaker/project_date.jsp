<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        .footer{
        	display: none;
        }
        .container {
            width: 50%;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
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
            <form action="ProjectDate" method="post">
            <div class="title-section">
	            <h2>프로젝트 기간 설정</h2>
	            <button  class="btn" >기간 설정 제출</button>
            </div>
           
            <h4>오픈예정 기간 설정</h4>
             <p style="color: #666; font-size: 14px;"> 오픈예정 기간은 원하는 날짜부터 최소 2주 최대 1달동안 진행할 수 있어요!</p>
            <label for="startDate">시작 날짜</label>
            <input type="date" id="openStartDate" name="open_start_date" required="required">
            <label for="endDate">종료 날짜</label>
            <input type="date" id="openEndDate" name="open_end_date" required="required">
    
            <button type="button" class="btn" id="openSetDates">설정 완료</button>
            <p id="openResult"></p>
            
            <h4>펀딩 기간 설정</h4>
            <p style="color: #666; font-size: 14px;"> 펀딩 기간은 오픈예정이 끝난 다음날부터 최소 2주 최대 1달동안 진행할 수 있어요!</p>
            <label for="startDate">시작 날짜</label>
            <input type="date" id="fundStartDate"  disabled required="required">
            <input type="hidden" id="fundStartDate2" name="project_start_date" >
    
            <label for="endDate">종료 날짜</label>
            <input type="date" id="fundEndDate" name="project_end_date" required="required">
    
            <button type="button" class="btn" id="fundSetDates" >설정 완료</button>
            <p id="fundResult"></p>
            </form>
        </div>
    </div>
    
</body>
</html>
