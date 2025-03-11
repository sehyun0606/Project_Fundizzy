//function loginWithKakao() {
//	const kakaoClientId = window.config.kakaoClientId;
//	const kakaoRedirectUrl = window.config.kakaoRedirectUrl;
//    const width = 500;
//    const height = 700;
//    const left = (window.innerWidth / 2) - (width / 2);
//    const top = (window.innerHeight / 2) - (height / 2);
//
//    let authWindow = window.open("about:blank", "authWindow", `width=${width},height=${height},top=${top},left=${left}`);
//    authWindow.location = `https://kauth.kakao.com/oauth/authorize?`
//        + `response_type=code`
//        + `&client_id=${kakaoClientId}`
//        + `&redirect_uri=${encodeURIComponent(kakaoRedirectUrl)}`
//        + `&prompt=none`;
//}

//-----------------------------------------------------------------------------------------------------------------------------
// 카카오 로그인 js
function loginWithKakao() {
//	const kakaoClientId = window.config.kakaoClientId;
//	const kakaoRedirectUrl = window.config.kakaoRedirectUrl;
	const kakaoApiKey = "dac18f4f0b5faff6eae286e3e135c18f";
	const kakaoRedirectUrl = "http://localhost:8081/kakaoCallback";
    const width = 500;
    const height = 700;
    const left = (window.innerWidth / 2) - (width / 2);
    const top = (window.innerHeight / 2) - (height / 2);

	let authWindow = window.open("about:blank", "authWindow", "width=500,height=700,top=" + top + ",left=" + left);
	authWindow.location = "https://kauth.kakao.com/oauth/authorize?"
				+ "response_type=code"
				+ "&client_id=" + kakaoApiKey
				+ "&redirect_uri=" + encodeURIComponent(kakaoRedirectUrl);

}




//function loginWithKakao() {
//	const kakaoClientId = window.config.kakaoClientId;
//	const kakaoRedirectUrl = window.config.kakaoRedirectUrl;
////    const kakaoClientId = "dac18f4f0b5faff6eae286e3e135c18f";
////    const kakaoRedirectUrl = "http://localhost:8081/kakaoCallback";
//
//    const kakaoLoginUrl = `https://kauth.kakao.com/oauth/authorize?client_id=${kakaoClientId}&redirect_uri=${encodeURIComponent(kakaoRedirectUrl)}&response_type=code`;
//
//    window.location.href = kakaoLoginUrl; // 창을 열지 않고 바로 이동
//}






//-----------------------------------------------------------------------------------------------------------------------------
// 네이버 로그인
function loginWithNaver() {
	
	const naverClientId = window.config.naverClientId;
	const naverClientSecret = window.config.naverClientSecret;
	const naverRedirectUrl = window.config.naverRedirectUrl;
	const state = messageFromJSP;
	console.log("naverClientId:", naverClientId);
	console.log("naverClientSecret:", naverClientSecret);
	console.log("naverRedirectUrl:", naverRedirectUrl);
	console.log("state:", state);

//	const CLIENT_ID = "nVS26rI05YiQysGlYd2m";
//	const CLIENT_SECRET = "iF7pkI7_dn";
//	const REDIRECT_URL = "http://localhost:8081/NaverCallback";
	
	console.log("CLIENT_ID : " + naverClientId + " CLIENT_SECRET : " + naverClientSecret + " REDIRECT_URL : " + naverRedirectUrl + " state : " + state);
	
	const width = 500;
    const height = 700;
    const left = (window.innerWidth / 2) - (width / 2);
    const top = (window.innerHeight / 2) - (height / 2);

	let authWindow = window.open("about:blank", "authWindow", "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left);
	authWindow.location.href = "https://nid.naver.com/oauth2.0/authorize?"
        + "response_type=code"
        + "&client_id=" + naverClientId
        + "&redirect_uri=" + encodeURIComponent(naverRedirectUrl)
		+ "&state=" + state ;
		
}

//    let authWindow = window.open("https://nid.naver.com/oauth2.0/authorize?"
//        + "response_type=code"
//        + "&client_id=" + CLIENT_ID
//        + "&redirect_uri=" + encodeURIComponent(REDIRECT_URL),
//        "authWindow",
//        `width=${width},height=${height},top=${top},left=${left}`

//    const REST_API_KEY = "dac18f4f0b5faff6eae286e3e135c18f";
//    const REDIRECT_URL = "http://localhost:8081/kakaoCallback";













































