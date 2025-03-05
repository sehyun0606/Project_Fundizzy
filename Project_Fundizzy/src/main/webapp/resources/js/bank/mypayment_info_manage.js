$(function(){
	//등록된 계좌가 없을경우

	
	//등록한 계좌 삭제 
	$("#account_delete").on("click", function(){
		console.log("휴지통 버튼 눌려졌음 ");
		if(confirm("등록된 계좌를 삭제하시겠습니까?")){
			$(this).closest(".account").hide();
		}
	});
	
	//계좌 연결
	$("#auth-button").on("click", function(){
		console.log("버튼 클릭됨");
		// 빈 새창을 열고 이름은 authwindow로 주고 width=500 height=700을 준다
		let authWindow = window.open("about:blank", "authWindow", "width=500,height=700");
		// authwindow의 주소값 전달 (// 요청주소에서 testapi로 수정해야함)
			authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
								+ "response_type=code"
								+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
								+ "&redirect_uri=http://localhost:8081/callback"
								+ "&scope=login inquiry transfer"
								+ "&state=12345678901234567890123456789012"
								+ "&auth_type=0";
	});
	
	$("#add_button").on("click", function(){
//		계좌 리스트 출력 및 등록 가능하도록 
		 $(".account_modal").css("display", "block");
	});
	
	$(".x").click(function(){
		$(".account_modal").css("display", "none");
	});
	
	
});
