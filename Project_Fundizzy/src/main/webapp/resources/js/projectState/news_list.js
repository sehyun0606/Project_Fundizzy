$(function() {
	let news_code;
	let maxLength = 32;
	let currentLength;
	
	// 등록시간 형식변환(n분 전, n시간 전)
	$(".date").each(function() {
		console.log($(this).text());
	    let dateValue = $(this).text();
		$(this).text(elapsedTime(dateValue));
	});

	
	// 새소식 폼 제목에 작성가능 글자수 보여주기
	$(document).on( "input", "input[name='news_title']", function() {
		
		currentLength = maxLength - $(this).val().length;
	
		if(currentLength < 0) {
			currentLength = 0;
			$(".char-count").text(currentLength + "자 남음");
		}
		$(".char-count").text(currentLength + "자 남음");
	});
	
	$(document).on("click", ".modifyBtn, .post2Btn", function () {
	    // 수정 버튼이 클릭된 새소식 정보 가져오기
	    news_code = parseInt($(this).closest(".list-container").find(".news_code").val()); 
	    $(".news_code").val(news_code);
		console.log(currentLength);
		$(".char-count").text(currentLength + "자 남음");

	    // 모달창 열기
	    $(".modal2").fadeIn();
	    $(".modal-content2").fadeIn();

		// ajax로 수정할 내용 포함한 새소식 모달창 띄우기
		$.ajax({
			type : "GET",
			url : "NewsModify",
			data : {
				news_code
			}
		}).done(function(newsList) {
			
			$(".news-container").append(
				`<div class="board-container">
					<div class="title-container">
						<input type="text" name="news_title" class="news_title" value="${newsList.news_title}" placeholder="제목을 입력해 주세요" maxlength="32" required>
						<div class="char-count">자 남음</div>
					</div>
					<textarea name="news_content" class="news_content" placeholder="내용을 입력해 주세요" maxlength="1000" required>${newsList.news_content}</textarea>
				</div>
				<div class="btn-container">
					${newsList.news_status == 'Y' ? `
						<input type="button" value="닫기" class="close" name="submit">
						<input type="submit" value="수정하기" class="postBtn" name="submit">
						`:`
						<input type="submit" value="임시저장" class="saveBtn" name="submit">
						<input type="submit" value="게시하기" class="postBtn" name="submit">
					`}
				</div>`
			);
			
			currentLength = newsList.news_title.length;
			$(".char-count").text((maxLength - currentLength) + "자 남음");
		});
		
		$(document).on("click", ".close", function() {
			 $(".modal").fadeOut(200);
			 $(".modal-content").fadeOut(200, function() {
				location.reload();
			});
		});

	});
	
	
	
	// 현재날짜와 비교하여 날짜 형식 변환하는 함수
	function elapsedTime(date) {
		
	  	const start = new Date(date);
	  	const end = new Date();
	 
	 	 const diff = (end - start) / 1000;
	
		// 7일(604800초) 이상이면 날짜 그대로 반환
	    if (diff > 60 * 60 * 24 * 7) {
	        return start.toISOString().split('T')[0]; // YYYY-MM-DD 형식 반환
	    }
	  
	  	const times = [
	    	{ name: '년', milliSeconds: 60 * 60 * 24 * 365 },
	    	{ name: '개월', milliSeconds: 60 * 60 * 24 * 30 },
	    	{ name: '일', milliSeconds: 60 * 60 * 24 },
	    	{ name: '시간', milliSeconds: 60 * 60 },
	    	{ name: '분', milliSeconds: 60 },
	  	];
	 
	  	for (const value of times) {
	    	const betweenTime = Math.floor(diff / value.milliSeconds);
	 
	    	if (betweenTime > 0) {
	      		return `${betweenTime}${value.name} 전`;
			}
	  	}
	  	return '방금 전';
	}
 
	
});

















