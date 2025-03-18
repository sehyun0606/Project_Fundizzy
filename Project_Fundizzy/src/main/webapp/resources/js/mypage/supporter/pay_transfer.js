$(document).ready(function() {
	// +1만 버튼 클릭 시 100000원 자동 입력 
	$("#10000").on("click", function(){
		$("#fundizy-pay").val(10000);
	});
	
	// +5만 버튼 클릭 시 50000원 자동 입력 
	$("#50000").on("click", function(){
		$("#fundizy-pay").val(50000);
	});
	
	// +10만 버튼 클릭 시 100000원 자동 입력 
	$("#100000").on("click", function(){
		$("#fundizy-pay").val(100000);
	});
	
	if($("#transfer-submit").on("click", function(){
	
		let amount = $("#fundizy-pay").val();
		//금액 미 입력시 화면 이동 안되도록
		if(amount == null || amount == ""){
			alert("보낼 금액을 입력해 주세요.");
			return false;
		}
		//페이 잔액보다 큰 금액 시도시 안되도록
		let pay_money = $(".pay-money").text().replace(/[^0-9]/g, ""); // 숫자만 추출
			pay_money = parseInt(pay_money, 10); // 숫자로 변환
		if(amount > pay_money){
			alert("잔액보다 큰 금액은 보낼 수 없습니다. \n 다시 시도해주세요.");
			return false;
		}
	}));
	
});