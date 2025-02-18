<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
        }
        .container {
            width: 50%;
            margin: auto;
        }
        .header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .status-box {
            background: #f4f4f4;
            padding: 15px;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .status-box button {
            background: #6c5ce7;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .task {
            display: flex;
            align-items: center;
            background: white;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            margin-top: 10px;
            justify-content: space-between;
        }
        .task .task-title {
            display: flex;
            align-items: center;
        }
        .task .status {
            margin-left: 10px;
            color: #777;
        }
        .task .progress-bar {
            width: 5px;
            height: 40px;
            border-radius: 5px;
            margin-right: 10px;
        }
        .progress-complete { background: purple; }
        .progress-incomplete { background: lightgray; }
        .task button {
            background: white;
            border: 1px solid #6c5ce7;
            color: #6c5ce7;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .main{
            padding-top: 2%;
		    margin-top: 5%;
		    width: 100%;
		    border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main">
	    <div class="container">
	        <div class="header">프로젝트 관리</div>
	        <div class="status-box">
	            <span>프로젝트 준비 상태</span>
	            <button>제출하기</button>
	        </div>
	        <div class="task">
	            <div class="task-title">
	                <div class="progress-bar progress-complete"></div>
	                서비스 요금 <span class="status">작성 완료</span>
	            </div>
	            <button>작성하기</button>
	        </div>
	        <div class="task">
	            <div class="task-title">
	                <div class="progress-bar progress-incomplete"></div>
	                프로젝트 정보 <span class="status">작성 전</span>
	            </div>
	            <button>작성하기</button>
	        </div>
	        <div class="task">
	            <div class="task-title">
	                <div class="progress-bar progress-complete"></div>
	                스토리 작성 <span class="status">작성 중</span>
	            </div>
	            <button>작성하기</button>
	        </div>
	        <div class="task">
	            <div class="task-title">
	                <div class="progress-bar progress-incomplete"></div>
	                리워드 설계 <span class="status">작성 전</span>
	            </div>
	            <button>작성하기</button>
	        </div>
	        <div class="task">
	            <div class="task-title">
	                <div class="progress-bar progress-incomplete"></div>
	                메이커 정보 <span class="status">작성 전</span>
	            </div>
	            <button>작성하기</button>
	        </div>
	    </div>
    </div>
</body>
</html>
