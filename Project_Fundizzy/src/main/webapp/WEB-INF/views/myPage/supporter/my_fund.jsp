<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>펀딩한 상품</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 60%;
            margin: 0 auto;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .product-box {
            border: 1px solid #c69df1;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            position: relative;
        }
        .category {
            font-size: 14px;
            color: gray;
        }
        .status {
            font-size: 14px;
            color: #8a2be2;
            font-weight: bold;
        }
        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin: 5px 0;
        }
        .company {
            font-size: 14px;
            color: black;
        }
        .payment-info {
            font-size: 14px;
            color: black;
        }
        .refund {
            position: absolute;
            right: 20px;
            bottom: 20px;
            color: #8a2be2;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            text-decoration: none;
            color: black;
            padding: 8px 12px;
            margin: 0 5px;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: black;
            color: white;
        }
        .pagination a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">펀딩한 상품</div>
    
    <div class="product-box">
        <div class="category">펀딩유형/카테고리</div>
        <div class="status">진행여부 표시</div>
        <div class="product-name">프로젝트 명</div>
        <div class="company">by 회사명</div>
        <div class="payment-info">결제방식 체크카드</div>
        <div class="payment-info">결제금액 15,000원</div>
        <div class="refund">환불신청</div>
    </div>

    <div class="product-box">
        <div class="category">펀딩유형/카테고리</div>
        <div class="status">진행여부 표시</div>
        <div class="product-name">프로젝트 명</div>
        <div class="company">by 회사명</div>
        <div class="payment-info">결제방식 체크카드</div>
        <div class="payment-info">결제금액 15,000원</div>
        <div class="refund">환불신청</div>
    </div>

    <div class="product-box">
        <div class="category">펀딩유형/카테고리</div>
        <div class="status">진행여부 표시</div>
        <div class="product-name">프로젝트 명</div>
        <div class="company">by 회사명</div>
        <div class="payment-info">결제방식 체크카드</div>
        <div class="payment-info">결제금액 15,000원</div>
        <div class="refund">환불신청</div>
    </div>

    <div class="pagination">
        <a href="#">← 이전</a>
        <a href="#" class="active">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">...</a>
        <a href="#">7</a>
        <a href="#">8</a>
        <a href="#">다음 →</a>
    </div>
</div>

</body>
</html>
