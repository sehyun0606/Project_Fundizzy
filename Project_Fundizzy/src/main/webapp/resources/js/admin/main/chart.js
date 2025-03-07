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
