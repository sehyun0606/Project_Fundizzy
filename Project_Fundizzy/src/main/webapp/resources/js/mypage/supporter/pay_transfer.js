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
	
	
	
});