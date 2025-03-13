<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 기간 설정</title>
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
            width: 100%;
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
        	width: 80%;
        	margin: 5%; 
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container">
	        <h2>프로젝트 기간 설정</h2>
	        <label for="startDate">시작 날짜</label>
	        <input type="date" id="startDate">
	
	        <label for="endDate">종료 날짜</label>
	        <input type="date" id="endDate">
	
	        <button class="btn" onclick="showSelectedDates()">설정 완료</button>
	        <p id="result"></p>
	    </div>
	</div>

    <script>
        function showSelectedDates() {
            let startDate = document.getElementById("startDate").value;
            let endDate = document.getElementById("endDate").value;
            if (startDate && endDate) {
                document.getElementById("result").innerText = `선택한 기간: ${startDate} ~ ${endDate}`;
            } else {
                document.getElementById("result").innerText = "날짜를 모두 선택해주세요.";
            }
        }
    </script>
</body>
</html>