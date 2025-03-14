$(function(){
//	찜버튼 클릭시 
	$("#btn-like").click(function(){
		alert("like");
	});
	
	//리워드 미선택 - 펀딩하기 클릭 시
	$(".purchase-btn").on("click", function(){
		let project_code = $("#project_code").val();
		location.href="PaymentReward?project_code=" + project_code;
	});
	
	//리워드 선택 후 펀딩하기 클릭 시

$(document).ready(function(){
    console.log("jQuery 로드됨!"); 

    $("#btn-support").click(function(){
        console.log("btn-support 버튼 클릭됨!"); 
        $(".support_modal").css("display", "block");
    });

    $(".x").click(function(){
        console.log("모달 닫기 버튼 클릭됨!");
        $(".support_modal").css("display", "none");
    });
});
	
	$(".like").click(function(){
		$(".like-check").click();
	});
	$(".life").click(function(){
		$(".life-check").click();
	});
	$(".useful").click(function(){
		$(".useful-check").click();
	});
	$(".littleMoney").click(function(){
		$(".littleMoney-check").click();
	});
	$(".cheerup").click(function(){
		$(".cheerup-check").click();
	});

	//제출버튼
	$(".support-submit").click(function(event){
		let support_keyword = "";
		
		$(".selected").each(function() {
			support_keyword += $(this).val() + " ";
		});
		
		console.log(support_keyword);
		
		$("btn-support-list input[type='hidden']").val(support_keyword);
		
		let email = $("#sessionUserEmail").val();
		console.log(email);
		let supportContent = $("textarea").val().trim();
		if(supportContent == ""){
			alert("응원글을 작성해 주세요.");
			 event.preventDefault();
			return;
		}
	});
	
});

//웹 페이지가 완전 로드되기전에 실행되는 코드 
// html이 다 로드 된 후 js가 실행되기에 안전함 
 document.addEventListener("DOMContentLoaded", function () { 
			// btn-support-list의 버튼들 모두를 변수 buttons에 저장
            const buttons = document.querySelectorAll(".btn-support-list button");
			//buttons에 대한 반복문 
            buttons.forEach(button => {
				//만약 버튼하나라도 이벤트가 발생하면 ( 클릭이벤트, 함수실행)
                button.addEventListener("click", function () {
                    // .selected 버튼을 찾아 selectedButtons 변수에 저장
                    const selectedButtons = document.querySelectorAll(".btn-support-list button.selected");
					//만약 selected가 포함되있다면 
                    if (this.classList.contains("selected")) {
                        // 이미 선택된 경우 -> 선택 해제
                        this.classList.remove("selected");
                    }else{
                        if (selectedButtons.length < 3) {
                            // 3개 미만이면 선택 추가
                            this.classList.add("selected");
                        }else{
							//선택된 버튼이 3개미만이 아니면 
							 alert("키워드는 3개까지 선택할 수 있어요");
						}
                    }
                }); 
            });
        });