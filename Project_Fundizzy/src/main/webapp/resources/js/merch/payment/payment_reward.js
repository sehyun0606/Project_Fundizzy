$(function() {
    let totalInput = 1; // 기본 수량 
    let currentCount; // 현재 설정한 수량 
    let totalInputValue; // 최종 수량
    let totalPrice; // 최종 가격
    let reward_price; // 1개당 가격

    // + 버튼 클릭 시 개수 증가
    $(".plus_btn").on("click", function() {
        console.log("plus버튼 클릭됨");
        totalInput = $(".totalCount");
        productCount = $("#product_count");

        currentCount = parseInt(totalInput.val());

        // 5개 이상 선택 불가
        if (currentCount >= 5) {
            alert("최대 주문 수량입니다.");
            return;
        }

        totalInput.val(currentCount + 1);
        productCount.val(currentCount + 1);
        $(".minus_btn").prop("disabled", false);
        totalAmount();
    });

    // - 버튼 클릭 시 개수 감소
    $(".minus_btn").on("click", function() {
        totalInput = $(".totalCount");
        productCount = $("#product_count");
        currentCount = parseInt(totalInput.val());

        console.log(currentCount);

        totalInput.val(currentCount - 1);
        productCount.val(currentCount - 1);
        // 개수가 1이면 버튼 비활성화
        if (currentCount - 1 <= 1) {
            $(this).prop("disabled", true);
        }

        totalAmount();
    });

    // 페이지 로드 시 - 버튼 초기 상태 설정 (1이면 비활성화)
    if ($(".totalCount").val() == "1") {
        $(".minus_btn").prop("disabled", true);
    }

    // 1개당 가격
    reward_price = $("#sell_price").val();
    console.log("1개 가격 = " + reward_price);

    // 최종 금액 
    function totalAmount() {
        totalInputValue = parseInt($(".totalCount").val());
        totalPrice = parseInt(totalInputValue * reward_price);

        console.log(totalInputValue);
        console.log("totalPrice = " + totalPrice);

        let formattedPrice = totalPrice.toLocaleString('ko-KR');

        $(".totalPrice").html(`
            <div> 총금액 : ${formattedPrice}</div>
        `);

        $("#total_price").val(formattedPrice);
  	    $("#total_count").val(totalInputValue);
    }

	   $("#next-button").on("click", function() {
		
	    // 수량과 가격을 계산
	    let totalInputValue = parseInt($(".totalCount").val());
	    let totalPrice = parseInt(totalInputValue * reward_price);
	
	    // input에 값 설정 (jsp hidden 아이디에 값 넣었음)
	    $("#total_count").val(totalInputValue);
	    $("#total_price").val(totalPrice);
	
	    console.log("폼 제출 전 최종 가격:", $("#total_price").val());
	    console.log("폼 제출 전 최종 수량:", $("#total_count").val());
	
	    // 폼 제출
	    $("#pay-form").submit();
	});

});

