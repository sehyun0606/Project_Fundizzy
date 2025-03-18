$(function(){
	let email = $("#keep_email").val();
	let keep_project_code = $("#keep_project_code").val();
	let project_code = $("#project_code").val();
	
	//상단 메뉴바 선택 시 
	$(".story").on("click", function(e){
		location.href="OpenBoardStory?project_code=" + project_code;
	});
	
	$(".new").on("click", function(e){
		location.href="OpenBoardNew?project_code=" + project_code;
	});
	
	$(".support").on("click", function(e){
		location.href="OpenBoardSupport?project_code=" + project_code;
	});
	
//	찜버튼 클릭시 
	$(document).on("click", "#btn-like", function() {
		let keepCount = $(".count").val();
		console.log(keepCount);
		
		if ($(".count").length === 0) {
    	console.log("Error: .count 요소를 찾을 수 없습니다.");
	}

		
		if($("#sId").val() == null || $("#sId").val() == ""){
			alert("로그인 후 이용 가능합니다.");
			return;
		}
		//클릭이 되었을때 이미 찜한 상태라면 찜 취소
		if($(this).hasClass("clicked")){
			
	      	let iElement = $(this).find('i');
			iElement.removeClass("fa-heart");
			iElement.addClass("fa-heart-o");
			
//			keepCount = $(this).closest(".count").val();
			console.log(keepCount);
			//테이블에 이름 , 프젝 코드 빼기  
			$.ajax({
				type: "POST",
				url: "FundBoardStoryKeepDelete",
				data: {
					email: email,
					project_code: keep_project_code
				}
			}).done(function(result){
				$(this).removeClass("clicked")
		        if(confirm("신청을 취소하면 알림을 받으실 수 없습니다 \n정말 취소하시겠습니까?")) {
					location.reload();
				}
			}).fail(function(){
		        alert("알림 취소 중 오류가 발생했습니다. 다시 시도해주세요.");
				location.reload();
			})
	    } else {
			//찜이 처음이라면 찜 되도록 
			$(this).addClass("clicked")
	      	let iElement = $(this).find('i');
			iElement.removeClass("fa-heart-o");
			iElement.addClass("fa-heart");
			
			keepCount = $(".count").val();
			console.log(keepCount);
			
			//테이블에 이름 , 프젝 코드 넣기 
			$.ajax({
				type: "POST",
				url: "FundBoardStoryKeep",
				data: {
					email: email,
					project_code: keep_project_code
				}
			}).done(function(result){
//				alert("알림 신청이 완료되었습니다.");
				location.reload();
			}).fail(function(error){
		        alert(error + "알림 신청 중 오류가 발생했습니다. 다시 시도해주세요.");
				location.reload();
			})
	    }
		
	});
	
//리워드 선택 후 펀딩하기 클릭 시
$(document).ready(function(){
	
    $("#btn-support").click(function(){
		if($("#sId").val() == null || $("#sId").val() == ""){
			alert("로그인 후 이용 가능합니다.");
			return;
		}
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