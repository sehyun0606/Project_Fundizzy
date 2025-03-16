$(document).ready(function() {
	
	let project_code;
	
    // 모달 열기
    // 상세보기 버튼 클릭 시 모달창 생성 
	$(".set-info").click(function() {
		 $(".modal").fadeIn(200);
		 $(".modal-content").fadeIn(200);
		
		project_code = $(this).closest("tr").find(".project_code").text();
        console.log(project_code)
		
		
		$.ajax({
			type : "GET",
			url : "AdminSettlementInfo",
			data : {
				project_code
			}
		}).done(function(data) {
			
			$(".project_code").val(project_code);
			$(".email").val(data.representative_email);
			$(".detailTable td").eq(0).text(data.project_title);
			$(".detailTable td").eq(1).text(data.representative_name);
			$(".detailTable td").eq(2).text(data.representative_email);
			if(data.settlement_status == 'SET03') {
				$(".detailTable td").eq(3).text("선정산");
			} else if(data.settlement_status == 'SET06') {
				$(".detailTable td").eq(3).text("최종정산");
			}
			
			if(data.settlement_status == 'SET03') {
				$(".set-info").eq(4).css("display", "none");
				
				$("#titleStatus").text("선정산 지급액");
				$("#set_amount").text(data.pre_amount + "원");
				$("#total_amount").text(data.total_amount + "원");
				$("#fee").text(data.fee + "원");
				if(parseInt(data.total_amount.replace(/,/g, "")) >= 1000000) {
					if(data.service_type == 'pro') {
						$(".set-info .msg").text("펀디지 수수료(10%) + 기본이용료 9만원");
					} else {
						$(".set-info .msg").text("펀디지 수수료(5%) + 기본이용료 9만원");
					}
				} else {
					if(data.service_type == 'pro') {
						$(".set-info .msg").text("펀디지 수수료(10%)");
					} else {
						$(".set-info .msg").text("펀디지 수수료(5%)");
					}
				}
				
				$(".pre_amount").val(data.pre_amount);
				$(".pay_type").val("PR");
			} else if(data.settlement_status == 'SET06') {
				$(".set-info").eq(3).css("display", "none");

				$("#titleStatus").text("최종정산 지급액");
				$("#set_amount").text(data.final_amount + "원");
				$("#total_amount").text(data.total_amount + "원");
				$("#refund_amount").text(data.refund_amount + "원");
				
				$(".final_amount").val(data.final_amount);
				$(".pay_type").val("FI");
			}
			
			
			
		});
	
	});
	
  	// x 버튼 클릭 시 모달창 닫힘
	$(".modal-close, .close").click(function() {
		 $(".modal").fadeOut(200);
		 $(".modal-content").fadeOut(200, function() {
			location.reload();
		});
	});
         
    // 모달 닫기 (배경 클릭)
    $(".modal").click(function(event) {
        if (event.target === this) {
            $(this).fadeOut();
        }
    });
     
	$(".confirm").click(function(){
		if(!confirm("정산을 승인하시겠습니까?")) {
//			location.href="SetConfirm?project_code=" + project_code + "&member_email=" + email;	
			return false;
		}
	});
	
//	$(".delete").click(function(){
//		let accept = confirm("해당 프로젝트를 삭제하시겠습니까?")
//		if(accept){
//			location.href="ProjectDelete?project_code=" + project_code;
//		}
//	});
//	
//	$(".project-restore").click(function(){
//		let accept = confirm("해당 프로젝트를 복구하시겠습니까?")
//		if(accept){
//			location.href="ProjectRestore?project_code=" + project_code;
//		}
//	});
    
	
    

 });