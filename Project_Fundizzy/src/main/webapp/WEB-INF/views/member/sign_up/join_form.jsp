<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <title>Fundizy Registration</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff;
            text-align: center;
            margin-top: 0;
            margin-bottom: 100px;
        }
        .container {
            width: 100%;
            max-width: 600px; /* 전체 너비 줄이기 */
            margin: 0 auto;
            padding-top: 0px; /* 상단 여백 줄이기 */
        }
        h1 {
            font-size: 20px;
            color: #000;
            cursor: pointer;
        }
        h2 {
        	font-size: 15px;
        	text-align: left;
			margin-left: 100px;
        }
        .social-login {
            margin-top: 0px;
            margin-bottom: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: px;
        }
        .social-login img {
            width: 400px;
            height: auto;
            cursor: pointer;
            transition: transform 0.2s; /* 부드러운 전환 효과 추가 */
        }
        .social-login img:hover {
            transform: scale(1.05); /* 약간의 확대 효과 */
        }
        .social-login button {
            width: 80%;
            max-width: 400px;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        .kakao-login {
            background-color: #FEE500;
            color: #000;
        }
        .naver-login {
            background-color: #03C75A;
            color: #fff;
        }
        .social-icons {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }
        .social-icons img {
            width: 40px;
            height: 40px;
            margin: 0 10px;
            cursor: pointer;
        }
        .email-signup {
            text-align: left;
            width: 80%;
            max-width: 400px;
            margin: 0 auto;
        }
        .email-signup h3 {
            font-size: 15px;
            margin-bottom: 0px;
            margin-top: auto;
        }
        .email-signup .nickname {
			margin-bottom: 20px;			        
        }
        .email-signup input {
            width: calc(100% - 0px);
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .email-signup .auth-btn {
			width: 80px;
		    height: 42px;
		    padding: 10px;
		    background-color: mediumpurple;
		    border: none;
		    color: white;
		    border-radius: 5px;
		    cursor: pointer;
		    margin-top: 8px;
            margin-left: 10px; 
	        font-size: 10px;
        }
        .email-signup .auth-btn:hover {
        	background-color: #8e44ad;
        }
        .email-signup .submit-btn {
            width: 100%;
            padding: 15px;
            background-color: mediumpurple;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        .email-signup .submit-btn:hover {
            background-color: #8e44ad;
        }
        .email-signup .password-input {
            display: flex;
            justify-content: space-between;
        }
        .email-signup .password-input input {
            width: calc(100% - 80px);
        }
        .email-signup .auth-input {
            display: flex;
            justify-content: space-between;
            margin-top: 0px;
            margin-bottom: 10px;
        }
        .email-signup .auth-input input {
            width: calc(100% - 80px);
        }
        .email-signup .password-input2 {
            display: flex;
            justify-content: space-between;
        }
        .email-signup .password-input input2 {
            width: calc(100% - 0px);
        }
        .email-signup .eye-btn {
            width: 40px;
            background-color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        
/* ---------------------------------------------------------------------- */
		.auth-container {
			 display: flex;
			 flex-direction: column;
			 width: 400px;
		}
		.auth-sections {
			display: flex;
			flex-direction: column;
			width: 400px;
			margin-bottom: 20px;
		}
		.auth-label {
		  font-size: 16px;
		  margin-bottom: 0px;
		  margin-top: auto;
		  color: gray;
		}
		
		.email-wrapper {
		  display: flex;
		  align-items: center;
		  margin-bottom: 15px;
		}
		
		.email-input {
		  width: 75%;
		  padding: 10px;
		  border: 1px solid #dcdcdc;
		  border-radius: 4px;
		/*   background-color: #f2f8ff; /* 연한 파란색 배경 */ */
		  color: #333;
		}
		
		.edit-btn {
			background-color: mediumpurple;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    margin-left: 10px;
		    cursor: pointer;
		    height: 42px;
		    width: 70px;
		    font-size: 10px;
		}
		
		.edit-btn:hover {
		  background-color: #8e44ad;
		}
		
		.auth-input-wrapper {
		  display: flex;
		  align-items: center;
		  position: relative;
		  margin-bottom: 5px;
		}
		
		.auth-code-input {
		  width: 70%;
		  padding: 10px;
		  border: 1px solid #dcdcdc;
		  border-radius: 4px;
		  padding-right: 50px; /* 타이머를 위한 여백 */
		}
		
		.timer {
		  position: absolute;
		  right: 80px;
		  color: red;
		  font-size: 12px;
		}
		
		.confirm-btn {
		 	background-color: mediumpurple;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    margin-left: 10px;
		    cursor: pointer;
		    height: 42px;
		    width: 70px;
		}
		
		.confirm-btn:hover {
		  background-color: #8e44ad;
		}
		
		small {
		   color: #888;
		   margin-top: auto;
		}
		
		.resend-link {
			font-size: 10px;
			color: #555;
			margin-top: 0px;
			text-decoration: underline;
			cursor: pointer;
			margin-bottom: 20px;
			margin-left: 120px;
		}
		
		.resend-link:hover {
		  color: #333;
		}

		/* 모달 스타일 */
		.modal {
			display: none; /* 기본적으로 숨김 */
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0, 0, 0, 0.5);
			justify-content: center;
			align-items: center;
		}
		
		.modal-content {
			background-color: white;
			padding: 20px;
			border-radius: 10px;
			width: 300px;
			text-align: left;
			position: relative;
		}
		
		ul {
			list-style: none;
			padding: 0;
		}
		
		li {
			margin-bottom: 10px;					
		}
		
		/* 닫기 버튼 (X) 스타일 */
		.close-btn {
		  	position: absolute;
			top: 10px;
			right: 20px;
			font-size: 30px;
			cursor: pointer;
			margin-top: 15px;
		}
		
		.confirm-btn2 {
			background-color: mediumpurple;
			color: white;
			padding: 10px 20px;
			border: none;
			cursor: pointer;
			width: 100%;
			margin-top: 20px;
			margin-left: 0px;
		}
		
		/* 체크박스와 라벨 간격 조정 */
		input[type="checkbox"] {
			margin-right: 10px;
		}
		label {
		  	cursor: pointer; /* 체크박스 클릭 가능하게 */
		}
        
        /* 인증번호 success/fail 메세지 css */
        .success-message {
		    color: green;
		    font-weight: bold;
	        margin-right: 118px;
		}
		
		.error-message {
		    color: red;
		    font-weight: bold;
	        margin-right: 118px;
		}
        /* 기본 입력 필드 스타일 */
		input {
		    border: 2px solid #ddd;
		    padding: 10px;
		    border-radius: 5px;
		}
		
		/* 포커스 시에도 테두리 색상을 유지 */
		input:focus {
		    outline: none; /* 기본 브라우저 outline 제거 */
		    border: 2px solid; /* 여기서 JS로 설정한 테두리 색상을 유지 */
		}
        
    </style>
</head>
<body>

<div class="container">
    <h1 style="color: mediumpurple;" onclick="location.href='./'">Fundizy</h1>
    <hr style="border: 0; height: 1px; background-color: #dcdcdc;">
	<h2 style="color: gray;">간편가입</h2>
    <!-- Social Login -->
    <div class="social-login">
        <a href="YOUR_KAKAO_LOGIN_URL">
            <img src="${pageContext.request.contextPath}/resources/images/login/kakao_login_custom.png" alt="카카오 로그인 버튼">
        </a>
        <a href="YOUR_NAVER_LOGIN_URL">
            <img src="${pageContext.request.contextPath}/resources/images/login/naver_login_custom.png" alt="네이버 로그인 버튼">
        </a>

        <div class="social-icons">
            <img src="${pageContext.request.contextPath}/resources/images/login/google_icon.png" alt="Google">
            <img src="${pageContext.request.contextPath}/resources/images/login/facebook_login.png" alt="Facebook">
            <img src="${pageContext.request.contextPath}/resources/images/login/apple_login.png" alt="Apple">
        </div>
    </div>
	<hr style="border: 0; height: 1px; background-color: #dcdcdc;">
    <!-- Email Sign-Up -->
    <form action="SignUpAction" method="POST" id="terms-form">
	    <div class="email-signup">
		    <div class="auth-container">
				<label for="email" class="auth-label" style="color: gray;"><b>이메일</b></label>
				<div class="email-wrapper">
				  <input type="email" id="email" name="email" class="email-input" placeholder="이메일을 입력하세요" required>
				  <button type="button" id="sendMail" class="edit-btn" onclick="showAuthInput()">인증하기</button>
				</div>
			</div>
			<div class="auth-sections" id="auth-section" style="display: none;">
				<label for="auth_code"  class="auth-label"><b>인증번호</b></label>
				<div class="auth-input-wrapper">
				  <input type="text" id="auth_code" name="auth_code" placeholder="인증번호 입력" class="auth-code-input">
				  <span class="timer" id="timer"></span>
				  <button id="confirmButton" class="confirm-btn">확인</button>
				</div>
				<small id="resultMessage">인증번호 6자리를 입력하세요.</small>
				<a href="#" class="resend-link">인증번호 다시 보내기</a>
			</div>
			
	        <h3 style="color: gray;">닉네임</h3>
	        <input type="text" id="nickname" name="nickname" class="nickname" placeholder="닉네임 입력" required disabled/>
	
	        <h3 style="color: gray;">비밀번호</h3>
	        <div class="password-input2">
	            <input type="password" id="password" name="password" placeholder="비밀번호 입력" required  disabled/>
	        </div>
	        <div id="checkPasswdResult" style="font-size: 12px;"></div>
	        <div class="password-input2">
	            <input type="password" id="confirm-password" name="password2" placeholder="비밀번호 확인" required  disabled/>
	        </div>
	        <div id="checkPasswd2Result" style="font-size: 12px;"></div>
	        <input type="button" class="submit-btn" id="openModal" value="약관 동의 후 가입 완료하기">
<!-- 	        <button class="submit-btn">약관 동의 후 가입 완료하기</button> -->
	    </div>
	    <!-- 모달 창 -->
		<div class="modal" id="termsModal">
		  <div class="modal-content">
		    <!-- 닫기 버튼 -->
		    <span class="close-btn" id="closeModal">&times;</span>
		    <h2 style="margin-left: 0px;">약관확인</h2>
		    <p style="font-size: 15px;">개별 동의 선택이 가능하며, 필수 항목에 동의하셔야 서비스 이용이 가능합니다.</p>
		    
		    <ul>
		      <li>
		        <label for="agreeAll"><input type="checkbox" id="agreeAll"> 전체 동의 (서비스 항목 포함)</label>
		      </li>
		      <hr>
		      <li>
		        <label><input type="checkbox" class="required"> 회원 | 서비스 가입 <span style="color: mediumpurple">(필수)</span></label>
		      </li>
		      <hr>
		      <li>
		        <label><input type="checkbox" class="required"> 회원가입 약관 <span style="color: mediumpurple">(필수)</span></label>
		      </li>
		      <hr>
		      <li>
		        <label><input type="checkbox" class="required"> 서포터 이용약관 <span style="color: mediumpurple">(필수)</span></label>
		      </li>
		      <hr>
		      <li>
		        <label><input type="checkbox" class="required"> 개인정보 수집 및 이용동의 <span style="color: mediumpurple">(필수)</span></label>
		      </li>
		      <hr>
		      <li>
		        <label><input type="checkbox" name="is_receive_notification"> 회원 | 서비스 이벤트 혜택 알림 (선택)</label>
		      </li>
		      <hr>
		      <li>
		        <label><input type="checkbox" class="required"> 만 14세 이상입니다. <span style="color: mediumpurple">(필수)</span></label>
		      </li>
		    </ul>
		
		    <input type="submit" class="confirm-btn2" value="확인">
		  </div>
		</div>
	</form>
</div>

	<script type="text/javascript">
		// 이메일 보내기 자바 스크립트
		$("#sendMail").click(function(){
			let email = $("#email").val();
			if (email == "") {
	            alert("이메일을 입력하세요.");
	            return;
			} else {
				// 인증 텍스트박스 display none 해제
		    	$('#auth-section').css('display', 'block');
			}
			// AJAX 요청으로 이메일 전송
		    $.ajax({
		        url: 'sendAuthMail',
		        type: 'GET',
		        data: {
		        	email: email
		        }
			}).done(function(result){
				alert("메일 발송 성공!")
			}).fail(function(){
				alert("메일 전송 실패!");
			});
		});
		
		$("#confirmButton").click(function(){
			event.preventDefault();  // 기본 폼 제출 동작 방지 (submit 방지)
			
			let code = $("#auth_code").val();
			let email = $("#email").val();
			if(code == ""){
				alert("인증번호를 입력하세요!");
				return;
			}
			$.ajax({
				url: 'authCodeCheck',
				type: 'GET',
				data: {
					email : email,
					code : code
				}
			}).done(function(result){
				if(result.trim() == "true") {
					console.log("인증성공!");
					$("#resultMessage").text("인증 성공!").removeClass("error-message").addClass("success-message").show();
			    	// 닉네임 텍스트박스 disabled 해제
					$('#nickname').prop('disabled', false);
			    	// 패스워드 텍스트박스 disabled 해제
					$('#password').prop('disabled', false);
			    	// 패스워드 확인 텍스트박스 disabled 해제
					$('#confirm-password').prop('disabled', false);
				} else {
					console.log("인증실패! 다시 입력해주세요");
					$("#resultMessage").text("인증 실패!").removeClass("success-message").addClass("error-message").show();
			    	// 닉네임 텍스트박스 disabled
					$('#nickname').prop('disabled', true);
			    	// 패스워드 텍스트박스 disabled 
					$('#password').prop('disabled', true);
			    	// 패스워드 확인 텍스트박스 disabled 
					$('#confirm-password').prop('disabled', true);
				}
			}).fail(function() {
				alert("AJEX 요청 오류!");		
			});
		});
		
		// 타이머 설정
		let timeLeft = 180; // 3분(180초)
		let timerInterval;
	
		function startTimer() {
		  timerInterval = setInterval(function () {
		    let minutes = Math.floor(timeLeft / 60);
		    let seconds = timeLeft % 60;
		    seconds = seconds < 10 ? '0' + seconds : seconds;
	
		    document.getElementById('timer').textContent = minutes + ":" + seconds;
	
		    if (timeLeft > 0) {
		        timeLeft--;
		    } else {
		        clearInterval(timerInterval);
		        document.getElementById('timer').textContent = "시간초과";
		        $("#confirmButton").prop('disabled', true);  // 확인 버튼 비활성화
		    }

		  }, 1000); // 1초마다 업데이트
		}
		// 타이머 시작
		startTimer();
	//--------------------------------------------------------------------------------------------
	
	// 정규표현식
	
	$(function() {
	    let checkPasswdResult = false;
	    let checkPasswd2Result = false;
	
	    $("#password").on("input", function() {
	        let passwd = $("#password").val();
	        let msg;
	        let color;
	
	        let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
            let specRegex = /[!@#$%]/;
            
	        if(lengthRegex.exec(passwd) && specRegex.exec(passwd)) {
	            let count = 0;
	            let engUpperRegex = /[A-Z]/;
	            let engLowerRegex = /[a-z]/;
	            let numRegex = /[\d]/;
	
	            if(engUpperRegex.exec(passwd)) { count++; } 
	            if(engLowerRegex.exec(passwd)) { count++; }
	            if(numRegex.exec(passwd)) { count++; }
	            if(specRegex.exec(passwd)) { count++; }
	
	            switch(count) {
	                case 4 : 
// 	                    msg = "안전";
	                    color = "GREEN";
	                    checkPasswdResult = true;
	                    break;
	                case 3 : 
// 	                    msg = "보통";
	                    color = "YELLOW";
	                    checkPasswdResult = true;
	                    break;
	                case 2 : 
// 	                    msg = "위험";
	                    color = "ORANGE";
	                    checkPasswdResult = true;
	                    break;
	                case 1 : 
// 	                    msg = "사용 불가";
	                    color = "RED";
	                    checkPasswdResult = false;
	                    break;
	            }
	       		// 유효한 비밀번호일 경우 테두리 초록색으로 설정
	            $("#password").css("border", "2px solid lightblue");
	            msg = "";
	        } else {
	            $("#password").css("border", "2px solid lightcoral");
	            msg = "영문자, 숫자, 특수문자(!@#$%) 포함 8~16 필수!";
	            color = "lightcoral";
	            checkPasswdResult = false;
	         	// 유효하지 않은 비밀번호일 경우 테두리 빨간색으로 설정
	        }
	
	        $("#checkPasswdResult").text(msg).css("color", color);
	        $("#confirm-password").trigger("input");
	    });
	
	    $("#confirm-password").on("input", function() {
	        let password = $("#password").val();
	        let password2 = $("#confirm-password").val();
	
	        if(password == password2) {
	            $("#checkPasswd2Result").text("");
	            $("#confirm-password").css("border", "2px solid lightblue");
	            checkPasswd2Result = true;
	        } else {
	            $("#checkPasswd2Result").text("비밀번호 불일치").css("color", "lightcoral");
	            checkPasswd2Result = false;
	        }
	    });
	
	    $("#openModal").on("click", function() {
	        let passwd = $("#password").val();
	        let password2 = $("#confirm-password").val();
			let email = $("#email").val();
	        
			if(email == "") {
				alert("이메일을 입력하세요!");
	            $("#email").focus();
			} else if(!checkPasswdResult || passwd === "") {
	            alert("비밀번호를 확인하세요!");
	            $("#password").focus();
	            return false;
	        } else if(!checkPasswd2Result || password2 === "") {
	            alert("비밀번호 확인란을 확인하세요!");
	            $("#confirm-password").focus();
	            return false;
	        } else {
	            $("#termsModal").css("display", "flex");
	        }
	        
	    });
	});

		
		
	//--------------------------------------------------------------------------------------------
		// 모달 열기
// 		document.getElementById("openModal").addEventListener("click", function() {
// 		  document.getElementById("termsModal").style.display = "flex";
// 		});
	
		// 모달 닫기
		document.getElementById("closeModal").addEventListener("click", function() {
		  document.getElementById("termsModal").style.display = "none";
		});
	
		// 모달 바깥 클릭 시 닫기
		window.addEventListener("click", function(event) {
		  const modal = document.getElementById("termsModal");
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		});
		
		// 전체 동의 클릭 시 하위 체크박스 모두 선택/해제
		document.getElementById("agreeAll").addEventListener("change", function() {
		  const checkboxes = document.querySelectorAll('.modal-content input[type="checkbox"]');
		  const isChecked = this.checked; // 전체 동의 체크박스 상태 가져오기
		  
		  checkboxes.forEach(function(checkbox) {
		    checkbox.checked = isChecked; // 전체 동의 체크박스 상태와 동일하게 설정
		  });
		});
		
		 // 확인 버튼을 눌렀을 때 필수 항목을 체크하는 함수
	    document.getElementById('terms-form').addEventListener('submit', function(event) {
	        event.preventDefault(); // 기본 제출 동작을 막음
	
	        const requiredCheckboxes = document.querySelectorAll('.required');
	        let allChecked = true;
	        
	        requiredCheckboxes.forEach(checkbox => {
	            if (!checkbox.checked) {
	                allChecked = false;
	            }
	        });
	        
	        if (!allChecked) {
	            alert('모든 필수 항목에 동의하셔야 합니다.');
	        } else {
	            alert('가입이 완료되었습니다!');
	            // 여기서 form을 실제로 제출하고 싶다면 아래 주석을 해제
	            this.submit();
	        }
	    });
	
		
	</script>
	
</body>
</html>