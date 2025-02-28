document.addEventListener("DOMContentLoaded", function () {
    const banner = document.querySelector('.main-banner'); // 슬라이드가 포함된 컨테이너
    const prev = document.querySelector('.prev'); // 이전 버튼
    const next = document.querySelector('.next'); // 다음 버튼

    prev.addEventListener("click", () => {
	 	const slides = document.querySelectorAll('.slide')
        console.log("이전 버튼 클릭됨");
        banner.append(slides[0]);
    });

    next.addEventListener("click", () => {
	 	const slides = document.querySelectorAll('.slide')
        console.log("다음 버튼 클릭됨");
        banner.prepend(slides[slides.length-1])
    });
});
