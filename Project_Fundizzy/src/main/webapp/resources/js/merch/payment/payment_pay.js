$(document).ready(function () {
    // 프로젝트 코드 보내기
    let project_code = $("#project_code").val();

    $(".back").on("click", function () {
        location.href = "PaymentReward?project_code=" + project_code;
    });

    // 주소 - 새로 입력 누르면 div 뜨도록
	$("input[name='addressRadio']").change(function() {
		if($(this).attr("id") == 'address') {
			$(".new_address_box").css("display", "none");
			
			$("input[name='post_code']").val($("#db_post_code").val());
			$("input[name='address1']").val($("#db_address1").val());
			$("input[name='address2']").val($("#db_address2").val());
			$("input[name='phone_num']").val($("#db_phone").val());
			$("input[name='extra_address']").val("");
		} else {
			
			$(".new_address_box").css("display", "block");
			
			$(".addressInfo").each(function() {
				$(this).val("");
			});
		}
	});
	
	$("#ship-name").blur(function() {
		$("#ship-newName").val($(this).val());
	});
	
   $("#PaymentComplete").on("click", function(event) {
		// 폼 제출 방지
        event.preventDefault(); 

		// 음수도 포함
        let pay_amt = $("#pay_amt").text().replace(/[^0-9-]/g, ""); 
        pay_amt = parseInt(pay_amt, 10);
        
        let total_price_delivery = $("#total_price_delivery").text().replace(/[^0-9]/g, ""); 
        total_price_delivery = parseInt(total_price_delivery, 10); 

        // 숫자 변환 오류 방지
        if (isNaN(pay_amt)) pay_amt = 0;
        if (isNaN(total_price_delivery)) total_price_delivery = 0;


        // 음수이거나 부족할 경우 결제 불가
        if (pay_amt < total_price_delivery || pay_amt < 0) {
            alert("페이 잔액 부족으로 인해 결제가 불가능합니다.\n페이 충전 후 다시 시도해 주세요.");
            return false; // 결제 진행 중단
        }

	    // 체크해야 하는 모든 필수 체크박스
	    let allChecked = $("#agree1").is(":checked") && $("#agree2").is(":checked") && $("#agree3").is(":checked");
	
	    // 하나라도 체크되지 않으면 알람 출력 후 폼 제출 방지
	    if (!allChecked) {
	        alert("모든 필수 항목에 동의해야 결제 진행이 가능합니다.");
	        event.preventDefault(); // 기본 폼 제출 방지
	        return false; // 추가 실행 방지
	    }
        // 결제 가능하면 폼 제출
        $("#complete-form").submit();
    });

// ------------------------------- 충전 모달창 관련 js ----------------------------

    // 충전 버튼 클릭 시 페이지 이동 전에 데이터 저장
    $("#charge-btn-modal").on("click", function () {
	   	$(".charge_modal").css("display", "block");
	});
		
	$(".x").click(function(){
		$(".charge_modal").css("display", "none");
	});
	
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
	
	$("#charge-submit-modal").click(function (event) {
            event.preventDefault(); // 기본 제출 막기

            let amount = $("#fundizy-pay").val().trim(); // 입력된 금액 가져오기

            if (!amount || isNaN(amount) || Number(amount) <= 0) {
                alert("올바른 충전 금액을 입력해주세요.");
                return;
            }

            // AJAX로 서버에 충전 요청
            $.ajax({
                type: "POST",
                url: "PayCharge",
                data: { tran_amt: amount },
                success: function (response) {
                    alert("충전되었습니다!");
                    $("#fundizy-pay").val(""); // 입력창 초기화
					$(".charge_modal").css("display", "none");
					location.reload();
					
                },
                error: function () {
                    alert("충전에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });
	//체크박스 미 체크 시 다음 결제창으로 못 넘어가도록 
	

}); //전체 함수 종료


//주소입력 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}



