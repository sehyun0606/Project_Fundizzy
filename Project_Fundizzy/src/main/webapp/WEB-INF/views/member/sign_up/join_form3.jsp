<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizzy Registration</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            width: 400px;
            margin: 0 auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h1 {
            color: #C964D4;
        }
        .social-login button {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .kakao-login {
            background-color: #FEE500;
            color: #000;
        }
        .naver-login {
            background-color: #03C75A;
            color: #fff;
        }
        .email-signup input {
            width: 90%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .email-signup .submit-btn {
            width: 100%;
            padding: 15px;
            background-color: #F3A6E1;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .email-signup .submit-btn:hover {
            background-color: #e18fd2;
        }
        .email-signup .eye-btn {
            position: absolute;
            right: 10px;
            top: 18px;
            cursor: pointer;
        }
        .email-signup .error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
    <script>
        // 비밀번호 보이기/숨기기 기능
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('confirm-password');
            const eyeIcon = document.getElementById('eye-icon');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.innerText = '🙈'; // 아이콘을 바꿈
            } else {
                passwordField.type = 'password';
                eyeIcon.innerText = '👁️';
            }
        }

        // 비밀번호 확인 기능
        function validatePasswords() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const errorMessage = document.getElementById('error-message');

            if (password !== confirmPassword) {
                errorMessage.innerText = '비밀번호가 일치하지 않습니다.';
                return false;
            } else {
                errorMessage.innerText = '';
                return true;
            }
        }

        // 이메일 인증 버튼 클릭 시
        function validateEmail() {
            const email = document.getElementById('email').value;
            const emailError = document.getElementById('email-error');
            
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.innerText = '유효한 이메일 주소를 입력해주세요.';
                return false;
            } else {
                emailError.innerText = '';
                alert('인증 메일이 발송되었습니다.');
                return true;
            }
        }
    </script>
</head>
<body>

<div class="container">
    <h1>Fundizzy</h1>

    <!-- Social Login -->
    <div class="social-login">
        <button class="kakao-login">카카오로 시작하기</button>
        <button class="naver-login">네이버로 시작하기</button>
    </div>

    <!-- Email Sign-Up -->
    <div class="email-signup">
        <input type="email" id="email" placeholder="이메일 입력" required />
        <button class="submit-btn" onclick="validateEmail()">인증</button>
        <span id="email-error" class="error"></span>

        <input type="text" placeholder="닉네임 입력" required />
        <input type="password" id="password" placeholder="비밀번호 입력" required />
        <div style="position: relative;">
            <input type="password" id="confirm-password" placeholder="비밀번호 확인" required />
            <span id="eye-icon" class="eye-btn" onclick="togglePasswordVisibility()">👁️</span> <!-- 비밀번호 보이기 버튼 -->
        </div>
        <span id="error-message" class="error"></span>

        <button class="submit-btn" onclick="return validatePasswords()">약관 동의 후 가입완료 하기</button>
    </div>
</div>

</body>
</html>
