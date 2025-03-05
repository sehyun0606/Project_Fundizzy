function loginWithKakao() {
	
	const REST_API_KEY = "dac18f4f0b5faff6eae286e3e135c18f";
	const REDIRECT_URI = "http://localhost:8081/kakaoCallback";	
	
	const width = 500;
	const height = 700;

	// 화면의 중앙 좌표 계산
	const left = (window.innerWidth / 2) - (width / 2);
	const top = (window.innerHeight / 2) - (height / 2);

	let authWindow = window.open("about:blank", "authWindow", `width=${width},height=${height},top=${top},left=${left}`);
	authWindow.location = "https://kauth.kakao.com/oauth/authorize?"
						+ "response_type=code"
						+ "&client_id=" + REST_API_KEY // 변수 사용
						+ "&redirect_uri=" + encodeURIComponent(REDIRECT_URI)
						
	
}


//	console.log("kakaoApikey : " + "dac18f4f0b5faff6eae286e3e135c18f" + "kakaoRedirectUri: " + "http://localhost:8081/kakaoCallback");
//	const KAKAO_AUTH_URL = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}"
//	window.location.href = KAKAO_AUTH_URL;	