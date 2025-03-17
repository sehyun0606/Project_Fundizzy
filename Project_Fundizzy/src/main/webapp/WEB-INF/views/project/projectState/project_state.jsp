<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 현황</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="stylesheet" type="text/css" href="resources/css/projectState/project_state.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="resources/js/projectState/project_state.js"></script>
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
						<span class="item"><fmt:formatNumber value="${totalPaymentAmount}" pattern="#,###" /></span>
						<span class="unit">원</span>
					</div>
				</div>
				<div class="state">
					<div class="subtitle">펀딩 달성률</div>
					<div class="item-container">
						<span class="item">${progress}</span>
						<span class="unit">%</span>
					</div>
				</div>
				<div class="state">
					<div class="subtitle">펀딩 건수</div>
					<div class="item-container">
						<span class="item">${orderCount}</span>
						<span class="unit">건</span>
					</div>
				</div>
				<div class="state">
					<div class="subtitle">지지서명 참여자수</div>
					<div class="item-container">
						<span class="item">66</span>
						<span class="unit">명</span>
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
			<div class="selectDate">
				<input type="date"> <input type="date">
			</div>
			<div>
				<canvas id="myChart" width="1200px" height="500px"></canvas>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
</body>
<script>
	$(function() {
		// 현황 차트
		let dateArr = new Array();
		let paymentCountArr = new Array();		// 누적 결제 건수
		let dailyPaymentArr = new Array();		// 일일 결제 금액
		let cumulativePaymentArr = new Array();	// 누적 결제 금액

		<c:forEach var="paymentCount" items="${paymentCountList}">
		    dateArr.push("${paymentCount.date}");
		    paymentCountArr.push("${paymentCount.cumulative_payments}");
		</c:forEach>

		<c:forEach var="dailyPayment" items="${dailyPaymentList}">
		    dailyPaymentArr.push("${dailyPayment.cumulative_payments}");
		</c:forEach>

		<c:forEach var="cumulativePayment" items="${cumulativePaymentList}">
		    cumulativePaymentArr.push("${cumulativePayment.cumulative_payments}");
		</c:forEach>

		let myCt = $("#myChart");

		let myChart = new Chart(myCt, {
		    type: 'bar',
		    data: {
		        labels: dateArr,
		        datasets: [
		            {
		                label: '누적 결제 건수',
		                data: paymentCountArr,
		                type: 'line',
		                borderColor: 'rgba(75, 192, 192, 1)',
		                backgroundColor: 'rgba(75, 192, 192, 0.2)',
// 		                backgroundColor: 'rgba(54, 162, 235, 0.5)',
// 		                borderWidth: 1,
		                yAxisID: 'y'
		            },
		            {
		                label: '일일 결제 금액',
		                data: dailyPaymentArr,
		                backgroundColor: 'rgba(54, 162, 235, 0.5)',
		                borderWidth: 1,
// 		                type: 'line',
// 		                borderColor: 'rgba(75, 192, 192, 1)',
// 		                backgroundColor: 'rgba(75, 192, 192, 0.2)',
		                fill: false,
		                yAxisID: 'y1'
		            },
		            {
		                label: '누적 결제 금액',
		                data: cumulativePaymentArr,
		                backgroundColor: 'rgba(255, 99, 132, 1)',
		                borderWidth: 1,
// 		                type: 'line',
// 		                borderColor: 'rgba(255, 99, 132, 1)',
// 		                backgroundColor: 'rgba(255, 99, 132, 0.2)',
		                fill: false,
		                yAxisID: 'y1'
		            }
		        ]
		    },
		    options: {
		        responsive: false,
		        scales: {
		            y: {
		                beginAtZero: true,
		                position: 'right',
		                title: {
		                    display: true,
		                    text: '누적 결제 건수'
		                },
		                ticks: {
		                    stepSize: 5,
		                    max: 1000
		                }
		            },
		            y1: {
		                beginAtZero: true,
		                position: 'left',
		                title: {
		                    display: true,
		                    text: '결제 금액'
		                },
		                grid: {
		                    drawOnChartArea: false
		                },
		                ticks: {
		                    stepSize: 100000
		                }
		            }
		        }
		    }
		});


		
		
		
	});

</script>
</html>
















