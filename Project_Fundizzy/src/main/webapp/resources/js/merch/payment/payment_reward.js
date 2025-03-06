$(function(){
	
	let totalInput = 1;
	let totalInputValue;
	let totalPrice; 
	// + 버튼 클릭 시 개수 증가
	$(".plus_btn").on("click", function() {
		
		console.log("plus버튼 클릭됨");
		totalInput = $(".totalCount");
	  	let currentCount = parseInt(totalInput.val());
		
		// 8개 이상 선택 불가
		if(currentCount >= 8) {
			alert("최대 주문 수량입니다.");
			return;
		}
		
		totalInput.val(currentCount + 1);
		totalAmount();
	});
	
	// - 버튼 클릭 시 개수 감소
    $(".minus_btn").on("click", function() {
        let totalInput = $(".totalCount");
        let currentCount = parseInt(totalInput.val());
        
        console.log(currentCount);

        if (currentCount = 1) {
            $(this).prop("disabled", true);
        	return 

        // currentCount가 1보다 크면 -버튼 활성화
        } else {
            $(this).prop("disabled", false);
		}
       		totalInput.val(currentCount - 1);
        
		totalAmount();
    });


	//최종 금액 
	function totalAmount(){
		totalInputValue = parseInt($(".totalCount").val());
		totalPrice = parseInt(totalInputValue * 50000);
		console.log(totalInputValue);
		console.log("totalPrice" + totalPrice);
	}
	
});

