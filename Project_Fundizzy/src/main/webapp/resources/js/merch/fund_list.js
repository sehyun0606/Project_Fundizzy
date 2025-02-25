document.addEventListener("DOMContentLoaded", function () {
    const banner = document.querySelector('.main-banner'); // 슬라이드가 포함된 컨테이너
    const slidesContainer = document.querySelectorAll('.slide'); // 슬라이드 요소들
    const prev = document.querySelector('.prev'); // 이전 버튼
    const next = document.querySelector('.next'); // 다음 버튼

    prev.addEventListener("click", () => {
        console.log("이전 버튼 클릭됨");
        const firstSlide = banner.querySelector('.slide'); // 첫 번째 슬라이드 가져오기
        banner.appendChild(firstSlide); // 첫 번째 슬라이드를 맨 뒤로 이동
    });

    next.addEventListener("click", () => {
        console.log("다음 버튼 클릭됨");
        const lastSlide = banner.querySelector('.slide:last-child'); // 마지막 슬라이드 가져오기
        banner.insertBefore(lastSlide, banner.firstElementChild); // 마지막 슬라이드를 맨 앞으로 이동
    });
});
