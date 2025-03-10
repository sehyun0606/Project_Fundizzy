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

$(document).ready(function() {
	$("#PaymentComplete").on("click", function() {
	    let pay_amt = parseInt($("#pay_amt").text().replace(/[^0-9]/g,""));
	    let total_price_delivery = parseInt($("#total_price_delivery").text().replace(/[^0-9]/g,""));
	    console.log("페이 값 = " + pay_amt);
	    console.log("최종 결제 값 = " + total_price_delivery );


		if(pay_amt >= total_price_delivery){
			//결제가능
			if(confirm("결제하시겠습니까?")){
				alert("결제 완료!");
			} else {
				location.reload();
			}
			
		} else {
			alert("페이 잔액 부족으로 인한 결제 불가 \n 충전 후 다시 시도해주세요.");
		}
	});
});






