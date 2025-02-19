<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 요금</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0px;
            display: flex;
        }
        .container {
            width: 60%;
            margin: auto;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .pricing-card {
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .pro {
            background: #9b51e0;
            color: white;
        }
        .basic {
            background: white;
            border: 1px solid #ddd;
            color: black;
        }
        .pricing-info {
            display: flex;
            flex-direction: column;
        }
        .plan-title {
            font-size: 18px;
            font-weight: bold;
        }
        .price {
            font-size: 24px;
            font-weight: bold;
            margin: 5px 0;
        }
        .description {
            font-size: 16px;
            font-weight: bold;
        }
        .list-items {
            margin-top: 10px;
            padding-left: 15px;
        }
        .select-btn {
            background: #555;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div style="width: 100%;">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
 	<div class="container">
        <div class="title">서비스 요금</div>
        
        <div class="pricing-card pro">
            <div class="pricing-info">
                <span class="plan-title">프로</span>
                <span class="price">$100</span>
                <span class="description">프로 요금에 관한 요약</span>
                <ul class="list-items">
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                </ul>
            </div>
            <button class="select-btn">선택하기</button>
        </div>

        <div class="pricing-card basic">
            <div class="pricing-info">
                <span class="plan-title">기본</span>
                <span class="price">$50</span>
                <span class="description">기본 요금에 관한 요약</span>
                <ul class="list-items">
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                </ul>
            </div>
            <button class="select-btn">선택하기</button>
        </div>
    </div>	
	</div>
   
</body>
</html>
