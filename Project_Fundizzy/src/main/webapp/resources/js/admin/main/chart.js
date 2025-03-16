document.addEventListener("DOMContentLoaded", function () {
		    // JSP에서 전달된 JSON 데이터를 가져오기
		    const chartDataElement = document.getElementById("chartData");
		    if (!chartDataElement) {
		        console.error("chartData 요소를 찾을 수 없음.");
		        return;
		    }
	
		    // JSON 문자열을 파싱하여 JavaScript 객체로 변환
		    const chartData = JSON.parse(chartDataElement.textContent.trim());
	
		    // 차트를 그릴 canvas ID 배열
		    const canvasIds = ['myPieChart1', 'myPieChart2', 'myPieChart3', 'myPieChart4'];
	
		    // 각각의 캔버스 요소에 차트를 적용
		    canvasIds.forEach((canvasId, index) => {
		        const ctx = document.getElementById(canvasId).getContext('2d');
	
		        if (!chartData[index]) {
		            console.warn(`chartData[${index}]가 없음`);
		            return;
		        }
	
		        new Chart(ctx, {
		            type: 'bar',
		            data: {
		                labels: chartData[index].labels,
		                datasets: [{
		                    label: '상태',
		                    data: chartData[index].data,
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
		                plugins: {
		                    legend: {
		                        position: 'top'
		                    }
		                }
		            }
		        });
		    });
		});