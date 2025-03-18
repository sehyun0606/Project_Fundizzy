$(document).ready(function() {
    const banner = document.querySelector('.main-banner'); // 슬라이드가 포함된 컨테이너
    const prev = document.querySelector('.prev'); // 이전 버튼
    const next = document.querySelector('.next'); // 다음 버튼

    next.addEventListener("click", () => {
	 	const slides = document.querySelectorAll('.slide')
        banner.append(slides[0]);
    });

    prev.addEventListener("click", () => {
	 	const slides = document.querySelectorAll('.slide')
        banner.prepend(slides[slides.length-1])
    });

	$(".product-img, .product-info").on("click", function(event) {
    	// 클릭된 요소의 부모를 찾기
	    let parent = $(this).closest(".product"); // .product 요소 찾기
	    
	    // 부모 요소에서 project_code를 가져오기
	    let project_code = parent.find(".project_code").val(); // hidden input에서 value 가져오기
	
		location.href = "OpenBoardStory?project_code=" + project_code;
	});


});
