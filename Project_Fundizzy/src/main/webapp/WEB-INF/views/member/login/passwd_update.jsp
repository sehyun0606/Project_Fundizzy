<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>비밀번호 재설정</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff;
        }
        .container {
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 30px;
            color: mediumpurple;
            text-align: left;
        }
        h2 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: left;
        }
        p {
            font-size: 14px;
            color: gray;
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
        }
        input:focus {
            border-color: #6a5acd;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: mediumpurple;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #6a5acd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">Fundizzy</div>

        <h2>비밀번호 재설정</h2>
        <p>새로 사용하기를 원하는 비밀번호를 입력해 주세요.</p>

        <form action="resetPasswordProcess" method="get">
            <div class="form-group">
            	<input type="text" name="email" value="${param.email}" hidden>
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호 입력" required>
                <div id="checkPasswdResult" style="fo nt-size: 12px;"></div>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
                <div id="checkPasswd2Result" style="font-size: 12px;"></div>
            </div>
            <button type="submit" class="btn">완료</button>
        </form>
    </div>
    <script type="text/javascript">
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
		        $("#confirmPassword").trigger("input");
		    });
	    
		    $("#confirmPassword").on("input", function() {
		        let password = $("#password").val();
		        let password2 = $("#confirmPassword").val();
		
		        if(password == password2) {
		            $("#checkPasswd2Result").text("");
		            $("#confirmPassword").css("border", "2px solid lightblue");
		            checkPasswd2Result = true;
		        } else {
		            $("#checkPasswd2Result").text("비밀번호 불일치").css("color", "lightcoral");
		            checkPasswd2Result = false;
		        }
		    });
	    });
    
    </script>
</body>
</html>
