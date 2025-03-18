$(document).ready(function() {
	// +5만 버튼 클릭 시 50000원 자동 입력 
	$("#50000").on("click", function(){
		$("#fundizy-pay").val(50000);
	});
	
	// +10만 버튼 클릭 시 50000원 자동 입력 
	$("#100000").on("click", function(){
		$("#fundizy-pay").val(100000);
	});
	
	// +30만 버튼 클릭 시 50000원 자동 입력 
	$("#300000").on("click", function(){
		$("#fundizy-pay").val(300000);
	});
	
	//금액 미 입력시 화면 이동 안되도록
	let amount = $("#fundizy-pay").val();
	
	if($("#charge-submit").on("click", function(){
		
		if(amount == null || amount == ""){
			alert("충전할 금액을 입력해 주세요.");
			return false;
		}
	}));
	
	
});