$(function() {
	let news_code;
	let maxLength = 32;
	let currentLength;
	
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
						<input type="submit" value="임시저장" class="saveBtn" name="submit">
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

	});
	
});

















