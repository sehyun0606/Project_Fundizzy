$(function() {
    // + 버튼 클릭 시 개수 증가
    $(".plus_btn").on("click", function() {
        let $rewardItem = $(this).closest(".reward-item"); // 클릭한 버튼이 속한 상품만 선택
        let $totalInput = $rewardItem.find(".totalCount"); // 해당 상품의 개수 입력란
        let $totalPrice = $rewardItem.find(".totalPrice"); // 해당 상품의 총 금액 표시 영역
        let reward_price = parseInt($rewardItem.find(".sell_price").val()); // 해당 상품의 가격

        let currentCount = parseInt($totalInput.val());

        // 5개 이상 선택 불가
        if (currentCount >= 5) {
            alert("최대 주문 수량입니다.");
            return;
        }

        $totalInput.val(currentCount + 1);
        $rewardItem.find(".minus_btn").prop("disabled", false); // - 버튼 활성화

        updateTotalPrice($totalInput, $totalPrice, reward_price);
    });

    // - 버튼 클릭 시 개수 감소
    $(".minus_btn").on("click", function() {
        let $rewardItem = $(this).closest(".reward-item");
        let $totalInput = $rewardItem.find(".totalCount");
        let $totalPrice = $rewardItem.find(".totalPrice");
        let reward_price = parseInt($rewardItem.find(".sell_price").val());

        let currentCount = parseInt($totalInput.val());

        if (currentCount <= 1) {
            return; // 1개 이하로 줄일 수 없음
        }

        $totalInput.val(currentCount - 1);

        // 개수가 1이면 버튼 비활성화
        if (currentCount - 1 <= 1) {
            $(this).prop("disabled", true);
        }

        updateTotalPrice($totalInput, $totalPrice, reward_price);
    });

    // 페이지 로드 시 - 버튼 초기 상태 설정 (1이면 비활성화)
    $(".totalCount").each(function() {
        if ($(this).val() == "1") {
            $(this).closest(".reward-item").find(".minus_btn").prop("disabled", true);
        }
    });

    // 총 금액 업데이트 함수
    function updateTotalPrice($input, $totalPrice, pricePerItem) {
        let totalInputValue = parseInt($input.val());
        let totalPrice = totalInputValue * pricePerItem;

        let formattedPrice = totalPrice.toLocaleString('ko-KR');
        $totalPrice.html(`<div> 총금액 : ${formattedPrice}</div>`);
    }

	$("#next-button").on("click", function() {
		
	    let totalCount = 0;
	    let totalPrice = 0;
	
	
		
	    // 기존에 추가된 input 요소 삭제 (중복 방지)
	    $("#pay-form").find(".dynamic-input").remove();	
	
		$(".reward-item").each(function() {
		    if ($(this).find("input[type='checkbox']").is(":checked")) {
		        let rewardCode = $(this).find(".reward_code").val(); // 리워드 코드 가져오기
		        let pricePerItem = parseInt($(this).find(".sell_price").val()); // 1개당 가격
		        let itemCount = parseInt($(this).find(".totalCount").val()); // 선택된 수량
		
		        // 전체 수량 & 가격 계산
		        totalCount += itemCount;
		        totalPrice += itemCount * pricePerItem;
		
		        // 체크된 상품만 pay-form 안에 추가
		        let hiddenInputs = `
		            <input type="hidden" class="dynamic-input" name="reward_code[]" value="${rewardCode}">
		            <input type="hidden" class="dynamic-input" name="item_count_${rewardCode}" value="${itemCount}">
		            <input type="hidden" class="dynamic-input" name="item_price_${rewardCode}" value="${pricePerItem}">
		        `;
		        $("#pay-form").append(hiddenInputs);
		    }
		});
	
		
		// 최종 수량 & 금액 업데이트
		$("#total_count").val(Count);
		$("#total_price").val(totalPrice);
		
		// 최소 한개 이상의 리워드 선택 여부 체크
		if (totalCount == 0) {
		    alert("최소 한개 이상의 리워드를 선택해 주세요.");
		    location.reload();
			return;
		}
		
		// 금액 표시 (천 단위 콤마)
		let formattedPrice = totalPrice.toLocaleString('ko-KR');
		$("#total_price_display").text(`총 금액: ${formattedPrice}`);
		
	
		// 폼 제출
		$("#pay-form").submit();
	});
});

