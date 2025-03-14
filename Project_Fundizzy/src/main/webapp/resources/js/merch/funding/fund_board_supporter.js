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
	
	$(".reply-show").on("click", function(){
	 let replyWrite = document.querySelector(".reply-write");
            if (replyWrite.style.display === "none" || replyWrite.style.display === "") {
                replyWrite.style.display = "block"; 
            } else {
                replyWrite.style.display = "none"; 
            }
	 let replyList = document.querySelector(".reply-list");
            if (replyList.style.display === "none" || replyList.style.display === "") {
                replyList.style.display = "block"; 
            } else {
                replyList.style.display = "none"; 
            }
	});
	
});

//오른쪽 
$(function(){
//	찜버튼 클릭시 
	$("#btn-like").click(function(){
		console.log("like")
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