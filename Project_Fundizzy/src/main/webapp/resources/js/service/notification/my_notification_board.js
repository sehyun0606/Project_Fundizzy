$(function() {
	// 알림페이지 로딩시 알림 상태 읽음으로 표시
	$.ajax({
		type : "POST",
		url : "UpdateNotStatus"
	});
	
	// 등록시간 형식변환(n분 전, n시간 전)
	$(".notificationDate").each(function() {
		let dateValue = $(this).text();
		$(this).text(elapsedTime(dateValue));
	});
	
	// 전체선택클릭시 숨겨진 체크박스의 상태에 맞춰서 전체선택 or 전체해제
	$("#allCheckBtn").click(function() {
		// 기준이될 숨겨진 체크박스
		$("#allCheck").click();
		$(".notCheck").prop("checked", $("#allCheck").prop("checked"));
	});
	
	// 알림 삭제버튼 클릭시 체크박스 선택된 알림 디비에서 제거
	$("#deleteBtn").click(function() {
		if(!confirm("선택한 알림을 삭제하시겠습니까?")) {
			return;
		}
		
		// 삭제할 알림의 코드를 저장할 배열
		let codeArr = [];
		
		// 배열에 선택된 알림의 코드 저장
		$(".notCheck:checked").each(function() {
			codeArr.push($(this).val());
		});
		
		$.ajax({
			type : "POST",
			url : "RemoveNotification",
			data : {
				jsonCodeArr : JSON.stringify(codeArr)	
			}
		}).done(function(result) {
			if(result) {
				alert("선택한 알림이 삭제되었습니다.");
				location.reload(true);
			}
		});
	});
	
	// 지지서명 알림 키워드 아이콘 표시
	$(".notificationContent input[type=hidden]").each(function() {
        // 1이 포함된 경우
        if ($(this).val().includes("1")) {
            $(this).siblings("span").append('👍');
        }
        
        // 2가 포함된 경우
        if ($(this).val().includes("2")) {
            $(this).siblings("span").append('🔥');
        }
        
        // 3이 포함된 경우
        if ($(this).val().includes("3")) {
            $(this).siblings("span").append('🛠️');
        }

        // 4가 포함된 경우
        if ($(this).val().includes("4")) {
            $(this).siblings("span").append('💰');
        }

        // 5가 포함된 경우
        if ($(this).val().includes("5")) {
            $(this).siblings("span").append('📣');
        }
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


