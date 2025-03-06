// 모든 메뉴 항목에 클릭 이벤트 추가
document.querySelectorAll('.menu').forEach(menu => {
    menu.addEventListener('click', () => {
        // 이전에 열려있던 서브메뉴 닫기
        document.querySelectorAll('.submenu').forEach(submenu => {
            if (submenu !== menu.nextElementSibling) {
                submenu.classList.remove('show');
                submenu.style.maxHeight = '0'; // 최대 높이도 리셋
                submenu.previousElementSibling.classList.remove('active'); // 화살표 회전 초기화
            }
        });

        const submenu = menu.nextElementSibling; // 클릭한 메뉴의 다음 요소
        if (submenu.classList.contains('show')) {
            submenu.classList.remove('show'); // 이미 보이면 숨김
            submenu.style.maxHeight = '0'; // 최대 높이 리셋
            menu.classList.remove('active'); // 화살표 회전 초기화
        } else {
            submenu.classList.add('show'); // 보이지 않으면 보임
            submenu.style.maxHeight = '200px'; // 최대 높이 설정
            menu.classList.add('active'); // 화살표 회전
        }
    });
});