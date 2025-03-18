<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>펀디즈 고객센터</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .email-container {
            width: 600px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .email-header {
            font-size: 16px;
            font-weight: bold;
            color: black;
        }

        .email-date {
            font-size: 12px;
            color: gray;
            margin-bottom: 10px;
        }

        .email-logo {
            text-align: center;
            margin: 20px 0;
        }

        .email-logo img {
            width: 120px;
        }

        .email-content {
            font-size: 14px;
            line-height: 1.6;
        }

        .email-footer {
            margin-top: 20px;
            padding: 15px;
            background-color: #f1f1f1;
            border-radius: 5px;
            font-size: 12px;
        }

        .email-footer p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="email-container">
        <div class="email-header">(펀디즈 고객센터)</div>
        <div class="email-date">2025년 2월 7일 09:54 GMT+9</div>

        <div class="email-logo" style="font-size: 20px; color: mediumpurple;">
        	Fundizzy
        </div>

        <div class="email-content">
            <p>안녕하세요.</p>
            <p>펀디즈입니다.</p>

            <p></p>

            <p>추가 문의 사항이 있으시면, 언제든지 고객센터로 연락 주시기 바랍니다.</p>
            <p>감사합니다.</p>
            <p><strong>- 펀디즈 드림 -</strong></p>
        </div>

        <div class="email-footer">
            <p><strong>펀디즈 고객센터</strong></p>
            <p>운영 시간: 평일 오전 9시 ~ 오후 6시</p>
            <p>📍 부산광역기 동천로 199 삼한골든게이트 7층 펀디즈</p>
        </div>
    </div>
</body>
</html>
