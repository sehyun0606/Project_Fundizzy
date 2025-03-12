$(function() {
    //주소 - 새로입력 누르면 div 뜨도록
    $("#new_address").on("click", function() {
        $(".new_address_box").css("display", "block");
    });
    $("#address").on("click", function() {
        $(".new_address_box").css("display", "none");
    });
});


$(document).ready(function() {
    $("#new_address").on("click", function() {
        if ($(this).is(":checked")) {
            $(".new_address_box").slideDown(); // 보이기
        } else {
            $(".new_address_box").slideUp(); // 숨기기
        }
    });
});

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


//결제버튼 클릭 시 
$(document).ready(function() {

	$("#PaymentComplete").on("click", function() {

		let payment_price_text = $("#total_price_delivery").text().replace(/[^0-9]/g, "");// 총 결제값
		let payment_price = parseInt(payment_price_text, 10) || 0; // 숫자로 변환 (NaN 방지)
		let pay_balance_text = $("#pay_amt").text().replace(/[^0-9]/g, ""); // 현재 충전된 페이 금액
		let pay_balance = parseInt(pay_balance_text, 10) || 0; // 숫자로 변환 (NaN 방지)
	
		
		console.log("payment_price " + payment_price);
		console.log("pay_balance " + pay_balance);
		

			if (pay_balance >= payment_price) {
		    // 결제 가능
				
			// 프로젝트 코드 보내기
			let project_code = $("#project_code").val();
			console.log("project_code: ", project_code); 
			
			//수량 및 리워드(개당) 가격 보내기
			let total_count = $("#total_count").val();
			console.log("total_count = " + total_count);
			let reward_price = $("#reward_price").val(); 
			console.log("1개 가격 = " + reward_price);

		    if (confirm("결제하시겠습니까?")) {
		        // 1. 배송할 주소 및 정보 저장
		        let name = '';
		        let phone = '';
		        let post = '';
		        let address1 = '';
		        let address2 = '';
		        let extra_address = '';
				let shipment_box = '';
		
		        // 새로 입력한 정보도 미리 정의
		        let new_name = "";
		        let new_phone = "";
		        let new_post = "";
		        let new_address1 = "";
		        let new_address2 = "";
		        let new_address3 = "";
				

		        if ($("#address").prop("checked")) {
		            // 회원정보를 기반으로 생성한 배송지 선택
		            name = $("#ship-name").val();
		            console.log("name = " + name);
		
		            let phone_text = $("#ship-phone").text().replace(/[^0-9]/g, "");  // 숫자만 추출
		            phone = phone_text || ''; // 빈 값 처리
		            console.log("phone = " + phone);
		
		            post = $("#ship-postcode").text();
		            console.log("post = " + post);
		
		            address1 = $("#ship-address1").text(); // 주소
		            console.log("address1 = " + address1);
		
		            address2 = $("#ship-address2").text(); // 상세주소
		            console.log("address2 = " + address2);

					if (!new_name) {
						alert("배송받으시는 분의 성함을 입력해주세요");
						location.reload();
					}	
					if (!phone_text || !post || !address1 ) {
						alert("배송받으시는 분의 정보가 부족합니다. 새로 입력창을 통해 기입해 주세요.");
						location.reload();
					}
				

		        } else {
		            // 새로 입력한 배송지 선택
		            new_name = $("#ship-new-name + input").val();
		            console.log("new_name = " + new_name);
		
		            new_phone = $("#ship-new-phone + input").val();
		            console.log("new_phone = " + new_phone);
		
		            new_post = $("#sample6_postcode").val(); // 우편번호
		            console.log("new_post = " + new_post);
		
		            new_address1 = $("#sample6_address").val(); // 주소
		            console.log("new_address1 = " + new_address1);
		
		            new_address2 = $("#sample6_detailAddress").val(); // 상세주소
		            console.log("new_address2 = " + new_address2);
		
		            new_address3 = $("#sample6_extraAddress").val(); // 참조항목
		            console.log("new_address3 = " + new_address3);
					
					//만약 새로 입력중 필수항목도 기입 안 한 경우
					if (!new_name) {
						alert("배송받으시는 분의 성함을 입력해주세요");
						location.reload();
					}
					
					if (!new_phone ) {
						alert("배송받으시는 분의 전화번호를 입력해주세요");
						location.reload();
					}
					
					if (!new_post || !new_address1) {
						alert("배송받을 주소 및 우편번호를 입력해주세요");
						location.reload();
					}
					
					
		        }
				
				//배송요청사항 
				
				$("#shipment-box").on("input", function () {
				    shipment_box = $(this).val();
				    console.log("shipment_box = " + shipment_box);
				});
				
				if(shipment_box != null){
				  	shipment_box = $("#shipment-box").val(); // 배송 요청사항
		            console.log("shipment_box = " + shipment_box);
				}
		
		        // 2. 페이 결제
		        let result_balance = pay_balance - payment_price;
		        console.log("result_balance = " + result_balance);
		
		        // 3. 약관동의
		        if (!$("#agree1").prop("checked") || !$("#agree2").prop("checked") || !$("#agree3").prop("checked")) {
		            alert("결제 진행 필수 동의에 체크해주세요.");
		        }
		
		        $.ajax({
		            type: "POST",
		            url: "PaymentComplete",
		            data: {
		                // 회원정보 기반 배송지를 선택한 경우에는 해당 정보만
		                // 새로 입력한 정보를 선택한 경우에는 그 정보만 보내기
						project_code : project_code,
		                name: name,
		                phone_num: phone,
		                post_code: post,
		                address: address1,
		                address1: address2,
		                delivery_req: shipment_box,

		
		                new_name: new_name,
		                new_phone: new_phone,
		                new_post_code: new_post,
		                new_address: new_address1,
		                new_address1: new_address2,
		                extra_address: new_address3,
		
		                payment_price: payment_price, // 총 결제 금액
		                pay_balance: pay_balance, // 결제 전 페이 잔액
		                result_balance: result_balance, // 결제 후 페이 잔액

						//완료 페이지에 띄울 수량 및 리워드 금액 
						total_count: total_count,
						reward_price: reward_price
		            }
		        }).done(function (result) {
		            console.log("결제 성공");
		            alert("결제가 완료되었습니다.");
					window.location.href = "PaymentComplete";
					
		        }).fail(function () {

		            alert("결제 중 오류가 발생했습니다. 다시 시도해주세요.");
					location.reload();
		        });
		
		    } else {
		        location.reload();
		    }
		} else {
		    alert("페이 잔액 부족으로 인한 결제 불가 \n 충전 후 다시 시도해주세요.");
		}
	});

});






