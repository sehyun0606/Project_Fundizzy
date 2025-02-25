<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="stylesheet" type="text/css" href="resources/css/projectState/project_state.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>프로젝트 현황</h1>
			<h3>프로젝트 현황</h3>
			<div class="state-container">
				<div class="state">
					<div class="subtitle">펀딩 금액</div>
					<div class="item-container">
						<span class="item">1,000,000</span>
						<span class="unit">원</span>
					</div>
				</div>
				<div class="state">
					<div class="subtitle">펀딩 달성률</div>
					<div class="item-container">
						<span class="item">71</span>
						<span class="unit">%</span>
					</div>
				</div>
				<div class="state">
					<div class="subtitle">펀딩 건수</div>
					<div class="item-container">
						<span class="item">71</span>
						<span class="unit">건</span>
					</div>
				</div>
				<div class="state">
					<div class="subtitle">남은 기간</div>
					<div class="item-container">
						<span class="item">0</span>
						<span class="unit">일</span>
					</div>
				</div>
			</div>
			<h3>펀딩 현황 분석</h3>
			<div>
				<canvas id="myChart" width="300" height="100"></canvas>
			</div>
		</div>
	</div>
</body>
<script>
let myCt = document.getElementById('myChart');

let myChart = new Chart(myCt, {
  type: 'bar',
  data: {
    labels: ['2020', '2021', '2022', '2023'],
    datasets: [
      {
        label: 'Dataset',
        data: [10,20,30,40],
      }
    ]
  },
});
</script>
</html>
















