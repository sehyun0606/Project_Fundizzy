//오른쪽 
$(function(){
		let project_code = $("#project_code").val();
	
	//상단 메뉴바 선택 시 
	$(".story").on("click", function(e){
		location.href="FundBoardStory?project_code=" + project_code;
	});
	
	$(".new").on("click", function(e){
		location.href="FundBoardNew?project_code=" + project_code;
	});
	
	$(".support").on("click", function(e){
		location.href="FundBoardSupport?project_code=" + project_code;
	});
	
	$(".supporter").on("click", function(e){
		location.href="FundBoardSupporter?project_code=" + project_code;
	});
	
	$(".refund").on("click", function(e){
		location.href="FundBoardRefund?project_code=" + project_code;
	});
	
	$(".reward").on("click", function(e){
		location.href="FundBoardReward?project_code=" + project_code;
	});
	
//	찜버튼 클릭시 
	$("#btn-like").click(function(){
		//클릭이 되었을때 이미 찜한 상태라면 찜 취소
		if($(this).hasClass("clicked")){
			$(this).removeClass("clicked")
	      	let iElement = $(this).find('i');
			iElement.removeClass("fa-heart");
			iElement.addClass("fa-heart-o");
			//테이블에 이름 , 프젝 코드 빼기  
			$.ajax({
				type: "POST",
				url: "FundBoardStoryKeepDelete",
				data: {
					email: email,
					project_code: keep_project_code
				}
			}).done(function(result){
			}).fail(function(){
		        alert("@찜 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
				location.reload();
			})
			//찜이 처음이라면 찜 되도록 
	    } else {
		
			$(this).addClass("clicked")
	      	let iElement = $(this).find('i');
			iElement.removeClass("fa-heart-o");
			iElement.addClass("fa-heart");
			
			//테이블에 이름 , 프젝 코드 넣기 
			$.ajax({
				type: "POST",
				url: "FundBoardStoryKeep",
				data: {
					email: email,
					project_code: keep_project_code
				}
			}).done(function(result){
				alert("상품 찜 등록이 완료되었습니다.");
			}).fail(function(){
		        alert("!찜 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
				location.reload();
			})
	    }
		
	});

$(document).ready(function(){
// 지지서명 버튼 클릭시 모달창 띄우기 
    $("#btn-support").click(function(){
        console.log("btn-support 버튼 클릭됨!"); 
        $(".support_modal").css("display", "block");
    });
// x 누르면 모달창 닫히게 
    $(".x").click(function(){
        console.log("모달 닫기 버튼 클릭됨!");
        $(".support_modal").css("display", "none");
    });
});
	// 키워드 5가지 클릭 시 체크됐다고 표시 
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
		//키워드 초기화 
		let support_keyword = "";
		//선택된 키워드만 넘어가도록 
		$(".selected").each(function() {
			support_keyword += $(this).val() + " ";
		});
			
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
	//펀딩하기 버튼 클릭 시
	$(".purchase-btn").on("click", function(){
		location.href="PaymentReward?project_code=" + project_code;
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