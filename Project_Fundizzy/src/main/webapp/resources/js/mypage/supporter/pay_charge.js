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
	
	
	
});