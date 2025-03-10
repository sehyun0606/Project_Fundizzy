$(function() {
	var ws;
	var sId;

	
	// 해당 페이지 선택 표시를 위해 사이드바의 다른 페이지 아이콘 연하게 표시
	$("#chatRoom img").css("opacity", "0.3");
	
	// 채팅메인 페이지의 채팅상대리스트 폴딩 작업
	$('.foldingBtn').each(function() {
	    const peopleList = $(this).parent().siblings(".peopleList");

		// 처음 페이지 열렸을시 폴딩 오픈
	    peopleList.height(peopleList[0].scrollHeight);
	    $(this).text("▼");

		// 버튼 토글형식으로 폴딩 작업 수행
	    $(this).on("click", function() {
			// 폴딩 열려있을때 버튼 클릭시 작업
	        if (!peopleList.hasClass("closed")) {
	            peopleList.height(0);
	            $(this).text("▲");
	            peopleList.addClass("closed");
			// 폴딩 닫혀있을때 버튼 클릭시 작업
	        } else {
	            peopleList.height(peopleList[0].scrollHeight);
	            $(this).text("▼");
	            peopleList.removeClass("closed");
	        }
	    });
	});

});