<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>푸터</title>
    <style>
        
        body {
            font-family: Arial, sans-serif;
        }
        .footer {
            background-color: #f8f8f8;
            padding: 20px;
            font-size: 14px;
            color: #666;
            border-top: 1px solid #ddd;
            margin-top: 20px;
            
        }
        .footer .footer-links, .footer .company-info {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: auto;
            margin-bottom: 1%;
        }
        .footer a {
            text-decoration: none;
            color: #666;
        }
        .footer a:hover {
            color: black;
        }
    </style>
</head>
<body>
    <div class="footer">
        <div class="footer-links">
            <div>
                <strong>정책ㆍ약관</strong> | <a href="#">개인정보처리방침</a>
            </div>
            <div>
                <a href="#">제휴문의</a> | <a href="#">공지사항</a> | <a href="#">와디즈 IR</a> |  <a href="#">SNS</a> | <a href="#">Language</a>
            </div>
        </div>
        <div class="company-info">
            <div>
                <strong>와디즈 고객센터</strong><br>
                 <a href="#">채팅 상담하기</a> | <a href="#">문의 등록하기</a> | <a href="#">도움말 센터 바로가기</a> 
            </div>
            <div>
                <strong>상담 가능 시간</strong><br>
                평일 오전 9시 ~ 오후 6시 (주말, 공휴일 제외)
            </div>
        </div>
        <div class="company-info">
            <div>
                펀디지(주) 대표이사 정세현 | 사업자등록번호 111-11-1111111 | <a href="#">사업자 정보 확인</a> | 통신판매업신고번호 2021-부산서면C-1111
            </div>
            <div>
                Android앱 | iOS앱
            </div>
        </div>
    </div>
</body>
</html>