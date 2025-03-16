<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin 0;
            height: 100vh;
        }
        .container {
            width: 350px;
            padding: 20px;
        }
        h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .info-text {
            font-size: 12px;
            color: gray;
            margin-bottom: 10px;
        }
        .btn {
            width: 107%;
            padding: 12px;
            background-color: #a15ad4;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn:disabled {
            background-color: #d3b8eb;
            cursor: not-allowed;
        }
        .error {
            font-size: 12px;
            color: red;
            display: none;
        }
        .main{
        	display: flex;
        	justify-content: center;
        	align-items: center;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="main">
	    <div class="container">
    		<form action="PasswordSettings" method="post">
		        <h2>비밀번호 변경</h2>
		        <input type="password" id="password" name="passwd" placeholder="비밀번호">
		        <p class="info-text">영문, 숫자, 특수문자(@#$%^&+=)를 모두 조합한 8자 이상</p>
		        <input type="password" id="confirmPassword" placeholder="비밀번호 확인">
		        <p class="error" id="errorMsg">비밀번호가 일치하지 않습니다.</p>
		        <button class="btn" id="submitBtn" disabled>확인</button>
    		</form>
	    </div>
	</div>

    <script>
        function validatePassword() {
            let password = $("#password").val();
            let confirmPassword = $("#confirmPassword").val();
            let passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$/;
            
            if (!passwordRegex.test(password)) {
                $("#errorMsg").text("비밀번호 형식을 확인하세요.").show();
                $("#submitBtn").prop("disabled", true);
                return;
            }

            if (password !== confirmPassword) {
                $("#errorMsg").text("비밀번호가 일치하지 않습니다.").show();
                $("#submitBtn").prop("disabled", true);
            } else {
                $("#errorMsg").hide();
                $("#submitBtn").prop("disabled", false);
            }
        }

        $("#password, #confirmPassword").on("keyup", validatePassword);
    </script>

</body>
</html>
