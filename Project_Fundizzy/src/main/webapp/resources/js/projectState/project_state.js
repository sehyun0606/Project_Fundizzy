$(function() {
	let myCt = $("#myChart");

	let myChart = new Chart(myCt, {
		type: 'bar',
		data: {
			labels: ['2020', '2021', '2022', '2023'],
			datasets: [
				{
					label: '누적 펀딩 수',
					data: [10,20,30,40],
				}
			]
		},
		options: {
			responsive: false,
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			},
		}
	});
	
	
	
	
	
});

















