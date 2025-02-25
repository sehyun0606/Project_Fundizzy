<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizy 로그인</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
    	body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .sidebar {
            width: 150px;
            background-color: mediumseagreen;
            color: white;
            padding: 20px;
            height: 100vh;
        }
        .sidebar h2 {
            font-size: 24px;
            margin: 0 0 20px 0;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            margin: 10px 0;
        }
        .content {
            flex: 1;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .chart-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
        }
        .chart {
            width: 45%;
            height: 200px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: #777;
        }
        article {
            display: flex; /* Flexbox 사용 */
        }
        .content {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2열로 나누기 */
            flex: 1; /* 남은 공간을 차지 */
            padding: 20px;
            background-color: white;
            gap: 20px; /* 박스 간의 간격 */
            align-items: center;
        }

        .box {
            height: 400px; /* 고정 높이 */
            background-color: #fff;
            border-style: none;
            border-radius: 5px;
            display: flex; /* Flexbox 사용 */
            flex-direction: column; /* 세로 방향으로 정렬 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
            font-size: 20px;
            color: #333;
            padding: 10px; /* 내부 여백 추가 */
            /* 추가 속성: margin-top: auto; margin-bottom: auto; */
        }
        canvas {
            max-width: 100%;
            max-height: 100%;
        }
    </style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_top.jsp" />
	</header>
	<article>
		<div class="sidebar">
	        <h2>관리자 홈</h2>
	        <ul>
	            <li>사용자 관리</li>
	            <li>프로젝트 관리</li>
	            <li>결제 방법 관리</li>
	            <li>커뮤니티 관리</li>
	        </ul>
	    </div>
	    <div class="content">
	        <div class="box">
	        	<b style="font-size: 20px;">총 프로젝트 현황</b><br>
	        	<canvas id="myPieChart"></canvas>
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">실시간 사용자 현황</b><br>
				<canvas id="myPieChart"></canvas>	        	
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">총 펀딩금액</b><br>
	        	<canvas id="myPieChart"></canvas>
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">사용자 수</b><br>
	        	<canvas id="myPieChart"></canvas>
	        </div>
	    </div>
	</article>
	
	<script>
        const ctx = document.getElementById('myPieChart').getContext('2d');
        const myPieChart = new Chart(ctx, {
            type: 'doughnut', // 원형 그래프
            data: {
                labels: ['완료', '진행 중', '대기 중'], // 레이블
                datasets: [{
                    label: '프로젝트 상태',
                    data: [30, 50, 20], // 데이터 값
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(255, 206, 86, 0.6)',
                        'rgba(153, 102, 255, 0.6)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.label + ': ' + tooltipItem.raw + '%';
                            }
                        }
                    }
                }
            }
        });
    </script>
	
</body>
</html>
