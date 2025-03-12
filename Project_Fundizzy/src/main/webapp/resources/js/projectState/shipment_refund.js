$(function() {
	// ======================= 발송 정보 입력 =======================
	$(".finBtn").click(function(e) {
		if($(".ship-num").val() == "") {
			alert("송장번호를 입력해주세요");
			e.preventDefault();
		}
	});
	
	// ======================= 환불 요청 처리 =======================
	// 환불 승인 버튼 클릭 이벤트
	$(document).on("click", ".approveBtn", function() {
		if(confirm("환불 요청을 승인하시겠습니까?")) {

		}
	});
	
	// (환불)확인하기 버튼 클릭 이벤트
	$(document).on("click", ".rejectBtn", function() {
		// 환불 거절버튼 클릭 시 거절사유 폼 append
		$(".reject-reason").append(
			`<h4>반환 거절 사유</h4>
			<textarea rows="7" cols="15" maxlength="600" name="reject_reason"></textarea>
			<div class="char-count">0/600</div>`
		);

		// 거절사유 폼 css
		$(".reject-reason").css({
			"border-top": "1px solid #ddd",
			"padding-bottom": "20px"
		});
		
		// 기존 버튼 대신 완료, 닫기 버튼으로 변경
		$("#refund-modal .btn-container").html(
			`<div class="btn-container">
				<input type="submit" value="완료" class="finBtn">
				<input type="button" value="닫기" class="closeBtn">
			</div>`
		);
		
	});
	
	// textarea에 작성된 글자수 동적으로 업데이트
	$(document).on("input", ".refuse-reason textarea", function() {
		let maxLength = 600;
		let currentLength = $(this).val().length;

		$(".char-count").text(currentLength + "/" + maxLength);
	});
	
	
	
		        


		        
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});
















