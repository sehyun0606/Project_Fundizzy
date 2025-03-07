$(function(){
	
	let totalInput = 1;
	let currentCount;
	let totalInputValue;
	let totalPrice; 
	
	
	// + 버튼 클릭 시 개수 증가
	$(".plus_btn").on("click", function() {
		
		console.log("plus버튼 클릭됨");
		totalInput = $(".totalCount");
		productCount = $("#product_count");
	
	  	currentCount = parseInt(totalInput.val());
		
		// 5개 이상 선택 불가
		if(currentCount >= 5) {
			alert("최대 주문 수량입니다.");
			return;
		}
		
		totalInput.val(currentCount + 1);
		productCount.val(currentCount + 1)
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
		productCount.val(currentCount - 1)
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


	//최종 금액 
	function totalAmount(){
		totalInputValue = parseInt($(".totalCount").val());
		totalPrice = parseInt(totalInputValue * 51000);
		console.log(totalInputValue);
		console.log("totalPrice = " + totalPrice);
		
//		$(".totalPrice").append(`
//			<div> 총금액 : </div>
//			<div>` + totalPrice + `</div>
//		`);
		$(".totalPrice").html(`
			<div> 총금액 : ${totalPrice}</div>
		`);
		$("#total_price").val(totalPrice);
	}
	
	
	//버튼 클릭 시 폼 제출
	$("#next-button").on("click", function() {
		$("#pay-form").submit();
	})
});

