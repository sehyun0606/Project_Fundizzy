$(document).ready(function () {
    $(".add-button").click(function () {
    	let count = $(".reward-card").length;
    	if(count == 5){
    		alert("리워드는 최대 5개 까지만 설정 가능합니다");
    	}else{
       		$("#modal").fadeIn();
       	}
    });

    $(".close").click(function () {
        $("#modal").fadeOut();
    });

    $(window).click(function (event) {
        if ($(event.target).is("#modal")) {
            $("#modal").fadeOut();
        }
    });
    
    $(".edit-button").click(function(){
	     $("#modal2").fadeIn();
	      let reward_code = $(this).parent().children().filter(".reward_code").val();
		  $.ajax({
		  			url : "GetRewardInfo",
					type : "GET",
					data : {
						reward_code
					},
					dataType: "json",  
        			contentType: "application/json; charset=UTF-8"
				}).done(function(result){
					console.log("응답 받은 데이터: ", result);
					
					$(".amount2").val(result.price);
					$(".rewardName2").val(result.product_name);
					$(".rewardDesc2").val(result.product_desc);
					$(".limit2").val(result.product_limit);
					$(".deliveryFee2").val(result.delivery_fee);
					$(".reward_code2").val(result.reward_code);
				}).fail(function(){
					console.log("실패..")
				})
    
	    });
	
    $(".close").click(function () {
        $("#modal2").fadeOut();
    });

    $(window).click(function (event) {
        if ($(event.target).is("#modal2")) {
            $("#modal2").fadeOut();
   		}
    });
    
    $(".delete-button").click(function() {
    	let reward_code = $(this).parent().children().filter(".reward_code").val();
    	 $.ajax({
  			url : "DeleteReward",
			type : "GET",
			data : {
				reward_code
			}
		}).done(function(result){
			console.log(result);
			location.reload();
		}).fail(function(){
			console.log("실패..")
		})
    });
    
        
});