$(function() {
    // + 버튼 클릭 시 개수 증가
    $(".plus_btn").on("click", function() {
		let count = parseInt($(this).siblings(".count").val()) + 1;
		
		// count 이벤트 헨들링을 위해 change 이벤트 발생
		$(this).siblings(".count").val(count).change();
		
		// 금액계산
		let totalPrice = parseInt($("#total_price").val());
		let price = parseInt($(this).siblings(".rewordPrice").val());
		
		$("#total_price").val(totalPrice + price);
		$(".totalPriceSapn").empty();
		$(".totalPriceSapn").append("<fmt:formatNumber pattern='#,###'>" + (totalPrice + price) + "</fmt:formatNumber>");
		
		// 총금액 표시
		$(this).closest(".reward-item").find(".rewardSumPriceSapn").empty();
		
		// 리워드당 누적금액 표시
		$(this).closest(".reward-item").find(".rewardSumPriceSapn").append("<fmt:formatNumber pattern='#,###'>" + (count * price) + "</fmt:formatNumber>");
		
    });

    // - 버튼 클릭 시 개수 감소
    $(".minus_btn").on("click", function() {
		let count = parseInt($(this).siblings(".count").val()) - 1;
		$(this).siblings(".count").val(count).change();
		
		// 금액계산
		let totalPrice = parseInt($("#total_price").val());
		let price = parseInt($(this).siblings(".rewordPrice").val());
		
		$("#total_price").val(totalPrice - price);
		$(".totalPriceSapn").empty();
		$(".totalPriceSapn").append("<fmt:formatNumber pattern='#,###'>" + (totalPrice - price) + "</fmt:formatNumber>");
		
		// 총금액 표시
		$(this).closest(".reward-item").find(".rewardSumPriceSapn").empty();
		
		// 리워드당 누적금액 표시
		$(this).closest(".reward-item").find(".rewardSumPriceSapn").append("<fmt:formatNumber pattern='#,###'>" + (count * price) + "</fmt:formatNumber>");
		
    });
	
	// 카운트 변경시 작업
	$(".count").change(function() {
		let count = $(this).val();
		
		// 카운트가 0이면 -버튼 비활성화, 아니면 +버튼 활성화
		if(count == 0) {
			$(this).siblings(".minus_btn").prop("disabled", true);
		} else {
			$(this).siblings(".minus_btn").prop("disabled", false);
		}
		
		let price = $(this).siblings(".rewordPrice").val();
	});

	$("#next-button").on("click", function() {
		// 총결제금액이 0이면 리워드 선택 알람 출력
		if ($("#total_price").val() == 0) {
		    alert("최소 한개 이상의 리워드를 선택해 주세요.");
			return;
		}
		
		// 폼 제출
		$("#pay-form").submit();
	});
});

