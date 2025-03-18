$(function() {
	// 메인 알림 옵션 ON/OFF시 판별 후 다른 옵션 활성화/비활성
	controlButton();
	
	// 알림설정 체크박스 선택시 해당 정보 디비에 저장
	$(".setCheck").click(function() {
		let option = $(this).attr("id");
		let optionValue = $(this).prop("checked") ? "Y" : "N";
		
		$.ajax({
			type : "POST",
			url : "ChangeNOTSetInfo",
			data : {
				option,
				optionValue
			}
		}).done(function(result) {
			// 옵션 변경에 실패하였을때에만 알림창 출력
			if(result == "false") {
				alert("옵션 변경에 실패하였습니다");
			}
		}).fail(function() {
			alert("옵션 변경에 실패하였습니다");
		});
		
	});
	
	// 메인 알림 옵션 ON/OFF시 시 판별 후 다른 옵션 활성화/비활성화
	$("#is_recv_notification").click(function() {
		controlButton();
	});
});

function controlButton() {
	if(!$("#is_recv_notification").prop("checked")) {
		$(".setCheck").not("#is_recv_notification").prop("checked", false);
		$(".setCheck").not("#is_recv_notification").prop("disabled", true);
	} else {
		$(".setCheck").not("#is_recv_notification").prop("disabled", false);
		// 저장되어있는 옵션값 조회
		$.ajax({
			type : "GET",
			url : "SearchNOTOptionInfo"
		}).done(function(optionInfo) {
			// 옵션값 중 "Y" 되어있는 옵션 활성화 
			for(let key in optionInfo) {
				if(optionInfo[key] == "Y") {
					$("#" + key).prop("checked", true);
				}
			}
		}).fail(function() {
			alert("옵션 정보 조회 실패하였습니다.")
		});
	}
}

