$(function() {
	// 등록시간 형식변환(n분 전, n시간 전)
	$(".notificationDate").each(function() {
		let dateValue = $(this).text();
		$(this).text(elapsedTime(dateValue));
	});
});

// 현재날짜와 비교하여 날짜 형식 변환하는 함수
function elapsedTime(date) {
	const start = new Date(date);
	const end = new Date();
	const diff = (end - start) / 1000;
	// 7일(604800초) 이상이면 날짜 그대로 반환
	if (diff > 60 * 60 * 24 * 7) {
		return start.toISOString().split('T')[0]; // YYYY-MM-DD 형식 반환
	}
	
	const times = [ 
		{ name: '년', milliSeconds: 60 * 60 * 24 * 365 }, 
		{ name: '개월', milliSeconds: 60 * 60 * 24 * 30 }, 
		{ name: '일', milliSeconds: 60 * 60 * 24 }, 
		{ name: '시간', milliSeconds: 60 * 60 }, 
		{ name: '분', milliSeconds: 60 }, 
	]; 
		
	for (const value of times) {
		const betweenTime = Math.floor(diff / value.milliSeconds);
		
		if (betweenTime > 0) {
			return `${betweenTime}${value.name} 전`; 
		} 

	} 
	
	return '방금 전';
}


