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
            width: 160px;
		    background-color: mediumseagreen;
		    color: white;
		    padding: 20px;
		    height: 100vh;
        }
        .sidebar h2 {
            font-size: 24px;
            margin: 0 0 20px 0;
            cursor: pointer;
        }
        .menu {
		    display: flex;
		    align-items: center;
		    padding: 10px 0;
		    cursor: pointer;
		    transition: background-color 0.3s, color 0.3s; /* 호버 시 부드러운 애니메이션 추가 */
		}
	
		.submenu {
		    display: none;
		    list-style: inside;
		    padding-left: 0px;
		    transition: max-height 0.3s ease-out;
		    overflow: hidden;
		    max-height: 0;
		}
        .menu, .submenu li {
		    padding: 10px 0;
		    cursor: pointer;
		    transition: font-size 0.3s ease, font-weight 0.3s ease, color 0.3s ease; /* 크기, 두께, 색상 모두 부드럽게 변화 */
		}
		
		.menu:hover, .submenu li:hover {
		    font-size: 1.1em; /* 마우스를 올리면 폰트 크기가 10% 증가 */
		    font-weight: bold; /* 글씨 두께가 굵어짐 */
		    color: #ffd700; /* 텍스트 색상도 금색으로 변화 */
		}
 		.submenu.show {
		    display: block;
		    max-height: 200px;
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
            max-width: 250px;
            max-height: 250px;
        }
        
    </style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_top.jsp" />
	</header>
	<article>
		<div class="sidebar">
	        <h2 onclick="location.href='adminHome'">관리자 홈</h2>
	        <div class="menu">
	        	사용자 관리
	        </div>
	        <ul class="submenu">
	            <li onclick="location.href='./'">사용자 추가</li>
	            <li>사용자 목록</li>
	            <li>사용자 권한 관리</li>
	        </ul>
	        <div class="menu">
	        	프로젝트 관리
	        </div>
	        <ul class="submenu">
	            <li>프로젝트 추가</li>
	            <li>프로젝트 목록</li>
	            <li>프로젝트 상태 관리</li>
	        </ul>
	        <div class="menu">
	        	결제 방법 관리
	        </div>
	        <ul class="submenu">
	            <li>결제 수단 추가</li>
	            <li>결제 내역</li>
	        </ul>
	        <div class="menu">
	        	커뮤니티 관리
	        </div>
	        <ul class="submenu">
	            <li>게시물 관리</li>
	            <li>댓글 관리</li>
	        </ul>
	    </div>
	    <div class="content">
	        <div class="box">
	        	<b style="font-size: 20px;">총 프로젝트 현황</b><br>
	        	<canvas id="myPieChart1"></canvas><br>
	        	<input type="button" value="상세보기">
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">실시간 사용자 현황</b><br>
				<canvas id="myPieChart2"></canvas><br>
	        	<input type="button" value="상세보기">	        	
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">총 펀딩금액</b><br>
	        	<canvas id="myPieChart3"></canvas><br>
	        	<input type="button" value="상세보기">
	        </div>
	        <div class="box">
	        	<b style="font-size: 20px;">사용자 수</b><br>
	        	<canvas id="myPieChart4"></canvas><br>
	        	<input type="button" value="상세보기">
	        </div>
	    </div>
	</article>
	
	<script>
        // 모든 메뉴 항목에 클릭 이벤트 추가
        document.querySelectorAll('.menu').forEach(menu => {
		    menu.addEventListener('click', () => {
		        // 이전에 열려있던 서브메뉴 닫기
		        document.querySelectorAll('.submenu').forEach(submenu => {
		            if (submenu !== menu.nextElementSibling) {
		                submenu.classList.remove('show');
		                submenu.style.maxHeight = '0'; // 최대 높이도 리셋
		                submenu.previousElementSibling.classList.remove('active'); // 화살표 회전 초기화
		            }
		        });
		
		        const submenu = menu.nextElementSibling; // 클릭한 메뉴의 다음 요소
		        if (submenu.classList.contains('show')) {
		            submenu.classList.remove('show'); // 이미 보이면 숨김
		            submenu.style.maxHeight = '0'; // 최대 높이 리셋
		            menu.classList.remove('active'); // 화살표 회전 초기화
		        } else {
		            submenu.classList.add('show'); // 보이지 않으면 보임
		            submenu.style.maxHeight = '200px'; // 최대 높이 설정
		            menu.classList.add('active'); // 화살표 회전
		        }
		    });
		});

    </script>
    
    <script>
        const data = [
            { labels: ['완료', '진행 중', '대기 중'], data: [30, 50, 20] },
            { labels: ['활성 사용자', '비활성 사용자'], data: [70, 30] },
            { labels: ['목표 금액', '달성 금액'], data: [100, 60] },
            { labels: ['신규 사용자', '기존 사용자'], data: [40, 60] }
        ];

        const canvasIds = ['myPieChart1', 'myPieChart2', 'myPieChart3', 'myPieChart4'];

        canvasIds.forEach((canvasId, index) => {
            const ctx = document.getElementById(canvasId).getContext('2d');
            new Chart(ctx, {
                type: 'pie', // 원형 그래프
                data: {
                    labels: data[index].labels, // 레이블
                    datasets: [{
                        label: '상태',
                        data: data[index].data, // 데이터 값
                        backgroundColor: [
                            'rgba(75, 192, 192, 0.6)',
                            'rgba(255, 206, 86, 0.6)',
                            'rgba(153, 102, 255, 0.6)',
                            'rgba(255, 99, 132, 0.6)'
                        ],
                        borderColor: [
                            'rgba(75, 192, 192, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 99, 132, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                }
            });
        });
    </script>
	
</body>
</html>
