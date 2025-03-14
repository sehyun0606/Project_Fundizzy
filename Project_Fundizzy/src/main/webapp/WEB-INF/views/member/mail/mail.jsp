<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정 안내</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .container { max-width: 600px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; }
        .logo { margin-bottom: 20px; }
        .button { display: inline-block; padding: 15px 30px; font-size: 16px; color: white; background-color: mediumpurple; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .footer { margin-top: 20px; font-size: 12px; color: gray; }
        .footer a { color: #00a8ff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
    	<h1 style="margin-top: 0px; color: mediumpurple">Fundizzy</h1>
        <h2>비밀번호 재설정 안내</h2>
        <p>Fundizzy를 이용해 주셔서 감사합니다.</p>
        <p>고객님의 개인정보 보호를 위해 비밀번호를 재설정합니다.<br>아래 버튼을 눌러서 다시 설정해 주세요.</p>
        <a href="?email=${email}" class="button">비밀번호 등록/변경</a>
        <p class="footer">본 메일은 비밀번호 변경을 위해 발송된 전용 메일입니다.<br>문의사항은 <a href="mailto:info@wadiz.kr">info@wadiz.kr</a>로 문의해 주세요.</p>
    </div>
</body>
</html>
