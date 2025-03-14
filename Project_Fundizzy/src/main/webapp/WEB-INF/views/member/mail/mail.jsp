<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정 안내</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .header {
            background-color: #1b1b1b;
            padding: 30px;
            border-radius: 10px 10px 0 0;
        }
        .header h1 {
        	color: mediumpurple;
        }
        .header img {
            width: 150px;
        }
        .button {
            display: inline-block;
            padding: 15px 30px;
            font-size: 16px;
            color: white;
            background-color: #00c4c4;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin-top: 20px;
        }
        .footer {
            font-size: 12px;
            color: gray;
            margin-top: 20px;
        }
        .footer a {
            color: #00a8ff;
            text-decoration: none;
        }
        .notice {
            font-size: 12px;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 상단 헤더 (로고 부분) -->
        <div class="header">
			<h1>Fundizzy</h1>
	        <a href="https://yourdomain.com/reset-password?email=${email}" class="button">비밀번호 등록/변경</a>
        </div>

        <h2 style="color: black;">비밀번호 재설정 안내</h2>
        <p>WADIZ를 이용해 주셔서 감사합니다.</p>
        <p>고객님의 개인정보 보호를 위해 비밀번호를 재설정합니다.<br>아래 버튼을 눌러서 다시 설정해 주세요.</p>

        <!-- 비밀번호 변경 버튼 -->

        <!-- 하단 안내 -->
        <p class="notice">본 메일은 비밀번호 변경을 위해 발송한 전용 메일입니다.<br>
            문의사항은 고객센터로 문의해주세요.</p>

        <p class="footer">
            와디즈(주) | 사업자등록번호 258-87-01370 | 대표 신혜성 | 고객센터 1661-9056 | 
            이메일 <a href="mailto:info@wadiz.kr">info@wadiz.kr</a> | 
            주소 경기 성남시 분당구 판교로 242 PDC A동 402호
        </p>
    </div>
</body>
</html>
