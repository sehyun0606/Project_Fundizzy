//function loginWithKakao() {
//	
//	const REST_API_KEY = "dac18f4f0b5faff6eae286e3e135c18f";
//	const REDIRECT_URI = "http://localhost:8081/kakaoCallback";	
//
//	// 로그인 상태 확인
////    Kakao.Auth.getStatusInfo(({ status }) => {
////        if (status === 'connected') {
////            // 이미 로그인된 상태 → 바로 메인 페이지로 이동
////            window.location.href = "/main";
////        } else {
////            // 로그인되지 않은 경우 → 로그인 창 띄우기
////            const width = 500;
////            const height = 700;
////            const left = (window.innerWidth / 2) - (width / 2);
////            const top = (window.innerHeight / 2) - (height / 2);
////
////            let authWindow = window.open("about:blank", "authWindow", `width=${width},height=${height},top=${top},left=${left}`);
////            authWindow.location = "https://kauth.kakao.com/oauth/authorize?"
////                + "response_type=code"
////                + "&client_id=" + REST_API_KEY
////                + "&redirect_uri=" + encodeURIComponent(REDIRECT_URI)
////                + "&prompt=none";
////        }
////            let authWindow = window.open("about:blank", "authWindow", `width=${width},height=${height},top=${top},left=${left}`);
//            authWindow.location = "https://kauth.kakao.com/oauth/authorize?"
//                + "response_type=code"
//                + "&client_id=" + REST_API_KEY
//                + "&redirect_uri=" + encodeURIComponent(REDIRECT_URI)
//                + "&prompt=none";
//	
//}
//
//
////	console.log("kakaoApikey : " + "dac18f4f0b5faff6eae286e3e135c18f" + "kakaoRedirectUri: " + "http://localhost:8081/kakaoCallback");
////	const KAKAO_AUTH_URL = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}"
////	window.location.href = KAKAO_AUTH_URL;	
//



function loginWithKakao() {
    const REST_API_KEY = "dac18f4f0b5faff6eae286e3e135c18f";
    const REDIRECT_URI = "http://localhost:8081/kakaoCallback";

    // REST API를 이용하여 로그인 상태 확인
    fetch(`https://kauth.kakao.com/oauth/authorize?
        client_id=${REST_API_KEY}
        &redirect_uri=${encodeURIComponent(REDIRECT_URI)}
        &response_type=code
        &prompt=none`, {
        method: "GET",
        credentials: "include"
    })
    .then(response => {
        if (response.redirected) {
            // 이미 로그인된 경우, 바로 메인 페이지로 이동
            window.location.href = "/main";
        } else {
            // 로그인되지 않은 경우 → 로그인 창 띄우기
            const width = 500;
            const height = 700;
            const left = (window.innerWidth / 2) - (width / 2);
            const top = (window.innerHeight / 2) - (height / 2);

            let authWindow = window.open("https://kauth.kakao.com/oauth/authorize?"
                + "response_type=code"
                + "&client_id=" + REST_API_KEY
                + "&redirect_uri=" + encodeURIComponent(REDIRECT_URI),
                "authWindow",
                `width=${width},height=${height},top=${top},left=${left}`
            );
        }
    })
    .catch(error => console.error("Error checking Kakao login status:", error));
}


















